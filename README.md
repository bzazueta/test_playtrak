# test_playtrack
Este repositorio es un ejemplo  profesional de una aplicación para el proceso de selección de desarrollador movil
en playtrak esta aplicación contiene un CRUD el cual permite realizar operaciones como Crear, leer, actualizar y 
eliminar datos a través de de API en PHP la cual tengo en un servidor expuesto(HOSTGATOR). se eligio esta tecnología 
para poder consultar los datos de manera remota.

# Flutter CRUD App con API, Dio, GetX y Modelos

Este es un ejemplo profesional de arquitectura MVC en Flutter con:
- View o Paginas (StatefulWidget y StatelessWidget)
- GetX (estado y navegación)
- Navigation (navegación)
- Dio (API)
- json_serializable (modelos)

## 🧱 Arquitectura y Estructura MVC

- `api/`: configuración url
- `models/`: modelos tipo ORM
- `views/`: pantallas UI
- `controllers/`: lógica de negocio
- `services/`: servicios API

## 📦 Dependencias en pubspec.yaml:
dependencies:
  flutter:
  sdk: flutter
    dio: ^5.8.0+1 -> Cliente HTTP para peticiones a la API REST
    get: ^4.7.2 -> estión de estado reactiva y navegación
    image_picker: ^0.8.5+3 -> Nos permite realizar capturas de imagenes con el dispositivo
    sn_progress_dialog: ^1.2.0 -> Nos permite mostrar un dialogo al usuario mientras esta realizando una operación
    permission_handler: ^12.0.0+1 -> Permite al usuario dar permisos en tiempo de ejecución
    cupertino_icons: ^1.0.8 ->Habilta los componentes de cupertino

## 🛠️ Tecnologías utilizadas
Tecnología	Descripción
- Flutter	Framework principal de desarrollo móvil
- Dio	Cliente HTTP para peticiones a la API REST
- GetX	Gestión de estado reactiva y navegación
- json_serializable	Serialización de modelos (tipo ORM)
- setState Gestión de estado puntual dentro de widgets

## 🔄 Funcionalidades CRUD
✅ Leer: Listado de elementos desde la API

➕ Crear: Formulario para agregar nuevos datos

✏️ Actualizar: Edición de elementos existentes

🗑️ Eliminar: Eliminación de elementos con confirmación

## 🚀 Guía de Implementación para el Equipo de Operaciones
1. Requisitos previos
- Asegurate de tener instalado en la máquina:
- Flutter SDK (versión estable)
- Android Studio o VS Code
- Emulador Android o conexión a dispositivo físico
- Git (si van a clonar el repositorio)
- Google Chrome (para ejecución web)

📦 2. Clonar el proyecto
    git clone https://github.com/bzazueta/test_playtrak.git
    cd tu-ruta-repo-flutter  

📥 3. Instalar dependencias
    flutter pub get

⚙️ 4. Configurar entorno (si aplica)
    
   🛠 PASO 1: Descargar Flutter SDK
       Ve a la página oficial:
       👉 https://flutter.dev/docs/get-started/install/windows
        Descarga el archivo .zip del SDK para Windows.
        Extrae el contenido en una carpeta, por ejemplo:
        C:\src\flutter

   🧩 PASO 2: Configurar la variable de entorno Path
      Presiona Win + S y busca "Editar las variables de entorno del sistema".
      En la ventana, haz clic en el botón "Variables de entorno…".
      En la sección de Variables del sistema, selecciona Path y haz clic en Editar.
      Agrega una nueva entrada con la ruta del folder bin de Flutter, por ejemplo:
      C:\src\flutter\bin

   🔄 PASO 3: Verificar instalación
      Abre una nueva ventana de PowerShell, CMD o terminal en VS Code o Android studio.
      ejecuta el comando flutter doctor si todo esta correctamente instaldo deberias ver todas las opciones con el icono check.
      
      Doctor summary (to see all details, run flutter doctor -v):
      [✓] Flutter (Channel stable, 3.x.x, on Microsoft Windows)
   
   ✅ Final
      Ahora ya puedes correr flutter, flutter create, flutter run, etc. desde cualquier terminal. Si usas VS Code o Android Studio,
      reinicia el IDE para que reconozca el cambio.

📱 5. Ejecutar en un dispositivo móvil Para Android en la terminal:
      flutter run
      Para iOS :
      flutter run -d ios


