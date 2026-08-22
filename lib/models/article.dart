class Article {
  final String? id;
  final String? title;
  final String? slug;
  final String? content;
  final String? excerpt;
  final DateTime? publishTime;
  final DateTime? updateTime;
  final String? cover;
  final bool? pinned;
  final bool? allowComment;
  final bool? visible;
  final int? likeCount;
  final int? commentCount;
  final List<String>? tags;
  final List<String>? categories;
  final Map<String, dynamic>? metadata;

  Article({
    this.id,
    this.title,
    this.slug,
    this.content,
    this.excerpt,
    this.publishTime,
    this.updateTime,
    this.cover,
    this.pinned,
    this.allowComment,
    this.visible,
    this.likeCount,
    this.commentCount,
    this.tags,
    this.categories,
    this.metadata,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['metadata']?['name'] ?? json['id'],
      title: json['spec']?['title'] ?? json['title'],
      slug: json['spec']?['slug'] ?? json['slug'],
      content: json['spec']?['content']?['raw'] ?? json['content'],
      excerpt: json['spec']?['excerpt']?['autoGenerate'] == false
          ? json['spec']?['excerpt']?['raw']
          : json['excerpt'],
      publishTime: json['spec']?['publishTime'] != null
          ? DateTime.parse(json['spec']['publishTime'])
          : null,
      updateTime: json['metadata']?['updateTime'] != null
          ? DateTime.parse(json['metadata']['updateTime'])
          : null,
      cover: json['spec']?['cover'] ?? json['cover'],
      pinned: json['spec']?['pinned'] ?? false,
      allowComment: json['spec']?['allowComment'] ?? true,
      visible: json['spec']?['visible'] ?? true,
      likeCount: json['stat']?['like'] ?? 0,
      commentCount: json['stat']?['comment'] ?? 0,
      tags: json['spec']?['tags']?.cast<String>() ?? [],
      categories: json['spec']?['categories']?.cast<String>() ?? [],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'spec': {
        'title': title,
        'slug': slug,
        'content': {'raw': content, 'html': ''},
        'excerpt': {'raw': excerpt, 'autoGenerate': false},
        'cover': cover,
        'pinned': pinned,
        'allowComment': allowComment,
        'visible': visible,
        'tags': tags,
        'categories': categories,
        'publishTime': publishTime?.toIso8601String(),
      },
      'metadata': metadata,
    };
  }

  String get formattedDate {
    if (publishTime == null) return '';
    return '${publishTime!.year}-${publishTime!.month.toString().padLeft(2, '0')}-${publishTime!.day.toString().padLeft(2, '0')}';
  }
}
