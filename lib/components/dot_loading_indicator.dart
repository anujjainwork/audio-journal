import 'package:flutter/material.dart';

class DotLoadingIndicator extends StatefulWidget {
  final double dotSize;
  final Color color;
  final Duration duration;

  const DotLoadingIndicator({
    super.key,
    this.dotSize = 6.0,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<DotLoadingIndicator> createState() => _DotLoadingIndicatorState();
}

class _DotLoadingIndicatorState extends State<DotLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: const Duration(milliseconds: 900), vsync: this)
          ..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        final delay = index * 0.3;
        final time = (_animation.value + delay) % 1.0;
        final opacity = 0.3 + (0.7 * (1.0 - (time - 0.5).abs() * 2).clamp(0.0, 1.0));

        return Opacity(
          opacity: opacity,
          child: Container(
            width: widget.dotSize,
            height: widget.dotSize,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, _buildDot),
    );
  }
}
