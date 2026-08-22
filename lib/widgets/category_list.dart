import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/category.dart';
import '../screens/category_detail_screen.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiService>(
      builder: (context, apiService, child) {
        if (apiService.categories.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: apiService.categories.length,
          itemBuilder: (context, index) {
            final category = apiService.categories[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.folder,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                title: Text(category.name ?? '未命名分类'),
                subtitle: Text(
                  '${category.postCount ?? 0} 篇文章',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetailScreen(
                        category: category,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
