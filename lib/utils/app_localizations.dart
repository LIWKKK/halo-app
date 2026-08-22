import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const Map<String, Map<String, String>> _localizedValues = {
    'zh': {
      'appTitle': 'Halo 客户端',
      'home': '首页',
      'articles': '文章',
      'categories': '分类',
      'tags': '标签',
      'settings': '设置',
      'about': '关于',
      'version': '版本',
      'license': '开源协议',
      'website': '官方网站',
      'features': '功能说明',
      'articleManagement': '文章管理',
      'articleManagementDesc': '查看、创建、编辑和删除文章',
      'categoryManagement': '分类管理',
      'categoryManagementDesc': '浏览文章分类',
      'tagManagement': '标签管理',
      'tagManagementDesc': '浏览文章标签',
      'realTimeSync': '实时同步',
      'realTimeSyncDesc': '自动同步服务器上的最新内容',
      'serverSettings': '服务器设置',
      'serverAddress': 'Halo 服务器地址',
      'saveSettings': '保存设置',
      'settingsSaved': '设置已保存',
      'saveFailed': '保存失败',
      'loading': '加载中...',
      'noArticles': '暂无文章',
      'createFirstArticle': '点击右下角按钮创建第一篇文章',
      'noCategories': '暂无分类',
      'noTags': '暂无标签',
      'articleDetail': '文章详情',
      'editArticle': '编辑文章',
      'createArticle': '新建文章',
      'title': '标题',
      'titleHint': '请输入文章标题',
      'slug': '别名（可选）',
      'slugHint': '用于 URL，留空自动生成',
      'excerpt': '摘要',
      'excerptHint': '文章摘要，留空自动生成',
      'content': '内容',
      'contentHint': '支持 Markdown 格式',
      'pinned': '置顶',
      'pinnedDesc': '将文章置顶显示',
      'allowComment': '允许评论',
      'allowCommentDesc': '允许读者评论此文章',
      'publicPublish': '公开发布',
      'publicPublishDesc': '发布后所有人可见',
      'save': '保存',
      'saveSuccess': '保存成功',
      'saveFailedMsg': '保存失败',
      'delete': '删除',
      'publish': '发布',
      'unpublish': '取消发布',
      'unpin': '取消置顶',
      'cancel': '取消',
      'confirm': '确认',
      'deleteConfirm': '确认删除此文章？',
      'posts': '篇文章',
      'comments': '条评论',
      'likes': '个赞',
    },
    'en': {
      'appTitle': 'Halo Client',
      'home': 'Home',
      'articles': 'Articles',
      'categories': 'Categories',
      'tags': 'Tags',
      'settings': 'Settings',
      'about': 'About',
      'version': 'Version',
      'license': 'License',
      'website': 'Website',
      'features': 'Features',
      'articleManagement': 'Article Management',
      'articleManagementDesc': 'View, create, edit and delete articles',
      'categoryManagement': 'Category Management',
      'categoryManagementDesc': 'Browse article categories',
      'tagManagement': 'Tag Management',
      'tagManagementDesc': 'Browse article tags',
      'realTimeSync': 'Real-time Sync',
      'realTimeSyncDesc': 'Auto sync latest content from server',
      'serverSettings': 'Server Settings',
      'serverAddress': 'Halo Server Address',
      'saveSettings': 'Save Settings',
      'settingsSaved': 'Settings saved',
      'saveFailed': 'Save failed',
      'loading': 'Loading...',
      'noArticles': 'No articles',
      'createFirstArticle': 'Tap the button below to create your first article',
      'noCategories': 'No categories',
      'noTags': 'No tags',
      'articleDetail': 'Article Detail',
      'editArticle': 'Edit Article',
      'createArticle': 'Create Article',
      'title': 'Title',
      'titleHint': 'Enter article title',
      'slug': 'Slug (optional)',
      'slugHint': 'For URL, leave empty to auto generate',
      'excerpt': 'Excerpt',
      'excerptHint': 'Article excerpt, leave empty to auto generate',
      'content': 'Content',
      'contentHint': 'Supports Markdown format',
      'pinned': 'Pinned',
      'pinnedDesc': 'Pin this article to top',
      'allowComment': 'Allow Comments',
      'allowCommentDesc': 'Allow readers to comment on this article',
      'publicPublish': 'Public',
      'publicPublishDesc': 'Visible to everyone after publishing',
      'save': 'Save',
      'saveSuccess': 'Saved successfully',
      'saveFailedMsg': 'Failed to save',
      'delete': 'Delete',
      'publish': 'Publish',
      'unpublish': 'Unpublish',
      'unpin': 'Unpin',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'deleteConfirm': 'Confirm delete this article?',
      'posts': ' posts',
      'comments': ' comments',
      'likes': ' likes',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['zh', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
