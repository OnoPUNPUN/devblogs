import 'package:devblogs/core/theme/app_pallete.dart';
import 'package:devblogs/features/blog/domain/entities/category.dart';
import 'package:flutter/material.dart';

class BlogTopicFilter extends StatelessWidget {
  final List<String>? selectedTopics;
  final List<Category>? categories;
  final List<int>? selectedCategoryIds;
  final ValueChanged<List<int>>? onChanged;
  final bool isReadOnly;

  const BlogTopicFilter({
    super.key,
    this.selectedTopics,
    this.categories,
    this.selectedCategoryIds,
    this.onChanged,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isReadOnly) {
      final topics = selectedTopics ?? [];
      if (topics.isEmpty) return const SizedBox.shrink();

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: topics
              .map(
                (topicLabel) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppPallete.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppPallete.borderColor),
                    ),
                    child: Text(
                      topicLabel,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    }

    final cats = categories ?? [];
    if (cats.isEmpty) return const SizedBox.shrink();

    final activeIds = selectedCategoryIds ?? [];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cats
            .map(
              (category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: onChanged == null
                      ? null
                      : () {
                          final updatedCategoryIds = List<int>.from(activeIds);

                          if (updatedCategoryIds.contains(category.id)) {
                            updatedCategoryIds.remove(category.id);
                          } else {
                            updatedCategoryIds.add(category.id);
                          }

                          onChanged!(updatedCategoryIds);
                        },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: activeIds.contains(category.id)
                          ? AppPallete.gradient1
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: activeIds.contains(category.id)
                          ? null
                          : Border.all(color: AppPallete.borderColor),
                    ),
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
