# Halo 客户端

一个基于 Flutter 的 Android 应用，用于管理和浏览您的 Halo CMS 内容。

## 功能特性

- ✅ 文章列表浏览（支持分页加载）
- ✅ 文章详情查看（支持 Markdown 渲染）
- ✅ 分类浏览
- ✅ 标签浏览
- ✅ 实时同步服务器内容
- ✅ 中英文本地化支持
- ✅ Material Design 3 界面
- ⚠️ 文章创建/编辑/删除（需要配置认证）

## 环境要求

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio / VS Code
- Android SDK（API 21+）

## 快速开始

### 1. 克隆项目

```bash
git clone <repository-url>
cd halo_app
```

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 配置服务器地址

在应用设置中配置您的 Halo 服务器地址：
- 默认地址：`https://liweike.site`
- 支持 HTTP 和 HTTPS

### 4. 运行应用

```bash
# 调试模式
flutter run

# 构建 APK
flutter build apk --release
```

## 项目结构

```
halo_app/
├── lib/
│   ├── main.dart                 # 应用入口
│   ├── models/                   # 数据模型
│   │   ├── article.dart         # 文章模型
│   │   ├── category.dart        # 分类模型
│   │   └── tag.dart             # 标签模型
│   ├── services/                 # 服务层
│   │   └── api_service.dart     # Halo API 服务
│   ├── screens/                  # 页面
│   │   ├── home_screen.dart     # 首页
│   │   ├── article_detail_screen.dart  # 文章详情
│   │   ├── article_editor_screen.dart  # 文章编辑器
│   │   ├── category_detail_screen.dart # 分类详情
│   │   └── settings_screen.dart # 设置页面
│   ├── widgets/                  # 可复用组件
│   │   ├── article_list.dart    # 文章列表
│   │   ├── article_card.dart    # 文章卡片
│   │   └── category_list.dart   # 分类列表
│   └── utils/                    # 工具类
│       └── app_localizations.dart # 本地化支持
├── android/                      # Android 原生配置
├── assets/                       # 资源文件
└── pubspec.yaml                  # 依赖配置
```

## API 接口

本应用使用 Halo CMS 的 REST API：

- 获取文章列表：`GET /apis/api.console.halo.run/v1alpha1/posts`
- 获取文章详情：`GET /apis/api.console.halo.run/v1alpha1/posts/{id}`
- 创建文章：`POST /apis/api.console.halo.run/v1alpha1/posts`
- 更新文章：`PUT /apis/api.console.halo.run/v1alpha1/posts/{id}`
- 删除文章：`DELETE /apis/api.console.halo.run/v1alpha1/posts/{id}`
- 发布文章：`PUT /apis/api.console.halo.run/v1alpha1/posts/{id}/publish`
- 取消发布：`PUT /apis/api.console.halo.run/v1alpha1/posts/{id}/unpublish`
- 置顶文章：`PUT /apis/api.console.halo.run/v1alpha1/posts/{id}/pin`
- 取消置顶：`PUT /apis/api.console.halo.run/v1alpha1/posts/{id}/unpin`
- 获取分类：`GET /apis/api.content.halo.run/v1alpha1/categories`
- 获取标签：`GET /apis/api.content.halo.run/v1alpha1/tags`

## 注意事项

1. **网络安全**：确保您的 Halo 服务器允许来自移动设备的访问
2. **HTTPS 配置**：推荐使用 HTTPS 以保证数据传输安全
3. **CORS 配置**：如果遇到跨域问题，需要在 Halo 服务器配置 CORS
4. **认证**：当前版本未实现认证功能，如需认证请自行扩展
5. **图片加载**：确保 Halo 服务器的图片 URL 可从移动设备访问

## 开发说明

### 添加新功能

1. 在 `models/` 中创建数据模型
2. 在 `services/` 中添加 API 调用
3. 在 `screens/` 中创建页面
4. 在 `widgets/` 中创建可复用组件

### 本地化

翻译文件位于 `lib/utils/app_localizations.dart`，支持中英文。

## 许可证

MIT License

## 相关链接

- [Halo 官网](https://halo.run)
- [Halo 文档](https://docs.halo.run)
- [Flutter 官网](https://flutter.dev)
# Trigger build
# Build trigger
# Updated workflow
