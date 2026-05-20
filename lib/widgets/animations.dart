import 'package:flutter/material.dart';

/// Fade-in animation wrapper
class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool animate;

  const FadeInAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOut,
    this.animate = true,
  }) : super(key: key);

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    if (widget.animate) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

/// Slide-in animation wrapper
class SlideInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final SlideDirection direction;

  const SlideInAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOut,
    this.direction = SlideDirection.up,
  }) : super(key: key);

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

enum SlideDirection { up, down, left, right }

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    final beginOffset = _getBeginOffset(widget.direction);
    _animation = Tween<Offset>(begin: beginOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    _controller.forward();
  }

  Offset _getBeginOffset(SlideDirection direction) {
    switch (direction) {
      case SlideDirection.up:
        return const Offset(0, 0.5);
      case SlideDirection.down:
        return const Offset(0, -0.5);
      case SlideDirection.left:
        return const Offset(0.5, 0);
      case SlideDirection.right:
        return const Offset(-0.5, 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: FadeTransition(
        opacity: _controller,
        child: widget.child,
      ),
    );
  }
}

/// Scale animation wrapper
class ScaleInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const ScaleInAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.elasticOut,
  }) : super(key: key);

  @override
  State<ScaleInAnimation> createState() => _ScaleInAnimationState();
}

class _ScaleInAnimationState extends State<ScaleInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
}

/// Pulse animation
class PulseAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const PulseAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1, end: 0.7).animate(
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
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
