import 'package:devblogs/core/common/widgets/loader.dart';
import 'package:devblogs/core/di/injection_container.dart';
import 'package:devblogs/core/theme/app_pallete.dart';
import 'package:devblogs/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:devblogs/features/blog/presentation/pages/add_new_blog_screen.dart';
import 'package:devblogs/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BlogScreen extends StatefulWidget {
  static const name = "/blog-screen";
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BlogBloc>()..add(BlogFetchAllRequested()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Blog App'),
          actions: [
            Builder(
              builder: (iconContext) => IconButton(
                onPressed: () async {
                  final bloc = iconContext.read<BlogBloc>();
                  await iconContext.push(AddNewBlogScreen.name);
                  bloc.add(BlogFetchAllRequested());
                },
                icon: const Icon(CupertinoIcons.add_circled),
              ),
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
          },
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Loader();
            }
            if (state is BlogFetchAllSuccess) {
              final blogs = state.blogs;
              if (blogs.isEmpty) {
                return const Center(
                  child: Text(
                    'No blogs found yet.\nBe the first to write one!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppPallete.greyColor,
                      height: 1.5,
                    ),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<BlogBloc>().add(BlogFetchAllRequested());
                },
                color: AppPallete.gradient1,
                child: ListView.builder(
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    final blog = blogs[index];
                    final color = index % 3 == 0
                        ? AppPallete.gradient1
                        : index % 3 == 1
                            ? AppPallete.gradient2
                            : AppPallete.gradient3;
                    return BlogCard(
                      blog: blog,
                      color: color,
                    );
                  },
                ),
              );
            }
            return const Center(
              child: Text(
                'Something went wrong while fetching blogs.',
                style: TextStyle(color: AppPallete.errorColor),
              ),
            );
          },
        ),
      ),
    );
  }
}
