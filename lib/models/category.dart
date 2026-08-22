class Category {
  final String? id;
  final String? name;
  final String? slug;
  final String? description;
  final int? postCount;
  final int? order;

  Category({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.postCount,
    this.order,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['metadata']?['name'] ?? json['id'],
      name: json['spec']?['displayName'] ?? json['name'],
      slug: json['spec']?['slug'] ?? json['slug'],
      description: json['spec']?['description'] ?? json['description'],
      postCount: json['stat']?['post'] ?? 0,
      order: json['spec']?['priority'] ?? 0,
    );
  }
}
