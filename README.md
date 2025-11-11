# Aprendo Jugando 🎓
## Aplicación Educativa Interactiva para Niños de Primaria

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

---

## 📱 Estado Actual del Proyecto

**Versión actual:** MVP Beta 1.0
**Última actualización:** Noviembre 2025

### ✅ Implementado Recientemente

#### 🎨 Rediseño UX/UI Minimalista
- **Paleta de colores renovada:** Diseño minimalista con colores pastel elegantes y claros
  - Azul pastel sereno (#7AA5E8), Verde menta suave (#81C995), Rosa pastel (#E89BB5)
  - Lavanda suave (#B49CDC), Azul cielo claro (#81CDE6), Melocotón suave (#FFAA8A)
- **Tipografía moderna:** Cambio de Comic Neue a Poppins (títulos) e Inter (cuerpo de texto)
- **Componentes rediseñados:**
  - Tarjetas limpias con bordes sutiles (sin sombras pesadas)
  - Botones minimalistas sin elevación
  - Espaciado amplio y aireado
  - Navegación simplificada y elegante

#### 📚 Contenido Educativo Expandido
- **Total de actividades:** 70 actividades (anteriormente 59)
- **Nuevas actividades agregadas:**
  - **Lectoescritura (topic4):** 6 actividades nuevas (anteriormente 0)
    - Reconocer vocales y consonantes
    - Formar sílabas simples
    - Leer palabras de 2 sílabas
    - Escribir palabras completas
    - Leer oraciones simples
  - **Suma y Resta (topic1):** 2 actividades adicionales
    - Problemas con dinero
    - Operaciones con decenas
  - **Comprensión Lectora (topic5):** 3 historias nuevas
    - "El Perro y el Gato"
    - "El Día de Lluvia"
    - "La Fiesta de Cumpleaños"

### 📊 Estadísticas del Proyecto

| Métrica | Valor |
|---------|-------|
| **Actividades totales** | 70 |
| **Temas educativos** | 7 temas (4 matemáticas, 3 lengua) |
| **Pantallas implementadas** | 12 pantallas |
| **Modelos de datos** | 6 modelos principales |
| **Líneas de código** | ~5,000+ líneas |
| **Paleta de colores** | 12 colores minimalistas |
| **Fuentes tipográficas** | 2 familias (Poppins, Inter) |

### 🎯 Distribución de Actividades por Tema

| Tema | ID | Actividades | Estado |
|------|----|-----------|----|
| Suma y Resta | topic1 | 4 | ✅ Mejorado |
| Multiplicación | topic2 | 16 | ✅ Completo |
| División | topic2b | 10 | ✅ Completo |
| Fracciones | topic3 | 10 | ✅ Completo |
| **Lectoescritura** | **topic4** | **6** | **✅ NUEVO** |
| Comprensión Lectora | topic5 | 4 | ✅ Mejorado |
| Ortografía | topic6 | 10 | ✅ Completo |
| Gramática | topic7 | 10 | ✅ Completo |

### 🚀 Características Principales

- ✅ Sistema de autenticación con perfiles de niños y padres
- ✅ Dashboard interactivo para niños con gamificación
- ✅ Sistema de niveles, puntos y monedas
- ✅ Racha de días consecutivos
- ✅ 70 actividades educativas tipo quiz
- ✅ Feedback inmediato en respuestas
- ✅ Sistema de pistas para cada pregunta
- ✅ Panel de progreso para padres
- ✅ Diseño responsivo y minimalista
- ✅ Animaciones suaves y transiciones elegantes

---

## 📖 Especificación Técnica Completa

### 1. Resumen Ejecutivo

Este documento proporciona la especificación técnica completa para desarrollar "Aprendo Jugando", una aplicación educativa móvil multiplataforma destinada a reforzar conocimientos de matemáticas y lengua en estudiantes de primaria. El proyecto utiliza Flutter como framework de desarrollo con arquitectura Provider, implementando un diseño minimalista moderno enfocado en la usabilidad y experiencia del usuario.

**Estado del MVP:** El proyecto ha alcanzado un estado funcional completo con diseño minimalista renovado y contenido educativo expandido. Actualmente utiliza datos mock locales, listo para integración con backend cuando sea requerido.

---

## 2. Análisis del Proyecto

### 2.1 Objetivos Principales

La aplicación tiene como objetivo principal transformar el aprendizaje tradicional en una experiencia interactiva y motivadora. Se busca que los estudiantes desarrollen habilidades académicas de forma autónoma mientras mantienen alto nivel de engagement mediante mecánicas de gamificación. Paralelamente, padres y educadores contarán con herramientas de seguimiento que les permitirán monitorear progreso, identificar fortalezas y detectar áreas que requieren atención adicional.

### 2.2 Usuarios Objetivo

El sistema contempla tres perfiles de usuario distintos. Los niños de primaria, entre 6 y 12 años, constituyen los usuarios principales que interactuarán directamente con actividades educativas y juegos. Los padres o tutores necesitarán acceso a dashboards informativos, reportes de progreso y configuraciones de perfiles infantiles. Los educadores, como usuarios opcionales en versiones futuras, podrían utilizar la plataforma para complementar enseñanza tradicional y analizar desempeño grupal.

### 2.3 Alcance del MVP

El producto mínimo viable se enfocará en funcionalidades esenciales que demuestren valor inmediato. Incluirá sistema de autenticación robusto con perfiles diferenciados, contenido educativo base cubriendo tres temas de matemáticas y tres de lengua para grados segundo y tercero, cinco tipos de actividades interactivas, sistema de gamificación básico con puntos y niveles, evaluación automática con feedback inmediato, y reportes simples de progreso para padres.

---

## 3. Stack Tecnológico Definitivo

### 3.1 Frontend: Flutter

Flutter se selecciona como framework principal por su capacidad de compilar a código nativo para iOS y Android desde una única base de código Dart. Esta decisión estratégica permite maximizar eficiencia de desarrollo, reducir costos de mantenimiento, y garantizar experiencia consistente en ambas plataformas. Flutter ofrece rendimiento excepcional con animaciones fluidas a 60fps o superior, crucial para aplicaciones educativas infantiles que requieren interfaces responsivas y visualmente atractivas.

El hot reload de Flutter acelera dramáticamente el ciclo de desarrollo, permitiendo ver cambios instantáneamente sin perder estado de la aplicación. Esta característica resulta invaluable al iterar sobre diseños de interfaces, ajustar animaciones, y refinar experiencia de usuario basándose en feedback. El ecosistema de paquetes pub.dev proporciona miles de bibliotecas especializadas para prácticamente cualquier funcionalidad requerida, desde animaciones complejas hasta integración con servicios backend.

### 3.2 Lenguaje: Dart

Dart, el lenguaje oficial de Flutter, combina sintaxis moderna y clara con tipado estático que previene errores en tiempo de compilación. Su modelo de programación orientada a objetos facilita organizar código en estructuras mantenibles y escalables. La compilación anticipada de Dart genera código máquina nativo altamente optimizado, eliminando necesidad de intérpretes o puentes de comunicación que degradan rendimiento en otras soluciones multiplataforma.

### 3.3 Gestión de Estado

Provider se implementará como solución principal de gestión de estado, respaldado oficialmente por el equipo de Flutter. Provider simplifica compartir datos entre widgets mediante patrón observer, permitiendo actualizar interfaces reactivamente cuando datos cambian. Su integración natural con el árbol de widgets de Flutter y curva de aprendizaje moderada lo hacen ideal para proyectos de mediana complejidad.

GetX se considerará como complemento para navegación y gestión de dependencias, ofreciendo sintaxis minimalista que reduce código boilerplate significativamente. Bloc permanecerá como opción para módulos que requieran lógica de negocio compleja con separación estricta entre presentación y lógica.

### 3.4 Backend: Node.js con Express

Node.js proporciona entorno de ejecución JavaScript en servidor, permitiendo manejar múltiples conexiones concurrentes eficientemente mediante modelo asíncrono no bloqueante. Esta característica resulta ideal para aplicaciones que requieren servir contenido simultáneamente a muchos usuarios. Express, framework web minimalista, simplifica creación de APIs RESTful estructuradas con rutas, middleware y manejo de peticiones HTTP.

TypeScript se incorporará en el backend para añadir tipado estático sobre JavaScript, mejorando mantenibilidad del código y previniendo errores comunes. El autocompletado inteligente y refactorización segura que proporciona TypeScript aumentan productividad del equipo de desarrollo.

### 3.5 Base de Datos: MongoDB

MongoDB, base de datos NoSQL orientada a documentos, almacena información en formato BSON similar a JSON. Su modelo de datos flexible permite evolucionar esquemas sin migraciones complejas, adaptándose perfectamente a aplicaciones donde diferentes entidades pueden tener estructuras variables. Las actividades educativas, perfiles de usuario, y datos de progreso encuentran representación natural en documentos MongoDB.

MongoDB Atlas proporcionará hosting gestionado en la nube, eliminando complejidad de administración de servidores. Atlas ofrece backups automáticos, monitoreo integrado, escalamiento sencillo mediante sharding si el crecimiento lo requiere, y tier gratuito generoso suficiente para validar el MVP con usuarios iniciales.

Mongoose actuará como ODM (Object Document Mapper) para Node.js, proporcionando capa de abstracción con esquemas estructurados, validación de datos integrada, y consultas tipadas que simplifican interacción con MongoDB.

### 3.6 Cache: Redis

Redis se implementará como base de datos en memoria para cache y gestión de sesiones. El caching agresivo de contenido educativo frecuentemente accedido reducirá latencia y carga en base de datos principal. Las sesiones de usuario con tokens JWT se almacenarán en Redis para validación rápida. La limitación de tasa para prevenir abuso de APIs se implementará mediante contadores Redis con expiración automática.

### 3.7 Autenticación y Seguridad

JSON Web Tokens (JWT) manejarán autenticación stateless. Tras login exitoso, el servidor emitirá token firmado conteniendo información básica del usuario que el cliente incluirá en headers de peticiones subsecuentes. El sistema implementará access tokens de corta duración (15-30 minutos) y refresh tokens de larga duración (7 días) para balancear seguridad y conveniencia.

bcrypt cifrará contraseñas mediante hashing unidireccional con salt aleatorio antes de almacenamiento en base de datos. Helmet configurará cabeceras HTTP de seguridad automáticamente, protegiendo contra vulnerabilidades comunes como XSS, clickjacking y MIME sniffing. Express-rate-limit prevendrá ataques de fuerza bruta limitando número de requests por IP en ventana de tiempo.

### 3.8 Almacenamiento Multimedia

Firebase Storage almacenará todos los recursos multimedia: imágenes de actividades, avatares personalizables, iconos, efectos de sonido, música de fondo, y animaciones. Firebase proporciona CDN global automático garantizando entrega rápida independientemente de ubicación geográfica del usuario. El SDK de Flutter se integra nativamente, simplificando operaciones de subida y descarga.

Cloudinary se considerará como alternativa, especialmente para imágenes que requieran transformaciones dinámicas. Cloudinary permite redimensionar, recortar y optimizar imágenes on-the-fly mediante parámetros en URL, reduciendo tamaño de descarga en dispositivos con pantallas pequeñas o conexiones lentas.

### 3.9 Notificaciones Push

Firebase Cloud Messaging (FCM) implementará notificaciones push multiplataforma desde una API unificada. FCM soporta iOS y Android, permite enviar recordatorios de práctica diaria, alertas cuando se desbloquean logros, y notificaciones a padres sobre hitos alcanzados o periodos prolongados sin actividad. Flutter Local Notifications generará notificaciones locales programadas en dispositivo sin requerir conexión a internet.

### 3.10 Monitoreo y Analytics

Firebase Analytics rastreará eventos críticos de uso: sesiones, tiempo en aplicación, actividades iniciadas y completadas, puntos de abandono, y flujos de navegación. Estos datos informarán decisiones de diseño y priorización de features. Sentry monitoreará errores y crashes en producción, capturando stack traces completos, agrupando errores similares, y notificando al equipo sobre problemas críticos en tiempo real.

### 3.11 Infraestructura y Hosting

DigitalOcean Droplets o AWS EC2 hospedarán el servidor backend Node.js. Estas plataformas ofrecen servidores virtuales configurables que balancean costo y rendimiento adecuadamente para MVP. MongoDB Atlas proporcionará base de datos gestionada. Nginx actuará como servidor web y proxy reverso, sirviendo contenido estático eficientemente y distribuyendo carga entre múltiples instancias de Node.js mediante load balancing si fuera necesario.

Docker containerizará la aplicación backend, garantizando consistencia absoluta entre entornos de desarrollo, staging y producción. Los contenedores Docker eliminan problemas de "funciona en mi máquina" y facilitan despliegue automatizado mediante pipelines CI/CD.

### 3.12 Herramientas de Desarrollo

Visual Studio Code con extensión Flutter será el IDE principal recomendado, proporcionando debugging robusto, autocompletado inteligente, y refactoring automatizado. Android Studio proveerá emuladores Android para testing. Xcode será necesario para compilación iOS. Postman facilitará testing manual de APIs REST. MongoDB Compass proporcionará interfaz gráfica para explorar datos durante desarrollo. Git con GitHub gestionará control de versiones, siguiendo Git Flow como estrategia de branching.

---

## 4. Arquitectura de la Aplicación

### 4.1 Arquitectura General del Sistema

El sistema implementa arquitectura cliente-servidor de tres capas con separación clara de responsabilidades. La capa de presentación consiste en aplicación Flutter ejecutándose en dispositivos móviles, gestionando interfaz de usuario, animaciones, caché local, y lógica de presentación. La capa de lógica de negocio reside en servidor Node.js/Express, exponiendo APIs RESTful, ejecutando validaciones, implementando reglas de negocio, y coordinando operaciones entre servicios. La capa de datos comprende MongoDB para persistencia estructurada, Redis para cache de alta velocidad, y Firebase Storage para contenido multimedia.

### 4.2 Patrones Arquitectónicos

La aplicación Flutter seguirá arquitectura limpia separando código en capas: presentación (widgets y pantallas), dominio (lógica de negocio y modelos), y datos (repositorios y servicios). Esta separación facilita testing, mantenimiento, y permite cambiar implementaciones de capas inferiores sin afectar capas superiores.

El backend implementará patrón MVC (Modelo-Vista-Controlador) adaptado para APIs: modelos definen estructuras de datos y lógica de persistencia, controladores manejan requests HTTP y coordinan operaciones, rutas definen endpoints y aplican middleware, servicios encapsulan lógica de negocio compleja reutilizable.

### 4.3 Comunicación Cliente-Servidor

La aplicación Flutter realizará peticiones HTTP/HTTPS a endpoints REST del backend. Cada petición incluirá token JWT en header Authorization para autenticación. El backend validará tokens, ejecutará operaciones solicitadas, y retornará respuestas JSON estructuradas. Flutter procesará respuestas, actualizará estado mediante Provider, y re-renderizará interfaz reactivamente.

Para operaciones que requieran tiempo considerable, el backend implementará procesamiento asíncrono con notificaciones push al completar. Por ejemplo, generación de reportes complejos se ejecutará en background, notificando al usuario cuando estén listos.

### 4.4 Gestión de Estado Offline

La aplicación implementará capacidades offline mediante caché local inteligente. SQLite embebido en Flutter almacenará datos críticos: progreso reciente no sincronizado, contenido educativo descargado, configuraciones de usuario, y respuestas a actividades completadas sin conexión. Hive puede emplearse alternativamente como base de datos NoSQL embebida extremadamente rápida.

Cuando conectividad se restaura, la aplicación sincronizará cambios locales con servidor mediante cola de peticiones diferidas. El sistema detectará conflictos (por ejemplo, si datos se modificaron en servidor mientras usuario estaba offline) y aplicará estrategias de resolución apropiadas.

---

## 5. Diseño de Base de Datos MongoDB

### 5.1 Filosofía de Diseño

MongoDB almacenará datos en documentos BSON (Binary JSON) agrupados en colecciones. El diseño priorizará rendimiento de lectura mediante desnormalización estratégica, embebiendo subdocumentos relacionados cuando se accedan juntos frecuentemente. Para relaciones uno-a-muchos donde el lado "muchos" podría crecer indefinidamente, se utilizarán referencias entre documentos.

Los índices se crearán cuidadosamente en campos frecuentemente consultados, balanceando velocidad de lectura con costo de escritura y almacenamiento adicional. Los índices compuestos optimizarán consultas que filtren por múltiples campos simultáneamente.

### 5.2 Colección: users

Esta colección almacena información de usuarios adultos: padres, educadores, y administradores. Cada documento representa un usuario único identificado por email.

**Campos principales:** identificador único generado automáticamente, email como credencial de login con índice único, hash de contraseña generado con bcrypt, tipo de usuario (padre, educador, administrador), nombre completo separado en nombre y apellido, preferencias de usuario incluyendo idioma (español por defecto), configuraciones de notificaciones, y tema de interfaz, estado activo para soft-delete, timestamp de último login, y campos de auditoría con fechas de creación y actualización.

**Campos adicionales para recuperación de contraseña:** token de reseteo generado aleatoriamente, y fecha de expiración del token (típicamente 1 hora).

**Índices:** email único para login eficiente, tipo de usuario para filtrar por rol, estado activo para excluir usuarios desactivados.

### 5.3 Colección: children

Almacena perfiles de niños creados y gestionados por usuarios padres. Cada perfil infantil se vincula a un usuario padre mediante referencia.

**Campos principales:** identificador único, referencia al padre propietario del perfil, nombre de usuario único para login simplificado, nombre para mostrar en interfaz, fecha de nacimiento para calcular edad y adaptar contenido, grado escolar actual (1-6) para filtrar actividades apropiadas, configuración de avatar personalizable incluyendo tipo base, accesorios equipados, y esquema de colores, preferencias del niño como tema visual, sonido habilitado, música de fondo, y nivel de dificultad preferido, timestamp de última actividad para detectar inactividad, tiempo total acumulado en minutos, y estado activo.

**Sistema de login simplificado:** PIN de 4 dígitos hasheado para que niños accedan fácilmente sin necesidad de contraseñas complejas.

**Índices:** identificador de padre para listar hijos rápidamente, grado escolar para recomendaciones de contenido, estado activo.

### 5.4 Colección: subjects

Define las áreas de conocimiento principales: matemáticas, lengua, y potencialmente otras en futuro.

**Campos principales:** identificador único, nombre del área, descripción breve, icono representativo (código o URL), color distintivo en formato hexadecimal para identificación visual, orden de presentación en interfaz, y estado activo.

Para el MVP se crearán dos documentos: Matemáticas con icono de calculadora y color azul, y Lengua con icono de libro y color verde.

### 5.5 Colección: topics

Representa temas específicos dentro de cada área de conocimiento. Por ejemplo, en Matemáticas: Suma y Resta, Multiplicación, Fracciones. En Lengua: Lectoescritura, Comprensión Lectora, Ortografía.

**Campos principales:** identificador único, referencia al área padre (subject), nombre del tema, descripción detallada, grados escolares aplicables (array permitiendo que un tema abarque múltiples grados), referencias a temas prerequisitos que deben dominarse antes, tiempo estimado para dominar el tema en minutos, orden de presentación dentro del área, icono específico, y estado activo.

**Índices:** área padre para listar temas por materia, grados aplicables para filtrar por nivel, estado activo.

### 5.6 Colección: activities

Almacena todas las actividades educativas: quizzes, puzzles, juegos de emparejamiento, ejercicios de secuenciación, y lecturas comprensivas.

**Campos principales:** identificador único, referencia al tema padre, tipo de actividad (quiz, puzzle, matching, sequence, reading, game), título descriptivo, instrucciones paso a paso, nivel de dificultad (1-5), grado escolar recomendado, tiempo estimado de completación en minutos, valor en puntos al completar exitosamente.

**Campo content (estructura variable según tipo):** 
- Para quizzes: array de preguntas con texto, tipo (opción múltiple, verdadero/falso, entrada de texto, drag and drop, emparejamiento), imagen opcional, opciones de respuesta, respuesta correcta, pistas progresivas, explicación educativa, y puntos por pregunta.
- Para puzzles: configuración del puzzle incluyendo imagen completa, número de piezas, y lógica de validación.
- Para juegos: configuración específica como límite de tiempo, elementos a emparejar con imágenes y etiquetas, umbral de éxito.

**Campo metadata:** habilidades que desarrolla (array de strings), referencia curricular oficial, y palabras clave para búsqueda.

**Arrays de assets:** URLs de imágenes, audios y videos utilizados en la actividad.

**Campos de auditoría:** creador de la actividad (referencia a usuario educador o admin), fechas de creación y actualización, y estado activo.

**Índices compuestos:** tema + grado + dificultad para búsquedas eficientes de actividades apropiadas, habilidades para recomendaciones personalizadas, estado activo.

### 5.7 Colección: progress

Registra el progreso detallado de cada niño en actividades específicas, permitiendo seguimiento granular y análisis de desempeño.

**Campos principales:** identificador único, referencia al perfil infantil, referencia a la actividad, estado de completación (no iniciado, en progreso, completado, dominado), número de intentos realizados, indicador de completación, puntuación más alta alcanzada (0-100), tiempo total invertido en segundos, número de pistas utilizadas.

**Array de intentos:** cada elemento registra número de intento, timestamp de inicio, timestamp de completación, duración en segundos, array de respuestas del estudiante con identificador de pregunta, respuesta proporcionada, indicador de corrección, tiempo por pregunta, y pistas utilizadas, puntuación del intento, puntos ganados, monedas ganadas, experiencia ganada, y métricas de desempeño incluyendo precisión, velocidad (respuestas por minuto), y consistencia.

**Mejor intento:** referencia al número de intento con mejor desempeño, puntuación del mejor intento, y fecha de logro.

**Campos calculados:** tiempo total acumulado, intentos totales, puntuación promedio, nivel de dominio (0-100) calculado algorítmicamente considerando múltiples factores, última fecha de intento.

**Sistema de adaptación:** nivel de dificultad recomendado para siguiente actividad, array de conceptos identificados como débiles basándose en patrones de error.

**Índices compuestos:** niño + actividad (único) para recuperar progreso específico eficientemente, niño + última fecha para actividades recientes, nivel de dominio para identificar áreas dominadas.

### 5.8 Colección: gamification

Gestiona todos los elementos de gamificación de cada niño: puntos, monedas, experiencia, nivel, rachas, logros, y personalización de avatar.

**Campos principales:** identificador único, referencia al perfil infantil (único, un documento por niño), puntos totales acumulados, monedas actuales (pueden gastarse), monedas totales ganadas históricamente, puntos de experiencia, nivel actual calculado basándose en experiencia, experiencia requerida para alcanzar siguiente nivel.

**Sistema de rachas:** días consecutivos con actividad, racha más larga alcanzada, fecha de última actividad para calcular continuidad.

**Array de logros:** cada elemento contiene identificador del logro, nombre, descripción, URL de icono, fecha de desbloqueo, y categoría (dominio, dedicación, exploración, desafío).

**Configuración de avatar personalizable:** avatar base seleccionado, array de items desbloqueados con identificador, tipo (sombrero, ropa, accesorio, fondo), URL de imagen, fecha de compra, y costo en monedas, array de identificadores de items actualmente equipados.

**Array de desafíos activos:** identificador del desafío, nombre, descripción, fecha de inicio, fecha de fin, progreso actual (0-100), valor objetivo, valor actual, recompensas (puntos, monedas, insignia), e indicador de completación.

**Historial de recompensas:** tipo de recompensa, cantidad, razón de otorgamiento, fecha.

**Índices:** referencia a niño único, nivel para rankings (implementación futura).

### 5.9 Colección: achievements

Define todos los logros disponibles en el sistema que los niños pueden desbloquear.

**Campos principales:** identificador único, código único alfanumérico para referencia (ej: MATH_MASTER_10), nombre del logro, descripción motivadora, URL de icono, categoría (bronce, plata, oro, platino), criterio de desbloqueo especificando tipo de condición (actividades completadas, puntuaciones perfectas, racha de días, tiempo acumulado), umbral numérico, y área opcional si aplica a materia específica, recompensa en puntos al desbloquear, y estado activo.

Ejemplos de logros: "Primera Victoria" (completar primera actividad), "Maratonista" (5 días consecutivos), "Perfeccionista" (10 actividades con 100%), "Maestro Matemático" (completar todos los temas de matemáticas).

**Índices:** código único, categoría para agrupar, estado activo.

### 5.10 Colección: analytics

Almacena datos agregados pre-calculados para reportes de padres y educadores, evitando cálculos costosos en tiempo real.

**Campos principales:** identificador único, referencia al perfil infantil, tipo de periodo (diario, semanal, mensual), fecha de inicio del periodo, fecha de fin del periodo.

**Métricas de uso:** sesiones totales, minutos totales, promedio de minutos por sesión, días activos en el periodo, franja horaria preferida (mañana, tarde, noche).

**Métricas académicas por área:** para matemáticas y lengua: actividades completadas, puntuación promedio, tiempo invertido en minutos, tasa de mejora (cambio porcentual respecto periodo anterior), temas fuertes identificados (array), temas débiles identificados (array).

**Distribución de actividades:** por nivel de dificultad con conteo, por tipo de actividad con conteo, por tema con conteo.

**Identificación de patrones:** día de la semana más productivo, hora del día más productiva, promedio de intentos por actividad, estilo de aprendizaje preferido inferido (visual, práctica, desafío).

**Recomendaciones generadas automáticamente:** array de recomendaciones con tipo (practicar más, aumentar dificultad, revisar concepto, tomar descanso), área y tema aplicables, prioridad (1-5), y razón de la recomendación.

**Índices compuestos:** niño + tipo de periodo + fecha de inicio para consultas históricas, fecha de inicio para reportes temporales.

### 5.11 Colección: session_logs

Registra cada sesión de uso para análisis detallado de comportamiento.

**Campos principales:** identificador único, referencia al perfil infantil, timestamp de inicio de sesión, timestamp de fin de sesión, duración en minutos, array de referencias a actividades completadas durante la sesión, puntos totales ganados en la sesión, información de dispositivo incluyendo plataforma (iOS/Android), versión del sistema operativo, y modelo de dispositivo.

Esta colección permite analizar patrones de uso, identificar problemas de rendimiento en dispositivos específicos, y entender flujos de navegación del usuario.

**Índices:** niño para analizar historial, fecha de inicio para análisis temporal, plataforma para segmentación.

### 5.12 Colección: notifications

Gestiona notificaciones enviadas a usuarios y su estado de entrega.

**Campos principales:** identificador único, referencia al usuario destinatario, tipo de notificación (recordatorio, logro, progreso, sistema), título, cuerpo del mensaje, datos adicionales en formato JSON para deeplinks o acciones, timestamp de programación, timestamp de envío efectivo, indicador de lectura, timestamp de lectura, estado de entrega (pendiente, enviada, fallida, leída), y token FCM del dispositivo destino.

**Índices:** usuario + estado para listar pendientes, fecha de envío para limpieza de notificaciones antiguas, tipo para análisis de engagement.

---

## 6. API RESTful Completa

### 6.1 Principios de Diseño de la API

La API seguirá principios REST estrictos: recursos identificados mediante URLs descriptivas, operaciones mediante métodos HTTP semánticos (GET para lectura, POST para creación, PUT para actualización completa, PATCH para actualización parcial, DELETE para eliminación), respuestas con códigos de estado HTTP apropiados, y formato JSON uniforme para requests y responses.

Todas las URLs incluirán versionado mediante prefijo /api/v1/ para permitir evolución sin romper compatibilidad con versiones anteriores. Los endpoints protegidos requerirán token JWT en header Authorization con formato "Bearer [token]".

### 6.2 Módulo de Autenticación

**POST /api/v1/auth/register**
Registra nuevo usuario padre o educador. Requiere en body: email, contraseña, nombre, apellido, tipo de usuario. Valida formato de email, fortaleza de contraseña (mínimo 6 caracteres), y unicidad de email. Retorna token JWT y perfil de usuario creado. Código 201 en éxito, 400 si validación falla, 409 si email ya existe.

**POST /api/v1/auth/login**
Autentica usuario existente. Requiere email y contraseña en body. Valida credenciales, actualiza timestamp de último login, genera access token (duración 30 minutos) y refresh token (duración 7 días). Retorna ambos tokens y perfil de usuario. Código 200 en éxito, 401 si credenciales inválidas, 403 si cuenta desactivada.

**POST /api/v1/auth/refresh-token**
Renueva access token expirado usando refresh token válido. Requiere refresh token en body. Valida token, verifica usuario activo, genera nuevo access token. Retorna nuevo access token. Código 200 en éxito, 401 si refresh token inválido o expirado.

**POST /api/v1/auth/logout**
Cierra sesión del usuario. En implementación simple, cliente elimina tokens localmente. En implementación avanzada, backend añade token a blacklist en Redis con expiración. Código 200 siempre.

**POST /api/v1/auth/forgot-password**
Inicia proceso de recuperación de contraseña. Requiere email en body. Genera token único, almacena en documento de usuario con expiración de 1 hora, envía email con enlace conteniendo token. Retorna mensaje genérico sin revelar si email existe (previene enumeración de usuarios). Código 200 siempre.

**POST /api/v1/auth/reset-password**
Completa reseteo de contraseña. Requiere token de recuperación y nueva contraseña en body. Valida token no expirado, hashea nueva contraseña, actualiza usuario, invalida token. Retorna mensaje de éxito. Código 200 en éxito, 400 si token inválido o expirado.

### 6.3 Módulo de Usuarios

**GET /api/v1/users/profile/me**
Obtiene perfil del usuario autenticado. Extrae identificador de usuario desde token JWT. Retorna objeto de usuario con todos los campos excepto contraseña. Código 200 en éxito, 401 si no autenticado.

**PUT /api/v1/users/profile**
Actualiza perfil del usuario autenticado. Permite modificar nombre, apellido, preferencias (idioma, notificaciones, tema). No permite cambiar email o contraseña por seguridad (requieren endpoints específicos). Retorna perfil actualizado. Código 200 en éxito, 400 si validación falla.

**POST /api/v1/users/change-password**
Cambia contraseña del usuario autenticado. Requiere contraseña actual y nueva contraseña en body. Valida contraseña actual, verifica fortaleza de nueva contraseña, hashea y actualiza. Retorna mensaje de éxito. Código 200 en éxito, 400 si contraseña actual incorrecta, 422 si nueva contraseña débil.

### 6.4 Módulo de Perfiles Infantiles

**POST /api/v1/children**
Crea nuevo perfil infantil. Requiere autenticación de usuario padre. Requiere en body: nombre de usuario (único globalmente), nombre para mostrar, fecha de nacimiento, grado escolar. Opcionalmente: configuración inicial de avatar, preferencias. Valida unicidad de username, rango válido de grado (1-6), edad apropiada (típicamente 5-13 años). Crea documento en colección children, inicializa documento vacío en gamification. Retorna perfil infantil creado. Código 201 en éxito, 400 si validación falla, 409 si username ya existe.

**GET /api/v1/children**
Lista todos los perfiles infantiles del usuario padre autenticado. Filtra por parentId del token. Retorna array de perfiles con información básica. Código 200 siempre.

**GET /api/v1/children/:childId**
Obtiene detalle completo de un perfil infantil específico. Valida que el niño pertenece al usuario autenticado. Retorna perfil completo incluyendo configuraciones, estadísticas básicas, última actividad. Código 200 en éxito, 403 si el niño no pertenece al usuario, 404 si no existe.

**PUT /api/v1/children/:childId**
Actualiza perfil infantil. Permite modificar nombre, fecha de nacimiento, grado, avatar, preferencias. Valida pertenencia al usuario autenticado. Retorna perfil actualizado. Código 200 en éxito, 403 si no autorizado, 400 si validación falla.

**DELETE /api/v1/children/:childId**
Elimina perfil infantil (soft delete). Marca isActive como false en lugar de eliminar físicamente. Preserva datos históricos para análisis pero oculta perfil en listados. Retorna mensaje de confirmación. Código 200 en éxito, 403 si no autorizado, 404 si no existe.

**POST /api/v1/children/:childId/login**
Login simplificado para niño usando PIN. Requiere PIN de 4 dígitos en body. Valida PIN hasheado. Genera token JWT especial con scope limitado (solo puede acceder a endpoints infantiles). Retorna token y perfil infantil. Código 200 en éxito, 401 si PIN incorrecto.

### 6.5 Módulo de Contenido Educativo

**GET /api/v1/content/subjects**
Lista todas las áreas educativas activas. No requiere parámetros. Retorna array de subjects ordenados por campo order. Código 200 siempre, array vacío si no hay contenido.

**GET /api/v1/content/subjects/:subjectId/topics**
Lista temas de un área específica. Opcionalmente filtra por grado escolar mediante query parameter grade. Retorna array de topics ordenados, incluyendo información de prerequisitos. Código 200 en éxito, 404 si subject no existe.

**GET /api/v1/content/topics/:topicId/activities**
Lista actividades de un tema específico. Soporta filtros opcionales mediante query parameters: grade (grado escolar), difficulty (nivel de dificultad 1-5), type (tipo de actividad). Retorna array de activities con metadata resumida (sin contenido completo de preguntas para optimizar). Incluye información de progreso del niño si está autenticado. Código 200 en éxito, 404 si topic no existe.

**GET /api/v1/content/activities/:activityId**
Obtiene detalle completo de una actividad específica, incluyendo todas las preguntas, assets, configuraciones de juego. Requiere autenticación de niño. Incrementa contador de vistas si existe. Retorna objeto activity completo. Código 200 en éxito, 404 si no existe, 403 si actividad no apropiada para grado del niño autenticado.

**GET /api/v1/content/recommendations/:childId**
Genera recomendaciones personalizadas de actividades para un niño. Analiza progreso histórico, identifica temas débiles que requieren refuerzo, detecta temas dominados para sugerir siguiente nivel de dificultad, considera preferencias y estilo de aprendizaje. Retorna array ordenado de actividades recomendadas con razón de recomendación. Código 200 en éxito, 404 si niño no existe.

### 6.6 Módulo de Progreso

**POST /api/v1/progress**
Registra progreso de actividad completada. Requiere autenticación de niño. Requiere en body: identificador de actividad, puntuación (0-100), tiempo invertido en segundos, array de respuestas con identificador de pregunta, respuesta del usuario, e indicador de corrección, número de pistas utilizadas. Crea o actualiza documento en colección progress. Si es mejor intento, actualiza campo bestAttempt. Calcula métricas de evaluación. Actualiza gamificación: suma puntos y experiencia, verifica si sube de nivel, otorga monedas, verifica logros desbloqueables, actualiza racha si es primer actividad del día. Retorna objeto de progreso actualizado y recompensas ganadas. Código 201 en creación, 200 en actualización, 400 si validación falla.

**GET /api/v1/progress/child/:childId/overview**
Obtiene resumen general de progreso del niño. Requiere autenticación del padre propietario o del niño mismo. Calcula y retorna: actividades totales disponibles para su grado, actividades completadas, actividades en progreso, actividades no iniciadas, puntuación promedio global, tiempo total invertido, distribución de desempeño por área, progreso por tema, racha actual. Código 200 en éxito, 403 si no autorizado, 404 si niño no existe.

**GET /api/v1/progress/child/:childId/subject/:subjectId**
Obtiene progreso detallado en un área específica. Retorna para cada tema: número de actividades, completadas, en progreso, puntuación promedio, tiempo invertido, nivel de dominio, conceptos fuertes y débiles. Código 200 en éxito, 404 si niño o área no existen.

**GET /api/v1/progress/child/:childId/activity/:activityId**
Obtiene historial completo de intentos en una actividad específica. Retorna todos los intentos registrados con detalles: fecha, puntuación, tiempo, respuestas. Útil para que padres vean evolución. Código 200 en éxito, 404 si no existe progreso.

**GET /api/v1/progress/child/:childId/recent**
Lista actividades recientemente completadas por el niño. Soporta query parameter limit (default 10). Retorna array de progress ordenado por fecha descendente con información de la actividad embebida. Código 200 siempre.

### 6.7 Módulo de Gamificación

**GET /api/v1/gamification/:childId**
Obtiene estado completo de gamificación del niño. Requiere autenticación del padre o niño. Retorna documento gamification con todos los campos: puntos, nivel, experiencia, monedas, racha, logros desbloqueados, avatar configurado, estadísticas generales. Código 200 en éxito, 404 si niño no existe.

**GET /api/v1/gamification/:childId/achievements**
Lista logros del niño separando desbloqueados y bloqueados. Para desbloqueados muestra fecha de obtención. Para bloqueados muestra progreso actual hacia desbloqueo. Código 200 siempre.

**POST /api/v1/gamification/:childId/avatar/update**
Actualiza configuración de avatar. Requiere en body: avatar base, array de items equipados. Valida que items equipados están desbloqueados. Actualiza documento gamification. Retorna configuración actualizada. Código 200 en éxito, 400 si intenta equipar items no poseídos.

**POST /api/v1/gamification/:childId/shop/purchase**
Compra item para avatar usando monedas virtuales. Requiere en body: identificador del item. Valida saldo suficiente, que item no esté ya poseído. Deduce monedas, añade item a unlockedItems. Retorna item comprado y saldo actualizado. Código 200 en éxito, 400 si saldo insuficiente, 409 si ya posee item.

**GET /api/v1/gamification/shop**
Lista items disponibles en tienda virtual para personalizar avatar. Retorna categorías de items (sombreros, ropa, accesorios, fondos) con información de cada item: identificador, nombre, descripción, imagen, costo en monedas, rareza. Opcionalmente filtra items ya poseídos por niño si se proporciona childId. Código 200 siempre.

### 6.8 Módulo de Reportes

**GET /api/v1/reports/parent/:parentId/summary**
Resumen ejecutivo de todos los hijos de un padre. Requiere autenticación del padre. Para cada hijo retorna: nombre, grado, nivel actual, puntos totales, actividades completadas esta semana, tiempo de uso esta semana, racha actual, última actividad. Código 200 en éxito.

**GET /api/v1/reports/child/:childId/detailed**
Reporte detallado de un niño específico. Requiere autenticación del padre. Query parameters opcionales: startDate, endDate para filtrar periodo. Retorna: métricas de uso (sesiones, tiempo total, promedio por sesión), desempeño académico por área (actividades completadas, puntuación promedio, mejora respecto periodo anterior), análisis de fortalezas y debilidades, patrones de uso (día/hora más productivos), gráfico de progreso temporal, recomendaciones generadas. Código 200 en éxito, 404 si niño no existe.

**GET /api/v1/reports/child/:childId/analytics/weekly**
Reporte analítico semanal pre-calculado. Consulta documento en colección analytics con periodType weekly y fecha actual. Si no existe, lo calcula on-demand y lo almacena para futuras consultas. Retorna métricas agregadas semanales. Código 200 en éxito.

**GET /api/v1/reports/child/:childId/analytics/monthly**
Similar al reporte semanal pero con alcance mensual. Proporciona vista de tendencias a mediano plazo. Código 200 en éxito.

**GET /api/v1/reports/child/:childId/export/pdf**
Genera y descarga reporte en formato PDF. Requiere autenticación del padre. Query parameters: startDate, endDate. Genera PDF con gráficos, tablas, y análisis. Retorna archivo PDF con header Content-Type: application/pdf. Código 200 en éxito, 404 si niño no existe.

### 6.9 Módulo de Notificaciones

**GET /api/v1/notifications/:userId**
Lista notificaciones del usuario. Query parameters: status (read/unread/all), limit, offset para paginación. Retorna array de notifications ordenadas por fecha descendente. Código 200 siempre.

**PUT /api/v1/notifications/:notificationId/read**
Marca notificación como leída. Actualiza campos read e readAt. Retorna notificación actualizada. Código 200 en éxito, 404 si no existe.

**PUT /api/v1/notifications/mark-all-read**
Marca todas las notificaciones del usuario como leídas. Actualización masiva. Retorna número de notificaciones actualizadas. Código 200 en éxito.

**POST /api/v1/notifications/register-device**
Registra token FCM del dispositivo para recibir notificaciones push. Requiere en body: deviceToken, platform (ios/android). Almacena en perfil de usuario o en colección separada de dispositivos. Código 200 siempre.

### 6.10 Convenciones de Respuesta

Todas las respuestas exitosas siguen formato JSON consistente con datos envueltos en propiedad "data" y metadata en "meta". Respuestas con arrays incluyen información de paginación. Errores retornan objeto con "error" conteniendo mensaje descriptivo, código de error específico, y opcionalmente array de validaciones fallidas.

---

## 7. Módulos y Funcionalidades de la Aplicación Flutter

### 7.1 Módulo de Splash Screen

La aplicación inicia mostrando splash screen mientras realiza inicializaciones críticas: cargar tokens almacenados localmente, verificar validez de tokens con backend, pre-cargar configuraciones básicas, inicializar servicios de analytics y notificaciones. Si usuario tiene sesión válida, navega automáticamente a pantalla apropiada (dashboard de padre o home de niño según tipo de usuario). Si no hay sesión, navega a pantalla de login. Duración mínima de 2 segundos para visualizar branding aunque inicialización termine antes.

### 7.2 Módulo de Autenticación

**Pantalla de Login:** Formulario con campos de email y contraseña. Validación en tiempo real de formato de email y longitud mínima de contraseña. Botón de login que al presionar muestra indicador de carga y llama a API de login. Manejo de errores mostrando mensajes claros (credenciales incorrectas, sin conexión, error de servidor). Enlace a pantalla de recuperación de contraseña. Enlace a pantalla de registro. Opción de recordar sesión activada por default.

**Pantalla de Registro:** Formulario multi-step para reducir carga cognitiva. Paso 1 solicita email y contraseña con confirmación. Paso 2 solicita nombre completo. Paso 3 pregunta tipo de usuario (padre o educador) con iconos descriptivos. Validación exhaustiva: email único, contraseña segura (mínimo 6 caracteres, idealmente con mayúsculas, números, símbolos), coincidencia de confirmación. Indicador visual de fortaleza de contraseña. Botón de registro que al completar llama a API y redirige a configuración inicial.

**Pantalla de Recuperación de Contraseña:** Campo único de email. Botón que envía solicitud a backend. Mensaje de confirmación genérico (no revela si email existe). Instrucciones para revisar email incluyendo carpeta de spam. El proceso de reseteo se completa en web browser abriendo enlace del email.

**Login de Niño:** Pantalla dedicada y simplificada para niños. Selector visual de perfiles infantiles mostrando avatar y nombre. Al seleccionar perfil, muestra teclado numérico grande para ingresar PIN de 4 dígitos. Animaciones alegres al ingresar cada dígito. Sin teclado regular para prevenir frustración. Límite de intentos para prevenir adivinación.

### 7.3 Módulo de Dashboard de Padre

**Pantalla Principal:** Header con información del padre y selector dropdown de hijos si tiene múltiples. Cards resumen mostrando métricas clave del hijo seleccionado: tiempo de uso esta semana con comparación vs semana anterior, actividades completadas, puntuación promedio, racha actual con icono de fuego. Gráfico de línea mostrando evolución de puntuación en últimas 2 semanas. Sección de actividades recientes con miniaturas y resultados. Botones de acción rápida: ver reporte completo, administrar perfiles de hijos, configurar notificaciones, acceder a recursos educativos para padres.

**Pantalla de Gestión de Hijos:** Lista de todos los perfiles infantiles con cards mostrando avatar, nombre, grado, nivel de gamificación. Botón flotante para agregar nuevo hijo. Al tocar card de niño, accede a detalle con opciones de editar perfil, ver progreso detallado, configurar límites de tiempo, eliminar perfil (con confirmación). Reordenamiento mediante drag para priorizar visualización.

**Pantalla de Reporte Detallado:** Tabs separando diferentes aspectos: Resumen General, Matemáticas, Lengua, Gamificación. Tab de Resumen muestra KPIs principales, tendencias temporales con gráficos interactivos, heatmap de actividad por día y hora, comparación con estudiantes de mismo grado (opcional, con privacidad). Tab por materia muestra progreso en cada tema, fortalezas y debilidades identificadas mediante análisis de errores recurrentes, recomendaciones de refuerzo. Tab de Gamificación lista logros, muestra progreso hacia siguiente nivel, historial de recompensas. Botón de exportar reporte a PDF. Selector de rango de fechas para análisis histórico.

**Pantalla de Configuraciones:** Secciones separadas: Perfil del padre (editar nombre, email, contraseña), Preferencias de la cuenta (idioma, notificaciones por email), Notificaciones push (habilitar/deshabilitar por tipo: logros del niño, recordatorios de inactividad, reportes semanales), Privacidad y seguridad (gestionar datos, descargar información, eliminar cuenta), Ayuda y soporte (FAQs, tutorial, contactar soporte).

### 7.4 Módulo de Home de Niño

**Pantalla Principal:** Diseño alegre y colorido optimizado para niños. Header con avatar del niño (tappable para acceder a perfil), nombre de bienvenida, indicador de nivel con barra de progreso visual a siguiente nivel, monedas acumuladas con animación al cambiar. Grid de 2 columnas con cards grandes de las áreas de conocimiento (Matemáticas, Lengua). Cada card muestra icono distintivo, color temático, nombre del área, número de actividades disponibles, indicador de progreso general en el área. Al tocar card, navega a pantalla de temas. Botón de notificaciones con badge indicando no leídas. Barra de navegación inferior con iconos: Home, Mis Logros, Tienda, Perfil.

**Pantalla de Temas:** Muestra temas del área seleccionada en lista vertical con cards expansibles. Cada card de tema muestra icono, nombre, descripción breve, nivel de completación (porcentaje y barra), número de actividades disponibles, indicador de dificultad promedio. Al expandir card, muestra lista de actividades del tema con estado (no iniciada con candado si requiere prerequisito, en progreso, completada con estrellas de desempeño). Al tocar actividad disponible, navega a pantalla de actividad. Temas bloqueados muestran candado y lista de prerequisitos.

### 7.5 Módulo de Actividades Interactivas

**Pantalla de Inicio de Actividad:** Muestra información completa antes de iniciar: título, instrucciones detalladas, tiempo estimado, dificultad visualizada con estrellas, recompensa en puntos. Botón grande de "Comenzar" que inicia timer y carga primera pregunta. Opción de volver atrás sin penalización.

**Pantalla de Actividad - Tipo Quiz:** Header con barra de progreso mostrando pregunta actual de total, timer si la actividad es cronometrada, botón de pausa. Área central muestra pregunta con formato legible, imagen si aplica, opciones de respuesta como botones grandes tappables. Para opción múltiple, al seleccionar opción se resalta y habilita botón de confirmar. Al confirmar, muestra feedback inmediato con animación: marca verde y sonido alegre si correcta, marca roja con vibración suave si incorrecta. Si incorrecta, muestra botón de pista (consume monedas o es gratuita según configuración), botón de ver explicación, y permite reintentar o continuar. Transición animada a siguiente pregunta.

**Pantalla de Actividad - Tipo Puzzle:** Muestra imagen de referencia pequeña en esquina. Área de trabajo con piezas desordenadas. El niño arrastra piezas a posiciones en cuadrícula. Snap magnético cuando pieza está cerca de posición correcta. Contador de movimientos. Botón de ayuda muestra brevemente configuración correcta. Al completar, celebración animada con confetti y sonido triunfal.

**Pantalla de Actividad - Tipo Matching:** Dos columnas de items. Niño conecta items relacionados arrastrando línea de uno a otro. Validación al completar todas las conexiones. Feedback inmediato sobre correctas e incorrectas con colores y sonidos. Opción de reintentar solo las incorrectas.

**Pantalla de Actividad - Tipo Drag and Drop:** Elementos arrastrables y zonas de drop claramente delimitadas. El niño arrastra elementos a zonas correctas. Feedback visual cuando elemento entra en zona (resaltado). Validación al completar. Permite reorganizar antes de confirmar.

**Pantalla de Completación:** Celebración visual con animación de fuegos artificiales o estrella brillante según desempeño. Muestra puntuación obtenida con porcentaje y representación visual (estrellas 1-3). Desglose de preguntas correctas e incorrectas. Tiempo total invertido. Recompensas ganadas (puntos de experiencia, monedas, items de avatar) con animación de obtención. Indicador si subió de nivel con explosión animada. Lista de logros desbloqueados si aplica con modal de cada uno. Botones: Ver explicaciones detalladas, Reintentar actividad, Volver a temas, Siguiente actividad sugerida.

### 7.6 Módulo de Gamificación

**Pantalla de Perfil/Logros:** Tabs: Mi Progreso, Mis Logros, Mis Estadísticas. 

Tab Mi Progreso muestra card destacado con nivel actual, barra de experiencia con porcentaje numérico, puntos totales acumulados con historia visual, monedas actuales y totales ganadas, racha actual con calendario visual de últimos 7 días (días activos con fuego, días inactivos apagados), racha más larga registrada. Motivación textual basándose en racha. Card de desafíos activos mostrando nombre, descripción, barra de progreso, tiempo restante con countdown, recompensa al completar.

Tab Mis Logros muestra grid de medallas. Desbloqueadas en color completo con fecha y animación sutil de brillo. Bloqueadas en escala de grises con silueta, mostrando requisito y progreso actual al tocar. Filtros por categoría. Al tocar logro desbloqueado, modal con animación celebratoria, descripción completa, fecha de obtención, rareza, opciones de compartir logro (futuro).

Tab Mis Estadísticas muestra cards con iconos: Actividades Totales Completadas, Tiempo Total Aprendiendo (en formato legible como "23 horas 45 minutos"), Promedio de Puntuación con gráfico de tendencia, Tema Favorito inferido de tiempo invertido, Mejor Racha Histórica. Gráficos de barras comparando desempeño en matemáticas vs lengua. Gráfico circular de distribución de actividades por tipo.

**Pantalla de Tienda de Avatar:** Grid mostrando todos los items disponibles organizados por categorías (tabs: Sombreros, Ropa, Accesorios, Fondos). Cada item muestra imagen preview, nombre creativo, costo en monedas. Items no poseídos tienen botón de compra con precio. Items poseídos muestran check verde y botón de equipar. Items equipados actualmente tienen indicador especial. Al tocar item, modal con preview más grande, descripción divertida, indicador de rareza (común, raro, épico, legendario) con colores distintivos. Botón de comprar valida saldo suficiente, muestra confirmación, anima transferencia de monedas, añade item con efecto visual de desbloqueo. Balance de monedas siempre visible en header.

**Pantalla de Personalización de Avatar:** Preview grande del avatar con todos los items equipados aplicados en tiempo real. Tabs para seleccionar categoría de item a cambiar. Al seleccionar item de inventario, se aplica inmediatamente en preview. Selector de colores para componentes personalizables (piel, cabello, ojos). Botón de aleatorizar que genera combinación aleatoria. Botón de guardar que persiste configuración. Animación de transición suave entre combinaciones.

### 7.7 Módulo de Notificaciones

**Centro de Notificaciones:** Lista cronológica de notificaciones con cards diferenciadas por tipo mediante color e icono. Notificaciones de logros muestran medalla obtenida e invitan a verla. Notificaciones de recordatorio de práctica usan lenguaje motivador. Notificaciones para padres sobre progreso de hijo incluyen snapshot de métricas. Indicador de no leída (punto o negrita). Swipe para eliminar. Botón de marcar todas como leídas. Pull to refresh para actualizar.

**Notificaciones Push:** El sistema enviará notificaciones en momentos estratégicos. Recordatorio diario a hora configurada por padres (default 16:00) si no ha habido actividad. Notificación inmediata al desbloquear logro. Alerta a padre cuando hijo completa actividad con puntuación perfecta. Notificación semanal a padres con resumen ejecutivo. Alert cuando se rompe racha (día sin actividad) para intentar recuperación. Todas las notificaciones incluyen deeplink apropiado.

---

## 8. Flujos de Usuario Completos

### 8.1 Flujo de Registro e Ingreso de Padre

Un padre nuevo descarga la aplicación desde App Store o Google Play. Al abrir por primera vez, ve splash screen con logo animado. Tras inicialización, llega a pantalla de bienvenida con opción de Ingresar o Registrarse. Toca Registrarse. En paso 1 ingresa email personal y crea contraseña segura (el sistema muestra indicador de fortaleza con sugerencias). Confirma contraseña. En paso 2 ingresa nombre y apellido. En paso 3 selecciona "Soy Padre". Toca Crear Cuenta. El backend valida información, crea usuario, retorna tokens. La aplicación guarda tokens localmente y navega a wizard de configuración inicial. El wizard invita a crear primer perfil de hijo. El padre ingresa nombre del niño, fecha de nacimiento, grado escolar actual. Selecciona avatar inicial de galería predefinida. Toca Crear Perfil. El backend crea documento de niño e inicializa gamificación. La aplicación muestra confirmación y navega al dashboard del padre mostrando el nuevo perfil.

### 8.2 Flujo de Niño Realizando Actividad

Un niño abre la aplicación y ve pantalla de selección de perfil mostrando su avatar personalizado. Toca su perfil. Ingresa PIN de 4 dígitos en teclado numérico grande. Sistema valida y navega a home del niño. Ve card de Matemáticas y la toca. Aparece lista de temas. "Suma y Resta" muestra 60% completado. Lo expande y ve actividades: tres completadas con 3 estrellas, dos con 2 estrellas, una no iniciada con título "Suma de Números de Dos Dígitos". Toca la actividad no iniciada. Ve pantalla de información: título, descripción indicando que sumará números del 10 al 99, 10 preguntas estimadas, 15 minutos estimados, recompensa de 100 puntos. Toca Comenzar.

Aparece primera pregunta: "¿Cuánto es 23 + 45?" con imagen ilustrativa de bloques. Cuatro opciones: 58, 68, 78, 88. El niño piensa y toca 68. Toca Confirmar. Animación de marca verde aparece con sonido alegre y mensaje "¡Correcto!". Automáticamente transiciona a segunda pregunta tras 2 segundos. Segunda pregunta: "¿Cuánto es 37 + 28?". El niño no está seguro y toca botón de Pista. Sistema deduce 10 monedas y muestra: "Recuerda: suma primero las unidades (7+8) y luego las decenas (3+2)". Con esta ayuda, el niño resuelve: 65. Toca 65 y Confirma. Correcto nuevamente. Continúa respondiendo las 10 preguntas. En la pregunta 7 se equivoca, seleccionando 74 cuando la respuesta era 76. El sistema muestra marca roja con vibración suave y mensaje "No es correcto. ¿Quieres intentar de nuevo?". Muestra las cuatro opciones nuevamente. El niño reflexiona y selecciona 76. Esta vez es correcto. Completa las 10 preguntas.

Aparece pantalla de completación con animación de fuegos artificiales. Muestra: "¡Excelente trabajo! Obtuviste 90/100". Nueve preguntas correctas, una incorrecta, tiempo 12 minutos. Ganó 90 puntos de experiencia, 45 monedas, subió 20% de progreso hacia nivel 5. Barra de experiencia se llena animadamente mostrando que subió de nivel 4 a nivel 5 con explosión visual y sonido épico. Mensaje: "¡Subiste al Nivel 5! Desbloqueaste nuevo sombrero: Gorro de Mago". Modal aparece mostrando el sombrero con brillo dorado. Toca Ver Mi Nuevo Item. Navega a inventario mostrando el sombrero con indicador "¡NUEVO!". Toca Equipar. El avatar se actualiza instantáneamente con el gorro. El niño sonríe satisfecho. Toca Siguiente Actividad Sugerida. Sistema recomienda "Resta de Números de Dos Dígitos" como continuación natural.

### 8.3 Flujo de Padre Revisando Progreso

Un padre abre la aplicación y ve dashboard. En la parte superior, selector dropdown muestra "Sofía - 2do Grado". La card de Resumen Semanal indica: 180 minutos esta semana (↑20% vs semana anterior), 12 actividades completadas, promedio 85%, racha 5 días. Toca Ver Reporte Completo. Navega a pantalla de reportes detallados con tabs. Tab Resumen General activo muestra gráfico de línea de puntuación promedio en últimas 2 semanas, tendencia ascendente visible. Heatmap indica que Sofía es más activa entre 16:00-18:00, principalmente martes y jueves. Swipea a tab Matemáticas. Ve desglose por tema: Suma y Resta 80% completado con tendencia positiva, Multiplicación 40% completado recién iniciado, Geometría 0% no iniciado. Sección de Fortalezas lista: "Suma básica, Problemas visuales, Cálculo mental". Sección de Debilidades lista: "Resta con reagrupación - 4 errores en últimos 3 intentos". Sistema recomienda: "Reforzar resta con reagrupación mediante actividades visuales".

El padre toca tab Gamificación. Ve todos los logros de Sofía: 8 desbloqueados (Primera Victoria, Maratonista 5 días, Explorador - completó 3 temas diferentes, Veloz - completó actividad en menos del tiempo estimado, etc.), 15 bloqueados con progreso visible. Ve que está 40% hacia "Perfeccionista" que requiere 10 actividades con 100%. El padre se siente orgulloso y toca botón de Exportar a PDF. Sistema genera PDF profesional con gráficos, lo descarga automáticamente. Aparece notificación: "Reporte guardado en Descargas". El padre lo abrirá más tarde para compartir con la maestra de Sofía.

### 8.4 Flujo de Adaptación de Dificultad

El sistema monitorea constantemente el desempeño del estudiante. Un niño llamado Marco ha completado 5 actividades consecutivas de nivel dificultar 2 en el tema "Lectura Comprensiva", todas con puntuación superior a 90%, tiempo por debajo del estimado, y sin usar pistas. El algoritmo de adaptación detecta que Marco ha dominado este nivel. Cuando Marco completa la quinta actividad, además de las recompensas normales, aparece mensaje especial: "¡Has demostrado gran dominio! Te sugerimos probar actividades más desafiantes". La aplicación automáticamente incluye actividades de dificultad 3 en sus recomendaciones. Marco acepta el desafío y selecciona una actividad de dificultad 3. Esta resulta apropiadamente más difícil pero no frustrante, obteniendo 75% - puntuación que indica desafío apropiado. El sistema registra que dificultad 3 es ahora adecuada para Marco en este tema.

En contraste, una niña llamada Ana intenta una actividad de dificultad 3 en "Fracciones". Obtiene solo 40% con 6 errores de 10 preguntas, tiempo excesivo, y múltiples pistas usadas. El sistema detecta struggle significativo. Al completar, en lugar del mensaje de celebración estándar, muestra mensaje empático: "Las fracciones pueden ser desafiantes. ¡No te rindas!". El sistema automáticamente sugiere actividades de repaso de dificultad 2 en conceptos base de fracciones. También añade nota en el reporte de padres: "Ana encontró dificultad con fracciones nivel avanzado. Se recomienda reforzar conceptos base". Los padres reciben notificación sugiriendo revisar el reporte y posiblemente practicar con Ana usando materiales físicos.

---

## 9. Consideraciones de Diseño UX/UI

### 9.1 Principios de Diseño para Niños

La interfaz infantil debe seguir principios específicos de usabilidad pediátrica. Elementos táctiles grandes (mínimo 44x44 puntos) facilitan interacción con dedos pequeños y menos precisos. Contraste alto entre texto y fondo asegura legibilidad. Tipografía sans-serif redondeada como Nunito o Quicksand en tamaños grandes (mínimo 16pt para texto normal, 24pt para títulos). Espaciado generoso entre elementos previene toques accidentales. Navegación simple con máximo 3 niveles de profundidad. Confirmaciones para acciones destructivas o que requieran gasto de recursos. Feedback inmediato mediante animaciones, sonidos y vibraciones ante cada interacción. Mensajes con lenguaje simple, positivo y alentador. Evitar texto técnico o mensajes de error complejos.

### 9.2 Sistema de Colores

Paleta vibrante pero no saturada para evitar fatiga visual. Colores primarios: Azul brillante para Matemáticas evocando lógica y claridad, Verde energizante para Lengua representando crecimiento y creatividad, Amarillo/Dorado para gamificación asociado con recompensa y logro, Rojo suave para alertas sin ser alarmante, Gris claro para fondos manteniendo luminosidad. Cada área de conocimiento mantiene su color consistentemente en toda la aplicación para reforzar identidad. Los elementos interactivos usan colores vivos mientras contenido informativo usa tonos apagados para jerarquía visual clara. Modo oscuro opcional invierte paleta para uso nocturno sin afectar ojos.

### 9.3 Animaciones y Transiciones

Las animaciones sirven propósitos funcionales, no son meramente decorativas. Transiciones de pantalla duran 250-300ms usando curvas ease-out para sensación de rapidez. Al tocar botones, efecto de hundimiento con elevación reducida y leve scaling. Al obtener recompensas, animación de partículas celebratorias con física realista. Avatares tienen animaciones idle sutiles como parpadeo o respiración para parecer vivos. Barras de progreso se llenan animadamente con easing para satisfacción visual. Elementos que aparecen usan fade-in combinado con slide-up leve. Micro-interacciones como likes o favoritos tienen bounce. Todas las animaciones respetan configuración de accesibilidad de reducción de movimiento del sistema operativo, simplificándose a fades directos.

### 9.4 Accesibilidad

La aplicación implementará niveles de accesibilidad WCAG AA mínimo. Soporte para lectores de pantalla con etiquetas semánticas apropiadas en todos los elementos interactivos. Navegación completa mediante teclado externo para usuarios con limitaciones motoras. Subtítulos para todo contenido de audio. Transcripciones para contenido de video. Opción de ajustar tamaño de fuente en tres niveles (pequeño, medio, grande). Modo alto contraste para usuarios con dificultades visuales. Compatibilidad con modo de escala de grises del sistema para usuarios daltónicos. Feedback multi-sensorial (visual + auditivo + táctil) para usuarios con deficiencias en un sentido.

### 9.5 Diseño para Padres

El dashboard de padres contrasta con la interfaz infantil mediante estética profesional pero amigable. Paleta de colores más sobria con azules y grises corporativos. Tipografía sans-serif moderna como Inter o Roboto. Densidad de información mayor aprovechando que adultos procesan más datos simultáneamente. Gráficos de datos profesionales tipo business intelligence con opciones de filtrado. Navegación mediante tabs y sidebar en tablets. Cards con sombras sutiles y bordes definidos. Iconos minimalistas outline style. Espaciamiento eficiente pero no apretado. Dashboard responsive que adapta layout a orientación y tamaño de dispositivo.

---

## 10. Implementación de Seguridad

### 10.1 Protección de Datos Infantiles

La aplicación cumplirá estrictamente regulaciones de protección de menores como COPPA (Children's Online Privacy Protection Act) y GDPR (General Data Protection Regulation). Recolección mínima de datos: únicamente información necesaria para funcionalidad educativa (nombre, fecha de nacimiento, grado). No se solicitará información de contacto directo del niño. Datos almacenados con cifrado AES-256 en reposo. Transmisión exclusivamente mediante HTTPS con TLS 1.3. Acceso a datos infantiles requiere autenticación y autorización del padre. Imposibilidad de que niños modifiquen configuraciones de privacidad. Logs de acceso a datos sensibles para auditoría. Política de retención con eliminación automática de datos tras inactividad prolongada (configurable). Opción de exportar todos los datos del niño en formato portable. Eliminación completa y permanente de datos al cerrar cuenta.

### 10.2 Seguridad de Autenticación

Contraseñas almacenadas hasheadas con bcrypt usando factor de trabajo 12, balanceando seguridad con rendimiento. Validación de fortaleza de contraseña en cliente y servidor: mínimo 8 caracteres, combinación de mayúsculas, minúsculas y números recomendada. Protección contra ataques de fuerza bruta mediante rate limiting: 5 intentos fallidos en 5 minutos bloquea IP temporalmente. Protección contra enumeración de usuarios: mensajes de error genéricos sin revelar si email existe. Tokens JWT con expiración corta (30 minutos) y refresh tokens con expiración larga (7 días) almacenados en HttpOnly cookies cuando sea posible. Revocación de tokens al logout agregándolos a blacklist en Redis. Detección de sesiones concurrentes sospechosas: alerta si login desde ubicación geográfica muy distante en tiempo corto. Autenticación de dos factores opcional mediante código SMS o aplicación authenticator para cuentas padre.

### 10.3 Sanitización de Inputs

Toda entrada de usuario se valida y sanitiza en cliente y servidor. Frontend valida formato antes de enviar (email válido, número en rango, longitud apropiada). Backend valida exhaustivamente usando bibliotecas especializadas como Validator.js para Node.js. Sanitización de strings eliminando caracteres especiales que podrían usarse en ataques de inyección. Protección contra inyección SQL/NoSQL mediante uso exclusivo de consultas parametrizadas con Mongoose. Protección contra XSS escapando HTML en todo contenido generado por usuario antes de renderizar. Protección contra CSRF mediante tokens anti-CSRF en formularios. Límites estrictos de tamaño en uploads: máximo 5MB para imágenes de avatar. Validación de tipo MIME real de archivos subidos, no confiando solo en extensión.

### 10.4 Seguridad de API

Todas las peticiones a API protegidas requieren token JWT válido en header Authorization. Middleware de autenticación verifica token en cada request, rechazando inmediatamente si falta, está malformado o expiró. CORS configurado permitiendo únicamente dominios autorizados. Rate limiting global: máximo 100 requests por minuto por IP para prevenir abuso. Rate limiting específico en endpoints sensibles: login (5 por minuto), registro (3 por hora), recuperación de contraseña (2 por hora). Logging exhaustivo de requests a endpoints protegidos con timestamp, usuario, acción, IP. Monitoreo de patrones anómalos: múltiples requests fallidos, acceso a recursos fuera de autorización. Respuestas de error sin información sensible: nunca exponer stack traces o detalles de infraestructura. Headers de seguridad configurados mediante Helmet: HSTS, nosniff, frameguard, CSP. Versionado de API permitiendo deprecar versiones vulnerables sin romper compatibilidad.

---

## 11. Testing y Calidad

### 11.1 Estrategia de Testing

La aplicación implementará pirámide de testing con mayor cantidad de tests unitarios en la base, tests de integración en el medio, y tests end-to-end en la cúspide. Tests unitarios verifican funciones y componentes aislados con mock de dependencias. Tests de integración validan interacción entre módulos. Tests end-to-end simulan flujos completos de usuario en entorno similar a producción.

### 11.2 Testing de Frontend Flutter

Tests unitarios con Flutter Test verifican lógica de providers, repositorios, y funciones utilitarias. Tests de widgets con flutter_test validan renderizado correcto de componentes individuales. Integration tests ejecutan flujos completos en emulador, simulando tap en botones, ingreso de texto, navegación entre pantallas. Golden tests capturan screenshots de widgets para detectar regresiones visuales. Coverage objetivo mínimo del 70% de código crítico.

### 11.3 Testing de Backend

Tests unitarios con Jest verifican funciones de servicios, validadores, y helpers. Tests de integración con Supertest validan endpoints completos incluyendo middleware, controladores, y acceso a base de datos. Base de datos de testing separada con MongoDB Memory Server que inicia instancia efímera para cada suite de tests. Fixtures de datos reutilizables con datos representativos. Tests de seguridad intentando exploits comunes: inyección SQL, XSS, CSRF. Tests de performance midiendo tiempo de respuesta bajo carga. Coverage objetivo mínimo del 80%.

### 11.4 Testing de Usuario

Tests de usabilidad con niños reales de grupos objetivo (6-12 años) observando interacción con prototipos. Tests A/B comparando variantes de interfaz o flujos para optimizar conversión y engagement. Tests de accesibilidad con herramientas automatizadas (axe, Lighthouse) y validación manual. Beta testing con grupo controlado de familias reales usando aplicación en condiciones naturales, recolectando feedback mediante encuestas y analytics.
do timelines de GDPR.

### 14.2 Propiedad Intelectual

Todo el contenido educativo creado es propiedad intelectual del proyecto. Licencias apropiadas para assets de terceros: imágenes de stock con licencia comercial, iconos con atribución si requerido, música de fondo libre de regalías. Registro de marca comercial para nombre y logo de la aplicación. Copyright notices en footer de aplicación y documentación.

### 14.3 Cumplimiento de Regulaciones Educativas

Alineación con estándares curriculares oficiales del mercado objetivo (Perú en este caso). Revisión de contenido por expertos pedagógicos certificados. Certificación de cumplimiento con estándares educativos si regulación local lo requiere. Colaboración con Ministerio de Educación para validación o endorsement oficial potencial en futuro.



## Conclusión

Este informe técnico proporciona especificaciones completas para implementar "Aprendo Jugando" utilizando Flutter y MongoDB como stack tecnológico principal. La arquitectura descrita es escalable, segura, y orientada a entregar experiencia educativa de calidad que beneficie a niños, padres, y educadores. El enfoque modular permite desarrollar MVP enfocado en funcionalidades core, con clara ruta de evolución hacia producto completo. El éxito del proyecto dependerá de balance apropiado entre rigor técnico, diseño centrado en usuario, y validación pedagógica, manteniéndose siempre enfocado en la misión fundamental: hacer que aprender sea divertido y efectivo para estudiantes de primaria.