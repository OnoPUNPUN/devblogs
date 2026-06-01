part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object?> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogFailure extends BlogState {
  final String message;

  const BlogFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class BlogUploadSuccess extends BlogState {
  final Blog blog;

  const BlogUploadSuccess(this.blog);

  @override
  List<Object?> get props => [blog];
}

class BlogCategoriesFetchSuccess extends BlogState {
  final List<Category> categories;

  const BlogCategoriesFetchSuccess(this.categories);

  @override
  List<Object?> get props => [categories];
}

class BlogFetchAllSuccess extends BlogState {
  final List<Blog> blogs;

  const BlogFetchAllSuccess(this.blogs);

  @override
  List<Object?> get props => [blogs];
}

class BlogFetchByIdSuccess extends BlogState {
  final Blog blog;

  const BlogFetchByIdSuccess(this.blog);

  @override
  List<Object?> get props => [blog];
}
