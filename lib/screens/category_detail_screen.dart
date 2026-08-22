import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../widgets/article_card.dart';

class CategoryDetailScreen extends StatelessWidget {
  final Category category;

  const CategoryDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name ?? '分类详情'),
      ),
      body: Consumer<ApiService>(
        builder: (context, apiService, child) {
          // 过滤该分类下的文章
          final categoryArticles = apiService.articles
              .where((article) =>
                  article.categories?.contains(category.id) ?? false)
              .toList();

          if (categoryArticles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.article_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '该分类暂无文章',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: categoryArticles.length,
            itemBuilder: (context, index) {
              return ArticleCardWidget(article: categoryArticles[index]);
            },
          );
        },
      ),
    );
  }
}
