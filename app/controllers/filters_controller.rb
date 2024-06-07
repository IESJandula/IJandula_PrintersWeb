class FiltersController < ApplicationController  
SERVER_PORT = "http://localhost:8082/"
   def index
        
        url = SERVER_PORT + "get/printers"
        texto = ""
        queue = ""
        begin
            response = RestClient.get(url)
            @result = JSON.parse(response.body)
            @result.each do |printer|
                if printer['name'] == params[:printerId]
                    texto = "Estado: #{printer['status']}"
                    queue = "Cola de impresión: #{printer['printingQueue']}"
                end
        end
        rescue RestClient::ExceptionWithResponse => e
            puts "Error: #{e.response}"
        end
        
        render json: { texto: texto, queue: queue  } 
        
    end
end