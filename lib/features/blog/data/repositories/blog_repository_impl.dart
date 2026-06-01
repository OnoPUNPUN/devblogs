import 'dart:io';
import 'package:devblogs/core/error/exceptions.dart';
import 'package:devblogs/core/error/failures.dart';
import 'package:devblogs/core/network/network_info.dart';
import 'package:devblogs/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:devblogs/features/blog/domain/entities/blog.dart';
import 'package:devblogs/features/blog/domain/entities/category.dart';
import 'package:devblogs/features/blog/domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BlogRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Category>> getCategories() async {
    if (!await networkInfo.isConnected) {
      throw const ConnectionFailure();
    }

    try {
      return await remoteDataSource.getCategories();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    }
  }

  @override
  Future<Blog> uploadBlog({
    required String title,
    required String content,
    required List<int> categoryIds,
    File? image,
  }) async {
    if (!await networkInfo.isConnected) {
      throw const ConnectionFailure();
    }

    try {
      return await remoteDataSource.uploadBlog(
        title: title,
        content: content,
        categoryIds: categoryIds,
        image: image,
      );
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    }
  }

  @override
  Future<List<Blog>> getAllBlogs() async {
    if (!await networkInfo.isConnected) {
      throw const ConnectionFailure();
    }

    try {
      return await remoteDataSource.getAllBlogs();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    }
  }

  @override
  Future<Blog> getBlogById(int id) async {
    if (!await networkInfo.isConnected) {
      throw const ConnectionFailure();
    }

    try {
      return await remoteDataSource.getBlogById(id);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    }
  }
}
