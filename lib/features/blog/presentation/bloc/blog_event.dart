part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object?> get props => [];
}

class BlogFetchCategoriesRequested extends BlogEvent {}

class BlogFetchAllRequested extends BlogEvent {}

class BlogFetchByIdRequested extends BlogEvent {
  final int id;

  const BlogFetchByIdRequested(this.id);

  @override
  List<Object?> get props => [id];
}

class BlogUploadRequested extends BlogEvent {
  final String title;
  final String content;
  final List<int> categoryIds;
  final File? image;

  const BlogUploadRequested({
    required this.title,
    required this.content,
    required this.categoryIds,
    this.image,
  });

  @override
  List<Object?> get props => [title, content, categoryIds, image];
}
