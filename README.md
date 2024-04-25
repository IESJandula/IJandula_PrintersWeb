Windows
 
Necesario para arrancar la web:
1. Descargar el instalador de ruby en https://www.ruby-lang.org/es/downloads/
   1. Versión de ruby para nuestro proyecto 3.2.3
2. Instalar Rails
   1. Para ello en consola de comandos gem install rails 7.1.3.2 
Para iniciar la web:
1. Ejecutar el siguiente comando bundle install --gemfile “ruta del Gemfile”   Ejemplo:(src\main\resources\static\printers\Gemfile)
2. Compilar el proyecto con bundle exec rails assets:precompile
3. Usar el comando dentro de la carpeta del proyecto rails s para iniciar la web
