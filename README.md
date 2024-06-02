REMOTE PRINTER WEB
----------- INFORMACIÓN -----------
Este proyecto se basa en una página web orientada al cuerpo docente del centro, que permite de manera sencilla y remota imprimir un PDF desde cualquier lugar y dispositivo. La web está desarrollada en Ruby on Rails y cuenta con funcionalidades principales como un sistema propio de inicio de sesión y creación de usuarios.

El usuario promedio puede acceder a la impresión remota con selección de impresora, así como especificar el número de caras, color, número de copias y orientación. Como incorporación importante, se ha añadido un estado de la impresora que cambia dinámicamente dependiendo de la impresora seleccionada. Además, toda la información sobre las impresiones se muestra en el índice con un buscador por todos sus atributos, lo que permite filtrar según las necesidades del usuario.
En caso de querer recuperar un pdf ya enviado se puede clicar encima del nombre de este en el indice para ir a una pantalla que lo mostrara y permitira descargarlo.

El administrador cuenta con las mismas funcionalidades, pero también tiene acceso a un apartado donde puede ver y filtrar las impresiones de todos los usuarios para llevar una gestión de la base de datos, incluyendo la capacidad de borrar datos según el estado de la impresión y la fecha.

----------- WINDOWS -----------
Pasos necesarios para iniciar la web:

Descargar e instalar Ruby desde https://www.ruby-lang.org/es/downloads/
La versión de Ruby necesaria para nuestro proyecto es 3.2.3
Instalar Rails
Esto se realiza mediante la consola de comandos con el comando 'gem install rails 7.1.3.2'
Para iniciar la web:
Ejecutar el siguiente comando _**'bundle install --gemfile “ruta del Gemfile” **_ Ejemplo:(src\main\resources\static\printers\Gemfile)
Compilar el proyecto con _**'bundle exec rails assets'**_
Usar el comando 'rails s' dentro de la carpeta del proyecto para iniciar la web
----------- CREACIÓN DE USUARIOS -----------
ADMINISTRADOR:
Para crear un usuario administrador, es necesario hacerlo mediante la consola de Rails:
1. Ejecutar en la consola_ **'rails c'**_. Esto abrirá una consola de Rails para la gestión de la base de datos.
2. Utilizar este código, modificando la información según sea necesaria:
_**'User.create(email: "user@example.com", admin: true, password: "password123", password_confirmation: "password123")'**_

USUARIO NORMAL:
Se ha preparado un archivo users.json en la ruta 'db\data\users.json' con los correos electrónicos y contraseñas de los usuarios que contendrá la base de datos. Cada vez que se añadan nuevos usuarios, se debe ejecutar el siguiente comando en la consola desde la carpeta del proyecto para cargarlos en la base de datos:
_** 'rake import'**_
