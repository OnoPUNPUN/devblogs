import 'package:devblogs/features/blog/data/models/category_model.dart';
import 'package:devblogs/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  const BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.authorId,
    required super.createdAt,
    required super.updatedAt,
    required super.userName,
    required super.categories,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as int,
      title: json['title'] as String,
      content: (json['content'] as String?) ?? '',
      imageUrl: json['imageUrl'] as String?,
      authorId: (json['authorId'] as int?) ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      userName: json['author'] != null
          ? ((json['author'] as Map<String, dynamic>)['username'] as String? ?? 'Anonymous')
          : 'Anonymous',
      categories: json['categories'] != null
          ? (json['categories'] as List<dynamic>)
              .map((c) => CategoryModel.fromJson(c as Map<String, dynamic>))
              .toList()
          : const [],
    );
  }
}
