import 'dart:io';
import 'package:devblogs/core/error/exceptions.dart';
import 'package:devblogs/core/network/api_client.dart';
import 'package:devblogs/features/blog/data/models/blog_model.dart';
import 'package:devblogs/features/blog/data/models/category_model.dart';
import 'package:dio/dio.dart';

abstract interface class BlogRemoteDataSource {
  Future<List<CategoryModel>> getCategories();

  Future<BlogModel> uploadBlog({
    required String title,
    required String content,
    required List<int> categoryIds,
    File? image,
  });

  Future<List<BlogModel>> getAllBlogs();

  Future<BlogModel> getBlogById(int id);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final ApiClient apiClient;

  BlogRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await apiClient.get('/categories');
      final list = response.data as List<dynamic>;
      return list
          .map((c) => CategoryModel.fromJson(c as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BlogModel> uploadBlog({
    required String title,
    required String content,
    required List<int> categoryIds,
    File? image,
  }) async {
    try {
      Response response;
      if (image != null) {
        final formData = FormData.fromMap({
          'title': title,
          'content': content,
          'categoryIds[]': categoryIds,
          'image': await MultipartFile.fromFile(image.path),
        });
        response = await apiClient.post(
          '/blogs',
          data: formData,
        );
      } else {
        response = await apiClient.post(
          '/blogs',
          data: {
            'title': title,
            'content': content,
            'categoryIds': categoryIds,
          },
        );
      }

      final blogData = response.data['blog'] as Map<String, dynamic>;
      return BlogModel.fromJson(blogData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final response = await apiClient.get('/blogs');
      final list = response.data as List<dynamic>;
      return list
          .map((b) => BlogModel.fromJson(b as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<BlogModel> getBlogById(int id) async {
    try {
      final response = await apiClient.get('/blogs/$id');
      final data = response.data;
      final blogData = data is Map && data.containsKey('blog')
          ? data['blog'] as Map<String, dynamic>
          : data as Map<String, dynamic>;
      return BlogModel.fromJson(blogData);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
