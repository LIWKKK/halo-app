# Halo 客户端 - 快速安装指南

## 方案一：Android Studio（推荐）

### 1. 下载项目

项目已打包在：`/vol1/@apphome/trim.openclaw/data/workspace/halo_app.tar.gz`

### 2. 解压到本地

```bash
tar xzf halo_app.tar.gz
```

### 3. 用 Android Studio 打开

1. 打开 Android Studio
2. 选择 "Open an Existing Project"
3. 选择解压后的 `halo_app` 文件夹
4. 等待 Gradle 同步完成

### 4. 运行

1. 连接 Android 手机或启动模拟器
2. 点击绿色运行按钮 ▶️

### 5. 构建 APK

```bash
# 在项目目录执行
flutter build apk --release
# 或者用 Android Studio: Build > Build Bundle(s) / APK(s) > Build APK(s)
```

APK 位置：`build/app/outputs/flutter-apk/app-release.apk`

---

## 方案二：命令行构建

### 1. 安装 Flutter

```bash
# macOS
brew install flutter

# Windows
# 下载 https://docs.flutter.dev/get-started/install

# Linux
sudo snap install flutter --classic
```

### 2. 进入项目目录

```bash
cd halo_app
```

### 3. 获取依赖

```bash
flutter pub get
```

### 4. 运行或构建

```bash
# 运行调试版
flutter run

# 构建发布版 APK
flutter build apk --release
```

---

## 配置说明

### 服务器地址

默认配置为 `http://192.168.3.88:28090`

如需修改，编辑 `lib/screens/settings_screen.dart` 中的默认值：

```dart
final url = prefs.getString('halo_url') ?? 'http://192.168.3.88:28090';
```

### 网络权限

Android 默认禁止明文 HTTP 测试，已配置 `android:usesCleartextTraffic="true"`

---

## 常见问题

### Q: 构建失败怎么办？

A: 确保：
- Flutter SDK 版本 >= 3.0
- Android SDK 已安装
- 运行 `flutter doctor` 检查环境

### Q: 无法连接服务器？

A: 检查：
- 手机和 NAS 在同一局域网
- Halo 服务正常运行
- 防火墙允许访问 28090 端口

### Q: 如何添加认证？

A: 在 `lib/services/api_service.dart` 中添加认证头：

```dart
headers: {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer YOUR_TOKEN',
},
```

---

## 技术支持

项目路径：`/vol1/@apphome/trim.openclaw/data/workspace/halo_app/`

如需帮助，可以查看：
- `README.md` - 项目说明
- `lib/` - 源代码
- `pubspec.yaml` - 依赖配置
