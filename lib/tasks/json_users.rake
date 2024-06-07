namespace :import do
  desc "Import users from a JSON file"
  task users: :environment do
    require 'json'

    file_path = Rails.root.join('db', 'data', 'users.json')

    if File.exist?(file_path)
      file = File.read(file_path)
      users = JSON.parse(file)

      users.each do |user_data|
        email = user_data['email']
        password = user_data['password']

        User.create(email: email, password: password) # Devise will handle password encryption
      end

      puts "Users imported successfully!"
    else
      puts "File not found: #{file_path}"
    end
  end
end
