# Notebook

Notebook es una aplicación Flutter para gestionar notas personales, ideas y tareas, con soporte para adjuntos y categorización.

## Características

Con esta app tu puedes:
- Crear, editar y eliminar notas
- Adjuntar archivos a las notas
- Categorizar notas por tipo (personal, trabajo, ideas, otros)
- Persistencia local con SQLite
- Navegación moderna con go_router
- Gestión de estado con Provider y MVVM

## Estructura del proyecto

```
lib/
└── src/
    ├── domain/
    │   └── models/              # Modelos de datos
    │
    ├── data/
    │   ├── services/
    │   │   └── local/           # Acceso a base de datos SQLite
    │   │
    │   └── repositories/        # Repositorios de datos
    │
    ├── ui/
    │   ├── view_models/         # Lógica de presentación
    │   ├── pages/               # Páginas principales
    │   └── widgets/             # Widgets reutilizables
    │
    └── config/                  # Configuración general
```

## Acerca del proyecto

El proyecto está desarrollado con una arquitectura **Model-View-ViewModel (MVVM)** dividida en tres capas principales:

- **Capa de UI:** Proporciona las vistas del proyecto a través de las `View` (`pages`). La lógica y estado de estas vistas (listar, agregar, editar y eliminar) se manejan mediante el `ViewModel`.  
- **Capa de Data:** Proporciona los datos necesarios para el funcionamiento de la aplicación. Está compuesta por:  
  - **Repositorios:** Definen interfaces que exponen la información en un formato que el `ViewModel` puede consumir. Cada repositorio cuenta con su implementación concreta según el servicio utilizado.  
  - **Servicios:** Contienen la lógica para acceder a los datos en bruto desde su fuente de almacenamiento. En este caso, toda la data proviene de una base de datos SQLite local.  
- **Capa de Dominio:** Define los modelos de datos que se usan entre capas, asegurando consistencia y claridad en el intercambio de información.
<img width="929" height="194" alt="Captura de pantalla 2025-09-24 a las 6 14 26 p  m" src="https://github.com/user-attachments/assets/e404cee0-ef0c-4a61-8d32-b1e7a44f11b9" />

Este proyecto sigue los **principios SOLID** para mantener un diseño escalable y de fácil mantenimiento. En la implementación:
- **S (Single Responsibility Principle):** Cada capa (modelos, servicios, repositorios, view models y vistas) tiene una única responsabilidad claramente definida, evitando mezclar lógica de negocio con lógica de presentación.
- **O (Open/Closed Principle):** Los componentes están diseñados para ser extendidos sin necesidad de modificar su código base, por ejemplo, al agregar un nuevo repositorio o servicio.
- **L (Liskov Substitution Principle):** Las abstracciones (interfaces en repositorios) permiten reemplazar implementaciones concretas sin afectar el funcionamiento del sistema.
- **I (Interface Segregation Principle):** Se crean interfaces específicas para cada repositorio o servicio, evitando que las clases dependan de métodos que no utilizan.
- **D (Dependency Inversion Principle):** La UI depende de abstracciones y no directamente de las implementaciones de los repositorios o servicios, lo cual facilita la inyección de dependencias y las pruebas unitarias.


## Tecnologías utilizadas

- **[Flutter](https://flutter.dev/):** Framework para el desarrollo multiplataforma.  
- **[Provider](https://pub.dev/packages/provider):** Manejo de estado e inyección de dependencias en la capa de UI, fomentando el desacoplamiento.  
- **[go_router](https://pub.dev/packages/go_router):** Gestión de navegación moderna y declarativa dentro de la aplicación.  
- **[sqflite](https://pub.dev/packages/sqflite):** Manejo de base de datos SQLite local para persistencia de datos.  

## Instalación

1. Clona el repositorio:
   ```sh
   git clone https://github.com/tu_usuario/notebook.git
   cd notebook
   ```
2. Instala las dependencias:
   ```sh
   flutter pub get
   ```
3. Ejecuta la aplicación:
   ```sh
   flutter run
   ```

## Requisitos

- Flutter SDK >= 3.9.2
- Dart >= 3.9.2

## Licencia

Este proyecto está bajo la licencia MIT.
