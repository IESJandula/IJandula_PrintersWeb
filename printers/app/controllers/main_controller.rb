require 'json'
# Main controller 
class MainController < ApplicationController
  before_action :authenticate_user!

  SERVER_PORT = "http://localhost:8082/"
  def user
    # session[:user] = params[:username]
    session[:user] = current_user.email
    # session[:rol] = params[:rol]
    if current_user.admin
      session[:rol] = "admin"
    end
    p session[:user]
    p session[:rol]
    Filter.destroy_by(by: session[:user])
    Filter.create(printer_name: "", num_copies: nil, color: "", orientation: "", faces: "", user: "", status: "", by: session[:user])
    redirect_to home_path
  end

  def adminWindow
    p "-"*100
    p session[:user]
    p session[:password]
    p "-"*100

    getUsers
    getPrinters
    
    PrintInfo.destroy_all
    begin
      @fill = Filter.find_by(by: session[:user])
      response = RestClient.get(
        SERVER_PORT + "get/user/prints",
        params: {user: @fill.user, printerName: @fill.printer_name, numCopies: @fill.num_copies, 
        color: @fill.color, orientation: @fill.orientation, faces: @fill.faces, status: @fill.status }
      )

      puts response.body  
      
      info = JSON.parse(response)
      info.each do |json_data|
        PrintInfo.create!(
          java_id: json_data['id'],
          file_name: json_data['fileName'],
          printer_name: json_data['printerName'],
          num_copies: json_data['numCopies'],
          color: json_data['color'],
          orientation: json_data['orientation'],
          status: json_data['status'],
          faces: json_data['faces'],
          user: json_data['user'],
          date: json_data['date']
        )
      end

      puts @parsed_data
      puts response.code
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
    end
    
    @info = PrintInfo.all

  end

  # postPdf control 
  def postPdf
    if params[:exampleFormControlFile1].present?

      # The file content from the web form
      @file = params[:exampleFormControlFile1]
      # The printer name from the web form
      @printer = params[:selected_option]
      # The number of copies from the web form
      @numCopies = params[:integer_selector]
      # The color of the copies from the web form
      @color = params[:selected_color]
      # The orientation of the copies from the web form
      @orientation = params[:selected_orientation]
      # The faces of copies from the web form
      @faces = params[:selected_both]

      # Ensure @file is an UploadedFile object
      if @file.is_a?(ActionDispatch::Http::UploadedFile)
        begin
          response = RestClient.post(
            SERVER_PORT + "print",
            { file: @file, printerName: @printer, numCopies: @numCopies, color: @color, orientation: @orientation, faces: @faces, user: session[:user] },
            multipart: true
          )
          puts @result
          puts response.code

        rescue RestClient::ExceptionWithResponse => e
          puts "Error: #{e.response}"
        end
      else
        puts "Invalid file format or file missing"
      end
      redirect_to home_path
    else
      puts "No se realizo la petición, parametro vacio"
      redirect_to "/uploadPdf", notice: "No has subido un archivo pdf."     
    end
  end
    
  # home control logic
  def home
    p '------------------------------------------------------------------------------------------------------------'
    p session[:user]
    p session[:password]
    getPrinters
    PrintInfo.destroy_all
    begin
      @fill = Filter.find_by(by: session[:user])
      response = RestClient.get(
        SERVER_PORT + "get/user/prints",
        params: {user: session[:user], printerName: @fill.printer_name, numCopies: @fill.num_copies, 
        color: @fill.color, orientation: @fill.orientation, faces: @fill.faces, status: @fill.status }
      )

      puts response.body  
      
      info = JSON.parse(response)
      info.each do |json_data|
        PrintInfo.create!(
          java_id: json_data['id'],
          file_name: json_data['fileName'],
          printer_name: json_data['printerName'],
          num_copies: json_data['numCopies'],
          color: json_data['color'],
          orientation: json_data['orientation'],
          status: json_data['status'],
          faces: json_data['faces'],
          user: json_data['user'],
          date: json_data['date']
        )
      end

      puts @parsed_data
      puts response.code
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
    end
    
    @info = PrintInfo.all

  end
  
  # uploadPdf control logic
  def uploadPdf   
    getPrinters
  end

  def pdfByName
    url = SERVER_PORT + "get/document"
    begin
      response = RestClient.get(
        url,
        params: {id: params[:id]}
      ) 
      @result = response.body
      
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
    end    
  end

  def deleteDate
    begin
      response = RestClient.post(
        SERVER_PORT + "admin/delete/print_actions",
        { date: params[:selected_date], status: params[:selected_status] }
      )
      p 'M'*100 
      p params[:selected_date]
      p params[:selected_status]
      p response.body  

    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
    end
    redirect_to "/adminWindow"
  end

  def deleteWindow
  end
    
  def fill
    Filter.destroy_by(by: session[:user])
    p 'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh   '
    p params
    Filter.create!(
      printer_name: params[:selected_option],
      num_copies: params[:integer_selector],
      color: params[:selected_color],
      orientation: params[:selected_orientation],
      faces: params[:selected_both],
      status: params[:selected_status],
      by: session[:user],
      user: params[:user],    
    )
    redirect_to "/home"  
  end

  def fillAdmin
    Filter.destroy_by(by: session[:user])
    p 'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh   '
    p params
    Filter.create!(
      printer_name: params[:selected_option],
      num_copies: params[:integer_selector],
      color: params[:selected_color],
      orientation: params[:selected_orientation],
      faces: params[:selected_both],
      status: params[:selected_status],
      by: session[:user],
      user: params[:selected_user],    
    )
    redirect_to "/adminWindow"  
  end

  def reset
    Filter.destroy_by(by: session[:user])
    Filter.create(printer_name: "", num_copies: nil, color: "", orientation: "", faces: "", user: "", status: "", by: session[:user])
    redirect_back(fallback_location: root_path)
  end

  def getPrinters
    url = SERVER_PORT + "get/printers"
    begin
      response = RestClient.get(
        url
      ) 
      @result = JSON.parse(response.body)
      p @result
      puts response.code
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
    end    
  end

  def getUsers
    url = SERVER_PORT + "get/users"
    begin
      response = RestClient.get(
        url
      ) 
      p "y"*100
      p response.body
      @users = JSON.parse(response.body)
      p @users
      puts response.code
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
    end    
  end
end
