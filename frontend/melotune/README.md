# MeloTune - (TFG)

## Tecnologías Utilizadas

- **Framework:** Angular 19.
- **Estilos / UI:** Bootstrap 5 (vía CDN) + Tema y variables CSS a medida.
- **Iconografía:** FontAwesome 6.
- **Tipografía:** Outfit (Google Fonts).

## Requisitos previos

Para poder ejecutar este proyecto en tu máquina local, necesitarás tener instalado:
- [Node.js](https://nodejs.org/) (versión v18 o superior recomendada).
- [npm](https://www.npmjs.com/) (Gestor de paquetes que se instala junto a Node).

## Instrucciones de instalación y ejecución

Sigue estos pasos para arrancar el entorno de desarrollo y visualizar el proyecto:

1. **Abrir la terminal en este directorio**
   Asegúrate de que estás en la ruta `frontend/melotune` dentro de tu proyecto.

2. **Instalar dependencias**
   Ejecuta el siguiente comando para descargar los paquetes necesarios alojados en `package.json` o `pnpm-lock.yaml`. Angular descargará sus librerías de infraestructura:

   npm install


3. **Iniciar el servidor web local**
   Una vez concluida la instalación, inicia el servidor de desarrollo de Angular:

   npm start


4. **Visualizar la página**
   Abre una pestaña en tu navegador web de preferencia (Chrome, Firefox, Safari) y dirígete a:
   [http://localhost:4200/](http://localhost:4200/)

   Deberia aparecer la pagina principal

## Consideraciones sobre la versión actual

- **Archivos Estáticos (`public/`):** El logotipo principal del menú de navegación (`logo.png`) se almacena en la carpeta `public/`.
- **Para las imagenes** he utilizado una pagina para poner imagenes de texto plano llamado "placehold" lo sustituire por imagenes reales cuando tenga la api
- **Siguiente Fase:** La futura integración consistirá en solicitar esos datos vía `HttpClient` hacia la API en Laravel correspondiente que ya ha sido diseñada.
