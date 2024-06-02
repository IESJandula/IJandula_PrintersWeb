## Remote Printer Web

### Información
Este proyecto consiste en una página web dirigida al cuerpo docente del centro, que permite imprimir un PDF de forma remota y sencilla desde cualquier lugar y dispositivo. La aplicación web está desarrollada en Ruby on Rails y cuenta con las siguientes características principales:

- Sistema de inicio de sesión y creación de usuarios.
- Impresión remota con selección de impresora, número de caras, color, número de copias y orientación.
- Estado de la impresora que cambia dinámicamente según la selección.
- Visualización de toda la información sobre las impresiones en el índice, con un buscador por todos sus atributos para filtrar según las necesidades.
- Recuperacion y visualización del pdf impreso clicando en su nombre desde el indice.

Además, los administradores tienen acceso a un apartado donde pueden ver y filtrar las impresiones de todos los usuarios, lo que permite una gestión de la base de datos, incluyendo la capacidad de borrar datos según el estado de la impresión y la fecha.

### Requisitos para Windows
Para iniciar la web, siga estos pasos:

1. Descargue e instale Ruby desde [ruby-lang.org](https://www.ruby-lang.org/es/downloads/).
   - Versión de Ruby requerida para nuestro proyecto: **3.2.3**
2. Instale Rails utilizando la consola de comandos con el siguiente comando:
gem install rails 7.1.3.2

Para iniciar la web:
1. Ejecute el siguiente comando para instalar las gemas necesarias:
`bundle install --gemfile “ruta del Gemfile`
Ejemplo: `src\main\resources\static\printers\Gemfile`
2. Compile el proyecto con el siguiente comando:
`bundle exec rails assets`

3. Utilice el comando `rails s` dentro de la carpeta del proyecto para iniciar la web.

### Creación de Usuarios
#### Administrador:
Para crear un usuario administrador, siga estos pasos:

1. Ejecute en la consola `rails c`. Esto abrirá una consola de Rails para la gestión de la base de datos.
2. Utilice el siguiente código, modificando la información según sea necesaria:
`User.create(email: "user@example.com", admin: true, password: "password123", password_confirmation: "password123")`

#### Usuario Normal:
Se ha proporcionado un archivo users.json en la ruta `db\data\users.json` con los correos electrónicos y contraseñas de los usuarios que contendrán la base de datos. Cada vez que se añadan nuevos usuarios, ejecute el siguiente comando en la consola desde la carpeta del proyecto para cargarlos en la base de datos:
`rake import:users`
