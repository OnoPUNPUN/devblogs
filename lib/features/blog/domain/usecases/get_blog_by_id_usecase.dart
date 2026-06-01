import 'package:devblogs/features/blog/domain/entities/blog.dart';
import 'package:devblogs/features/blog/domain/repositories/blog_repository.dart';

class GetBlogByIdUsecase {
  final BlogRepository repository;

  GetBlogByIdUsecase(this.repository);

  Future<Blog> call(int id) {
    return repository.getBlogById(id);
  }
}
