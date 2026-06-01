import 'package:devblogs/features/blog/domain/entities/category.dart';
import 'package:devblogs/features/blog/domain/repositories/blog_repository.dart';

class GetCategoriesUsecase {
  final BlogRepository repository;

  GetCategoriesUsecase(this.repository);

  Future<List<Category>> call() {
    return repository.getCategories();
  }
}
