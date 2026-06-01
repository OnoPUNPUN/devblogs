import 'dart:io';
import 'package:devblogs/core/common/widgets/loader.dart';
import 'package:devblogs/features/blog/domain/entities/category.dart';
import 'package:devblogs/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:devblogs/features/blog/presentation/widgets/blog_editor.dart';
import 'package:devblogs/features/blog/presentation/widgets/blog_topic_filter.dart';
import 'package:devblogs/features/blog/presentation/widgets/select_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddNewBlogScreen extends StatefulWidget {
  static const name = "/add-new-blog";
  const AddNewBlogScreen({super.key});

  @override
  State<AddNewBlogScreen> createState() => _AddNewBlogScreenState();
}

class _AddNewBlogScreenState extends State<AddNewBlogScreen> {
  final _titleTEController = TextEditingController();
  final _contentTEController = TextEditingController();
  File? _selectedImage;
  List<int> _selectedCategoryIds = [];
  List<Category> _categories = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BlogBloc>().add(BlogFetchCategoriesRequested());
    });
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _contentTEController.dispose();
    super.dispose();
  }

  void _submitBlog() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategoryIds.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one topic')),
        );
        return;
      }
      context.read<BlogBloc>().add(
            BlogUploadRequested(
              title: _titleTEController.text.trim(),
              content: _contentTEController.text.trim(),
              categoryIds: _selectedCategoryIds,
              image: _selectedImage,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Blog'),
        actions: [
          IconButton(
            onPressed: _submitBlog,
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is BlogCategoriesFetchSuccess) {
            setState(() {
              _categories = state.categories;
            });
          }
          if (state is BlogUploadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Blog uploaded successfully!')),
            );
            context.pop();
          }
        },
        builder: (context, state) {
          if (state is BlogLoading && _categories.isEmpty) {
            return const Loader();
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectImageContainer(
                          selectedImage: _selectedImage,
                          onImageSelected: (image) {
                            setState(() {
                              _selectedImage = image;
                            });
                          },
                        ),
                        const Gap(24),
                        const Text(
                          'Select Topics',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(10),
                        BlogTopicFilter(
                          categories: _categories,
                          selectedCategoryIds: _selectedCategoryIds,
                          onChanged: (ids) {
                            setState(() {
                              _selectedCategoryIds = ids;
                            });
                          },
                          isReadOnly: false,
                        ),
                        const Gap(24),
                        BlogEditor(
                          controller: _titleTEController,
                          hintText: 'Blog Title',
                        ),
                        const Gap(16),
                        BlogEditor(
                          controller: _contentTEController,
                          hintText: 'Blog Content',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state is BlogLoading)
                Container(
                  color: Colors.black54,
                  child: const Loader(),
                ),
            ],
          );
        },
      ),
    );
  }
}
