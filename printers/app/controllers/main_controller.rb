
# Main controller 
class MainController < ApplicationController
  
  def user
    $user = params[:username]
    redirect_to home_path
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
            "http://localhost:8081/print",
            { file: @file, printerName: @printer, numCopies: @numCopies, color: @color, orientation: @orientation, faces: @faces, user: $user },
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
    begin
      response = RestClient.get(
        "http://localhost:8081/get/user/prints",
        params: {user: $user}
      ) 
      @info = PrintAction.from_json!(response.body)
      puts @info
      puts response.code
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
    end
  end
  
  # uploadPdf control logic
  def uploadPdf   
    url = "http://localhost:8081/get/printers"
    begin
      response = RestClient.get(
        url
      ) 
      @result = JSON.parse(response.body)
      puts @result
      puts response.code
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
    end    
  end

  def pdfByName
    url = "http://localhost:8081/get/document"
    begin
      response = RestClient.post(
        url,
        params: {id: params[:id]}
      ) 
      @result = JSON.parse(response.body)
      puts @result
      puts response.code
      redirect_to home_path
    rescue RestClient::ExceptionWithResponse => e
      puts "Error: #{e.response}"
    end    
  end

end