import 'package:devblogs/features/blog/domain/entities/category.dart';
import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final int id;
  final String title;
  final String content;
  final String? imageUrl;
  final int authorId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userName;
  final List<Category> categories;

  const Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.authorId,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.categories,
  });

  List<String> get topics => categories.map((c) => c.name).toList();

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        imageUrl,
        authorId,
        createdAt,
        updatedAt,
        userName,
        categories,
      ];
}
