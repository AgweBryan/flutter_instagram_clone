import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  final Function() onTap;
  final Widget child;
  final bool isAnimating;
  final bool isSmallLike;
  final Duration duration;
  const LikeAnimation({
    Key? key,
    required this.onTap,
    required this.child,
    required this.isAnimating,
    this.isSmallLike = false,
    this.duration = const Duration(
      milliseconds: 150,
    ),
  }) : super(key: key);

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    ); // ~/2 : divide and converts to int
    _scaleAnimation =
        Tween<double>(begin: 1, end: 1.2).animate(_animationController);
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimating || widget.isSmallLike) {
      await _animationController.forward();
      await _animationController.reverse();
      await Future.delayed(
        const Duration(
          milliseconds: 200,
        ),
      );

      widget.onTap();
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}
