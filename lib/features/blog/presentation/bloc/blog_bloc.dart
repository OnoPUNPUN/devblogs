import 'dart:io';
import 'package:devblogs/core/error/failures.dart';
import 'package:devblogs/features/blog/domain/entities/blog.dart';
import 'package:devblogs/features/blog/domain/entities/category.dart';
import 'package:devblogs/features/blog/domain/usecases/get_all_blogs_usecase.dart';
import 'package:devblogs/features/blog/domain/usecases/get_blog_by_id_usecase.dart';
import 'package:devblogs/features/blog/domain/usecases/get_categories_usecase.dart';
import 'package:devblogs/features/blog/domain/usecases/upload_blog_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final GetCategoriesUsecase _getCategoriesUsecase;
  final UploadBlogUsecase _uploadBlogUsecase;
  final GetAllBlogsUsecase _getAllBlogsUsecase;
  final GetBlogByIdUsecase _getBlogByIdUsecase;

  BlogBloc({
    required GetCategoriesUsecase getCategoriesUsecase,
    required UploadBlogUsecase uploadBlogUsecase,
    required GetAllBlogsUsecase getAllBlogsUsecase,
    required GetBlogByIdUsecase getBlogByIdUsecase,
  })  : _getCategoriesUsecase = getCategoriesUsecase,
        _uploadBlogUsecase = uploadBlogUsecase,
        _getAllBlogsUsecase = getAllBlogsUsecase,
        _getBlogByIdUsecase = getBlogByIdUsecase,
        super(BlogInitial()) {
    on<BlogFetchCategoriesRequested>(_onFetchCategoriesRequested);
    on<BlogUploadRequested>(_onUploadRequested);
    on<BlogFetchAllRequested>(_onFetchAllRequested);
    on<BlogFetchByIdRequested>(_onFetchByIdRequested);
  }

  Future<void> _onFetchCategoriesRequested(
    BlogFetchCategoriesRequested event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    try {
      final categories = await _getCategoriesUsecase();
      emit(BlogCategoriesFetchSuccess(categories));
    } on Failure catch (e) {
      emit(BlogFailure(e.message));
    } catch (e) {
      emit(BlogFailure(e.toString()));
    }
  }

  Future<void> _onUploadRequested(
    BlogUploadRequested event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    try {
      final blog = await _uploadBlogUsecase(
        title: event.title,
        content: event.content,
        categoryIds: event.categoryIds,
        image: event.image,
      );
      emit(BlogUploadSuccess(blog));
    } on Failure catch (e) {
      emit(BlogFailure(e.message));
    } catch (e) {
      emit(BlogFailure(e.toString()));
    }
  }

  Future<void> _onFetchAllRequested(
    BlogFetchAllRequested event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    try {
      final blogs = await _getAllBlogsUsecase();
      emit(BlogFetchAllSuccess(blogs));
    } on Failure catch (e) {
      emit(BlogFailure(e.message));
    } catch (e) {
      emit(BlogFailure(e.toString()));
    }
  }

  Future<void> _onFetchByIdRequested(
    BlogFetchByIdRequested event,
    Emitter<BlogState> emit,
  ) async {
    emit(BlogLoading());
    try {
      final blog = await _getBlogByIdUsecase(event.id);
      emit(BlogFetchByIdSuccess(blog));
    } on Failure catch (e) {
      emit(BlogFailure(e.message));
    } catch (e) {
      emit(BlogFailure(e.toString()));
    }
  }
}
