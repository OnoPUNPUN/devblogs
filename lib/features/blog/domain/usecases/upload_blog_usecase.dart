import 'dart:io';
import 'package:devblogs/features/blog/domain/entities/blog.dart';
import 'package:devblogs/features/blog/domain/repositories/blog_repository.dart';

class UploadBlogUsecase {
  final BlogRepository repository;

  UploadBlogUsecase(this.repository);

  Future<Blog> call({
    required String title,
    required String content,
    required List<int> categoryIds,
    File? image,
  }) {
    return repository.uploadBlog(
      title: title,
      content: content,
      categoryIds: categoryIds,
      image: image,
    );
  }
}
