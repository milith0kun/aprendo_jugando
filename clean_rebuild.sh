#!/bin/bash

# Script de Limpieza Profunda para Flutter
# Resuelve problemas de caché y versiones antiguas

echo "=========================================="
echo "  LIMPIEZA PROFUNDA DE FLUTTER"
echo "=========================================="
echo ""

# Paso 1: Detener cualquier proceso de Flutter
echo "🛑 Paso 1/7: Deteniendo procesos de Flutter..."
killall -9 flutter dart 2>/dev/null || true
echo "✅ Procesos detenidos"
echo ""

# Paso 2: Limpiar Flutter
echo "🧹 Paso 2/7: Ejecutando flutter clean..."
flutter clean
echo "✅ Flutter clean completado"
echo ""

# Paso 3: Eliminar archivos de build manualmente
echo "🗑️  Paso 3/7: Eliminando carpetas de build..."
rm -rf build/
rm -rf .dart_tool/
rm -rf .flutter-plugins
rm -rf .flutter-plugins-dependencies
rm -rf .packages
echo "✅ Carpetas eliminadas"
echo ""

# Paso 4: Limpiar caché de Flutter global
echo "🧼 Paso 4/7: Limpiando caché global de Flutter..."
flutter pub cache clean
echo "✅ Caché global limpiado"
echo ""

# Paso 5: Limpiar caché de Android (si existe)
if [ -d "android" ]; then
    echo "🤖 Paso 5/7: Limpiando build de Android..."
    rm -rf android/app/build/
    rm -rf android/build/
    rm -rf android/.gradle/
    echo "✅ Build de Android limpiado"
else
    echo "⏭️  Paso 5/7: No hay carpeta android, saltando..."
fi
echo ""

# Paso 6: Limpiar caché de iOS (si existe)
if [ -d "ios" ]; then
    echo "🍎 Paso 6/7: Limpiando build de iOS..."
    rm -rf ios/Pods/
    rm -rf ios/.symlinks/
    rm -rf ios/Flutter/Flutter.framework
    rm -rf ios/Flutter/Flutter.podspec
    rm -rf ios/Podfile.lock
    echo "✅ Build de iOS limpiado"
else
    echo "⏭️  Paso 6/7: No hay carpeta ios, saltando..."
fi
echo ""

# Paso 7: Reinstalar dependencias
echo "📦 Paso 7/7: Reinstalando dependencias..."
flutter pub get
echo "✅ Dependencias reinstaladas"
echo ""

echo "=========================================="
echo "  ✅ LIMPIEZA COMPLETADA"
echo "=========================================="
echo ""
echo "Próximos pasos:"
echo "1. Cierra COMPLETAMENTE tu IDE/editor"
echo "2. Reabre el proyecto"
echo "3. Ejecuta: flutter run --no-hot-reload"
echo "   (O usa F5 en tu IDE)"
echo ""
echo "⚠️  IMPORTANTE: NO uses Hot Reload (r)"
echo "   USA Hot Restart (R) o reinicia la app"
echo ""
