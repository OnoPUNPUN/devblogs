import 'package:devblogs/features/blog/domain/entities/blog.dart';
import 'package:devblogs/features/blog/domain/repositories/blog_repository.dart';

class GetAllBlogsUsecase {
  final BlogRepository repository;

  GetAllBlogsUsecase(this.repository);

  Future<List<Blog>> call() {
    return repository.getAllBlogs();
  }
}
