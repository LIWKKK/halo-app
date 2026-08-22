import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/article.dart';

class ArticleEditorScreen extends StatefulWidget {
  final Article? article;
  final bool isEdit;

  const ArticleEditorScreen({
    super.key,
    this.article,
    this.isEdit = false,
  });

  @override
  State<ArticleEditorScreen> createState() => _ArticleEditorScreenState();
}

class _ArticleEditorScreenState extends State<ArticleEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _excerptController = TextEditingController();
  final _slugController = TextEditingController();
  
  bool _pinned = false;
  bool _allowComment = true;
  bool _visible = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.article != null) {
      _titleController.text = widget.article!.title ?? '';
      _contentController.text = widget.article!.content ?? '';
      _excerptController.text = widget.article!.excerpt ?? '';
      _slugController.text = widget.article!.slug ?? '';
      _pinned = widget.article!.pinned ?? false;
      _allowComment = widget.article!.allowComment ?? true;
      _visible = widget.article!.visible ?? true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _excerptController.dispose();
    _slugController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? '编辑文章' : '新建文章'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveArticle,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('保存'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 标题
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '标题',
                hintText: '请输入文章标题',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入标题';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // 别名
            TextFormField(
              controller: _slugController,
              decoration: const InputDecoration(
                labelText: '别名（可选）',
                hintText: '用于 URL，留空自动生成',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            // 摘要
            TextFormField(
              controller: _excerptController,
              decoration: const InputDecoration(
                labelText: '摘要',
                hintText: '文章摘要，留空自动生成',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            
            // 内容
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: '内容',
                hintText: '支持 Markdown 格式',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 15,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入内容';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            // 选项
            SwitchListTile(
              title: const Text('置顶'),
              subtitle: const Text('将文章置顶显示'),
              value: _pinned,
              onChanged: (value) {
                setState(() {
                  _pinned = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('允许评论'),
              subtitle: const Text('允许读者评论此文章'),
              value: _allowComment,
              onChanged: (value) {
                setState(() {
                  _allowComment = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('公开发布'),
              subtitle: const Text('发布后所有人可见'),
              value: _visible,
              onChanged: (value) {
                setState(() {
                  _visible = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveArticle() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final apiService = context.read<ApiService>();
      
      final article = Article(
        title: _titleController.text.trim(),
        slug: _slugController.text.trim().isEmpty ? null : _slugController.text.trim(),
        content: _contentController.text,
        excerpt: _excerptController.text.trim().isEmpty ? null : _excerptController.text.trim(),
        pinned: _pinned,
        allowComment: _allowComment,
        visible: _visible,
      );

      Article? result;
      if (widget.isEdit && widget.article?.id != null) {
        result = await apiService.updateArticle(widget.article!.id!, article);
      } else {
        result = await apiService.createArticle(article);
      }

      if (result != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('保存成功')),
        );
        Navigator.pop(context, true);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('保存失败')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('错误: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
