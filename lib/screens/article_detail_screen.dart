import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../services/api_service.dart';
import 'article_editor_screen.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文章详情'),
        actions: [
          // 编辑按钮（当前版本不可用，需要认证）
          // IconButton(
          //   icon: const Icon(Icons.edit),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ArticleEditorScreen(
          //           article: article,
          //           isEdit: true,
          //         ),
          //       ),
          //     );
          //   },
          // ),
          // 菜单按钮（当前版本不可用，需要认证）
          // PopupMenuButton<String>(
          //   onSelected: (value) {
          //     _handleMenuAction(context, value);
          //   },
          //   itemBuilder: (context) => [
          //     if (article.pinned != true)
          //       const PopupMenuItem(
          //         value: 'pin',
          //         child: Text('置顶'),
          //       ),
          //     if (article.pinned == true)
          //       const PopupMenuItem(
          //         value: 'unpin',
          //         child: Text('取消置顶'),
          //       ),
          //     if (article.visible == true)
          //       const PopupMenuItem(
          //         value: 'unpublish',
          //         child: Text('取消发布'),
          //       ),
          //     if (article.visible != true)
          //       const PopupMenuItem(
          //         value: 'publish',
          //         child: Text('发布'),
          //       ),
          //     const PopupMenuItem(
          //       value: 'delete',
          //       child: Text('删除', style: TextStyle(color: Colors.red)),
          //     ),
          //   ],
          // ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 标题
            Text(
              article.title ?? '无标题',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // 元信息
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  article.formattedDate,
                  style: TextStyle(color: Colors.grey[500], fontSize: 14),
                ),
                const SizedBox(width: 16),
                if (article.likeCount != null && article.likeCount! > 0) ...[
                  Icon(Icons.favorite_outline, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    '${article.likeCount}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                  ),
                ],
                if (article.commentCount != null && article.commentCount! > 0) ...[
                  const SizedBox(width: 16),
                  Icon(Icons.comment_outlined, size: 14, color: Colors.grey[500]),
                  const SizedBox(width: 4),
                  Text(
                    '${article.commentCount}',
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                  ),
                ],
              ],
            ),
            
            // 分类和标签
            if ((article.categories != null && article.categories!.isNotEmpty) ||
                (article.tags != null && article.tags!.isNotEmpty)) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (article.categories != null)
                    ...article.categories!.map((cat) => Chip(
                          label: Text(cat),
                          backgroundColor: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.1),
                        )),
                  if (article.tags != null)
                    ...article.tags!.map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: Colors.grey[200],
                        )),
                ],
              ),
            ],
            
            const SizedBox(height: 24),
            
            // 内容
            if (article.content != null && article.content!.isNotEmpty)
              Html(
                data: article.content!,
                style: {
                  'body': Style(
                    fontSize: FontSize(16),
                    lineHeight: LineHeight(1.6),
                  ),
                  'p': Style(
                    margin: Margins.only(bottom: 12),
                  ),
                  'img': Style(
                    width: Width(100, Unit.percent),
                  ),
                },
              )
            else
              const Text(
                '暂无内容',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(BuildContext context, String action) async {
    final apiService = context.read<ApiService>();
    bool success = false;
    
    switch (action) {
      case 'pin':
        success = await apiService.pinArticle(article.id!);
        break;
      case 'unpin':
        success = await apiService.unpinArticle(article.id!);
        break;
      case 'publish':
        success = await apiService.publishArticle(article.id!);
        break;
      case 'unpublish':
        success = await apiService.unpublishArticle(article.id!);
        break;
      case 'delete':
        // 显示确认对话框
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('确认删除'),
            content: const Text('确定要删除这篇文章吗？此操作不可撤销。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('删除', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
        
        if (confirmed == true) {
          success = await apiService.deleteArticle(article.id!);
          if (success && context.mounted) {
            Navigator.pop(context); // 返回上一页
          }
        }
        break;
    }
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? '操作成功' : '操作失败'),
          backgroundColor: success ? Colors.green : Colors.red,
        ),
      );
      
      // 刷新数据
      if (success) {
        apiService.refresh();
      }
    }
  }
}
