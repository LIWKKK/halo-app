#!/bin/bash

# Halo 客户端构建脚本

set -e

echo "=== Halo 客户端构建脚本 ==="
echo ""

# 检查 Flutter 是否安装
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter 未安装，请先安装 Flutter SDK"
    echo "   安装指南：https://docs.flutter.dev/get-started/install"
    exit 1
fi

# 检查 Flutter 版本
echo "📋 Flutter 版本信息："
flutter --version
echo ""

# 获取依赖
echo "📦 获取依赖..."
flutter pub get
echo ""

# 运行代码分析
echo "🔍 代码分析..."
flutter analyze
echo ""

# 构建 APK
echo "🏗️  构建 APK..."
flutter build apk --release
echo ""

echo "✅ 构建完成！"
echo "   APK 文件位于: build/app/outputs/flutter-apk/app-release.apk"
echo ""

# 可选：安装到设备
read -p "是否要安装到连接的设备？(y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📱 安装到设备..."
    flutter install
fi
