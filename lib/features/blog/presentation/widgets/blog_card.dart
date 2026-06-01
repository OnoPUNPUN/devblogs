import 'package:devblogs/core/utils/calculate_reading_time.dart';
import 'package:devblogs/features/blog/domain/entities/blog.dart';
import 'package:devblogs/features/blog/presentation/pages/blog_viewer_page.dart';
import 'package:devblogs/features/blog/presentation/widgets/blog_topic_filter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(BlogViewerPage.name, extra: blog),
      child: Container(
        constraints: const BoxConstraints(minHeight: 170),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(16).copyWith(bottom: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlogTopicFilter(selectedTopics: blog.topics, isReadOnly: true),
                const Gap(6),
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text('${clculateReadingTime(blog.content)} min'),
          ],
        ),
      ),
    );
  }
}
