#!/bin/bash

# Halo App 本地构建脚本
# 在你的电脑上运行，需要安装 Flutter SDK

echo "开始构建 Halo App..."

# 进入项目目录
cd halo_app || { echo "找不到项目目录"; exit 1; }

# 获取依赖
echo "获取依赖..."
flutter pub get || { echo "flutter pub get 失败"; exit 1; }

# 构建 APK
echo "构建 APK..."
flutter build apk --release || { echo "构建失败"; exit 1; }

echo "✅ 构建完成！"
echo "APK 位置：build/app/outputs/flutter-apk/app-release.apk"
ls -lh build/app/outputs/flutter-apk/app-release.apk
