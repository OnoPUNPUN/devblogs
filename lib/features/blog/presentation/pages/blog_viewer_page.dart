import 'package:devblogs/core/common/widgets/loader.dart';
import 'package:devblogs/core/theme/app_pallete.dart';
import 'package:devblogs/core/utils/calculate_reading_time.dart';
import 'package:devblogs/core/utils/format_date.dart';
import 'package:devblogs/features/blog/domain/entities/blog.dart';
import 'package:devblogs/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BlogViewerPage extends StatefulWidget {
  static const name = "/blog-viewer";
  final Blog blog;
  const BlogViewerPage({super.key, required this.blog});

  @override
  State<BlogViewerPage> createState() => _BlogViewerPageState();
}

class _BlogViewerPageState extends State<BlogViewerPage> {
  Blog? _detailedBlog;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BlogBloc>().add(BlogFetchByIdRequested(widget.blog.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is BlogFetchByIdSuccess) {
            setState(() {
              _detailedBlog = state.blog;
            });
          }
        },
        builder: (context, state) {
          final blogToDisplay = _detailedBlog;

          return Scrollbar(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.blog.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),
                    Text(
                      blogToDisplay != null
                          ? 'By ${blogToDisplay.userName}'
                          : 'By ...',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const Gap(5),
                    Text(
                      blogToDisplay != null
                          ? '${formateDate(blogToDisplay.updatedAt)}. ${clculateReadingTime(blogToDisplay.content)} min'
                          : 'Loading metadata...',
                      style: const TextStyle(
                        color: AppPallete.greyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(20),
                    if (blogToDisplay != null &&
                        blogToDisplay.imageUrl != null &&
                        blogToDisplay.imageUrl!.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          blogToDisplay.imageUrl!,
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 220,
                              width: double.infinity,
                              color: AppPallete.borderColor,
                              alignment: Alignment.center,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported_outlined,
                                    size: 40,
                                  ),
                                  Gap(8),
                                  Text('Image unavailable offline'),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    else if (blogToDisplay != null &&
                        (blogToDisplay.imageUrl == null ||
                            blogToDisplay.imageUrl!.isEmpty))
                      const SizedBox.shrink()
                    else
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppPallete.borderColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Loader(),
                      ),
                    const Gap(20),
                    if (blogToDisplay != null)
                      Text(
                        blogToDisplay.content,
                        style: const TextStyle(fontSize: 14, height: 2),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Center(
                          child: Loader(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
