import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';
import '../models/category.dart';
import '../models/tag.dart';

class ApiService extends ChangeNotifier {
  // Halo 服务器地址
  String baseUrl = 'https://liweike.site';
  
  // API 路径
  static const String apiPrefix = '/apis';
  static const String contentApi = '/apis/api.content.halo.run/v1alpha1';
  // 注意：console API 需要认证，这里使用公开的 content API
  static const String systemApi = '/apis/api.content.halo.run/v1alpha1';

  // 分页信息
  int currentPage = 1;
  int pageSize = 10;
  bool hasMore = true;
  bool isLoading = false;

  // 数据列表
  List<Article> articles = [];
  List<Category> categories = [];
  List<Tag> tags = [];

  ApiService() {
    // 默认地址，可通过设置修改
  }

  // 设置服务器地址
  void setBaseUrl(String url) {
    baseUrl = url.endsWith('/') ? url.substring(0, url.length - 1) : url;
    notifyListeners();
  }

  // 获取文章列表
  Future<List<Article>> getArticles({int page = 1, int size = 10, String? category, String? tag}) async {
    try {
      // 使用公开的 content API
      String url = '$baseUrl$apiPrefix/api.content.halo.run/v1alpha1/posts?page=$page&size=$size';
      if (category != null) {
        url += '&category=$category';
      }
      if (tag != null) {
        url += '&tag=$tag';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> items = data['items'] ?? [];
        final List<Article> result = items.map((item) => Article.fromJson(item)).toList();
        
        // 更新分页信息
        currentPage = page;
        hasMore = data['page']?['hasNext'] ?? false;
        
        if (page == 1) {
          articles = result;
        } else {
          articles.addAll(result);
        }
        
        notifyListeners();
        return result;
      } else {
        throw Exception('加载文章失败: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('获取文章列表错误: $e');
      rethrow;
    }
  }

  // 获取文章详情
  Future<Article?> getArticle(String id) async {
    try {
      // 使用公开的 content API
      final response = await http.get(
        Uri.parse('$baseUrl$apiPrefix/api.content.halo.run/v1alpha1/posts/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Article.fromJson(data);
      }
      return null;
    } catch (e) {
      debugPrint('获取文章详情错误: $e');
      return null;
    }
  }

  // 获取分类列表
  Future<List<Category>> getCategories() async {
    try {
      // 使用公开的 content API
      final response = await http.get(
        Uri.parse('$baseUrl$apiPrefix/api.content.halo.run/v1alpha1/categories'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> items = data['items'] ?? [];
        categories = items.map((item) => Category.fromJson(item)).toList();
        notifyListeners();
        return categories;
      }
      return [];
    } catch (e) {
      debugPrint('获取分类错误: $e');
      return [];
    }
  }

  // 获取标签列表
  Future<List<Tag>> getTags() async {
    try {
      // 使用公开的 content API
      final response = await http.get(
        Uri.parse('$baseUrl$apiPrefix/api.content.halo.run/v1alpha1/tags'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> items = data['items'] ?? [];
        tags = items.map((item) => Tag.fromJson(item)).toList();
        notifyListeners();
        return tags;
      }
      return [];
    } catch (e) {
      debugPrint('获取标签错误: $e');
      return [];
    }
  }

  // 创建文章（需要认证）
  Future<Article?> createArticle(Article article) async {
    // 当前版本不支持，需要配置认证
    debugPrint('创建文章需要认证，请配置登录信息');
    return null;
  }

  // 更新文章（需要认证）
  Future<Article?> updateArticle(String id, Article article) async {
    // 当前版本不支持，需要配置认证
    debugPrint('更新文章需要认证，请配置登录信息');
    return null;
  }

  // 删除文章（需要认证）
  Future<bool> deleteArticle(String id) async {
    // 当前版本不支持，需要配置认证
    debugPrint('删除文章需要认证，请配置登录信息');
    return false;
  }

  // 发布文章（需要认证）
  Future<bool> publishArticle(String id) async {
    // 当前版本不支持，需要配置认证
    debugPrint('发布文章需要认证，请配置登录信息');
    return false;
  }

  // 取消发布（需要认证）
  Future<bool> unpublishArticle(String id) async {
    // 当前版本不支持，需要配置认证
    debugPrint('取消发布需要认证，请配置登录信息');
    return false;
  }

  // 置顶文章（需要认证）
  Future<bool> pinArticle(String id) async {
    // 当前版本不支持，需要配置认证
    debugPrint('置顶文章需要认证，请配置登录信息');
    return false;
  }

  // 取消置顶（需要认证）
  Future<bool> unpinArticle(String id) async {
    // 当前版本不支持，需要配置认证
    debugPrint('取消置顶需要认证，请配置登录信息');
    return false;
  }

  // 刷新数据
  Future<void> refresh() async {
    currentPage = 1;
    hasMore = true;
    await getArticles(page: 1);
    await getCategories();
    await getTags();
  }

  // 加载更多
  Future<void> loadMore() async {
    if (!isLoading && hasMore) {
      isLoading = true;
      notifyListeners();
      
      await getArticles(page: currentPage + 1);
      
      isLoading = false;
      notifyListeners();
    }
  }
}
