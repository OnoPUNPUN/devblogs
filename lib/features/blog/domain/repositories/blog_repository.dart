import 'dart:io';
import 'package:devblogs/features/blog/domain/entities/blog.dart';
import 'package:devblogs/features/blog/domain/entities/category.dart';

abstract interface class BlogRepository {
  Future<List<Category>> getCategories();

  Future<Blog> uploadBlog({
    required String title,
    required String content,
    required List<int> categoryIds,
    File? image,
  });

  Future<List<Blog>> getAllBlogs();

  Future<Blog> getBlogById(int id);
}
