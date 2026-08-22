class Tag {
  final String? id;
  final String? name;
  final String? slug;
  final String? color;
  final String? cover;
  final int? postCount;

  Tag({
    this.id,
    this.name,
    this.slug,
    this.color,
    this.cover,
    this.postCount,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['metadata']?['name'] ?? json['id'],
      name: json['spec']?['displayName'] ?? json['name'],
      slug: json['spec']?['slug'] ?? json['slug'],
      color: json['spec']?['color'],
      cover: json['spec']?['cover'],
      postCount: json['stat']?['post'] ?? 0,
    );
  }
}
