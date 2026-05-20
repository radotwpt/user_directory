import 'package:flutter/material.dart';

/// Skeleton loader widget for displaying placeholder content while loading
class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Color? color;

  const SkeletonLoader({
    Key? key,
    this.width = double.infinity,
    this.height = 20,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.color,
  }) : super(key: key);

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor =
        isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor =
        isDark ? Colors.grey[700]! : Colors.grey[200]!;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final shift = _animation.value;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(shift - 1, 0),
              end: Alignment(shift, 0),
              colors: [
                baseColor,
                highlightColor,
                baseColor,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Skeleton card for list items
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar skeleton
            SkeletonLoader(
              width: 48,
              height: 48,
              borderRadius: const BorderRadius.all(Radius.circular(24)),
            ),
            const SizedBox(width: 12),
            // Text skeleton
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonLoader(
                    width: 150,
                    height: 16,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLoader(
                    width: 200,
                    height: 12,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Arrow skeleton
            SkeletonLoader(
              width: 16,
              height: 16,
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
          ],
        ),
      ),
    );
  }
}
