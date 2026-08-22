FROM ghcr.io/cirruslabs/flutter:stable

WORKDIR /app

# 复制项目文件
COPY pubspec.yaml .
COPY lib ./lib
COPY android ./android
COPY assets ./assets

# 获取依赖
RUN flutter pub get

# 构建 APK
RUN flutter build apk --release

# 输出 APK 路径
CMD ["ls", "-la", "build/app/outputs/flutter-apk/"]
