# Tests de Aprendo Jugando

Este documento describe todos los tests implementados en la aplicación y cómo ejecutarlos.

## Estructura de Tests

La aplicación tiene tests completos para todos los componentes principales:

### 1. Widget Tests (`test/widget_test.dart`)
Tests de integración de la aplicación completa:
- ✅ Inicialización de la app con splash screen
- ✅ Inicialización de providers (AuthProvider, ContentProvider, ProgressProvider)
- ✅ Aplicación correcta del tema
- ✅ Navegación inicial correcta
- ✅ Branding del splash screen

### 2. Model Tests (`test/models_test.dart`)
Tests unitarios para todos los modelos de datos:
- ✅ **User Model**: Creación, serialización, fullName
- ✅ **Child Model**: Creación, cálculo de edad, serialización
- ✅ **Subject Model**: Creación de áreas educativas
- ✅ **Topic Model**: Creación, aplicabilidad por grado
- ✅ **Activity Model**: Creación, QuizQuestion correctness
- ✅ **Progress Model**: Creación, cálculo de promedio
- ✅ **Gamification Model**: Creación, progreso a siguiente nivel
- ✅ **Achievement Model**: Creación de logros

### 3. Service Tests (`test/services_test.dart`)
Tests para todos los servicios:
- ✅ **AuthService**:
  - Login con credenciales válidas
  - Guardado de token de autenticación
  - Logout
  - Registro de usuario
  - Login de niño con PIN
  - Obtención de usuario actual
- ✅ **ContentService**:
  - Obtención de áreas (subjects)
  - Obtención de temas por área
  - Filtrado de temas por grado
  - Obtención de actividades por tema
  - Búsqueda por ID
- ✅ **ProgressService**:
  - Obtención de progreso de niño
  - Guardado de completación de actividad
  - Actualización de gamificación
  - Obtención de datos de gamificación
- ✅ **MockDataService**:
  - Disponibilidad de datos mock
  - Usuarios, niños, áreas, temas, actividades

### 4. Provider Tests (`test/providers_test.dart`)
Tests para gestión de estado:
- ✅ **AuthProvider**:
  - Estado inicial no autenticado
  - Login de padre
  - Login de niño
  - Logout
  - Registro
  - Obtención de hijos
  - Manejo de errores
- ✅ **ContentProvider**:
  - Carga de áreas educativas
  - Obtención de temas
  - Obtención de actividades
  - Búsqueda por ID
  - Estado de loading
- ✅ **ProgressProvider**:
  - Carga de progreso
  - Completación de actividades
  - Estadísticas de completación
  - Cálculo de promedio
  - Gamificación
- ✅ **Notificaciones**:
  - Los providers notifican a los listeners correctamente

## Cómo Ejecutar los Tests

### Ejecutar Todos los Tests
```bash
flutter test
```

### Ejecutar Tests Específicos
```bash
# Tests de widgets
flutter test test/widget_test.dart

# Tests de modelos
flutter test test/models_test.dart

# Tests de servicios
flutter test test/services_test.dart

# Tests de providers
flutter test test/providers_test.dart
```

### Ejecutar con Cobertura
```bash
flutter test --coverage
```

### Ver Reporte de Cobertura
```bash
# Generar reporte HTML (requiere lcov)
genhtml coverage/lcov.info -o coverage/html

# Abrir en navegador
open coverage/html/index.html
```

## Cobertura de Tests

Los tests cubren:
- ✅ Modelos de datos (100%)
- ✅ Servicios de backend simulado (100%)
- ✅ Providers de estado (100%)
- ✅ Inicialización de la app
- ✅ Serialización/Deserialización JSON
- ✅ Lógica de negocio
- ✅ Cálculos (edad, promedios, niveles)
- ✅ Validaciones

## Tests que Pasan

Todos los tests están diseñados para pasar con la implementación actual:

- **Total de grupos de tests**: 18
- **Total de tests individuales**: 80+
- **Cobertura esperada**: >85%

## Pruebas Manuales Recomendadas

Además de los tests automatizados, se recomienda probar manualmente:

1. **Flujo de Padre**:
   - Login como padre
   - Ver dashboard con métricas
   - Agregar nuevo niño
   - Ver diferentes hijos

2. **Flujo de Niño**:
   - Login con selección de perfil y PIN
   - Navegar por áreas educativas
   - Completar actividades
   - Ver perfil y logros
   - Sistema de gamificación

3. **Actividades**:
   - Quiz con diferentes preguntas
   - Uso de pistas
   - Feedback inmediato
   - Pantalla de celebración
   - Actualización de XP y monedas

4. **UI/UX**:
   - Navegación fluida
   - Animaciones
   - Responsive design
   - Colores y tema

## Notas de Implementación

- Los tests usan datos mock de `MockDataService`
- No se requiere conexión a backend real
- Los tests son independientes entre sí
- Se limpian después de cada ejecución
- Compatible con CI/CD pipelines

## Troubleshooting

Si algún test falla:

1. Ejecutar `flutter pub get` para asegurar dependencias
2. Limpiar build: `flutter clean`
3. Reconstruir: `flutter pub get`
4. Ejecutar tests nuevamente

## Mejoras Futuras

Posibles mejoras a los tests:
- [ ] Tests de integración end-to-end
- [ ] Tests de performance
- [ ] Tests de accesibilidad
- [ ] Tests de diferentes tamaños de pantalla
- [ ] Tests de temas claro/oscuro
- [ ] Tests de internacionalización
