import 'package:flutter/material.dart';

/// Fades + slides a widget into view when it enters the viewport.
/// Requires a [PrimaryScrollController] ancestor (set up in HomePage).
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 700),
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  ScrollController? _scrollCtrl;
  bool _triggered = false;
  final _myKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _opacity = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _attach();
      _check();
      Future.delayed(const Duration(milliseconds: 120), () {
        if (mounted && !_triggered) _check();
      });
    });
  }

  void _attach() {
    final ctrl = PrimaryScrollController.maybeOf(context);
    if (ctrl != null) {
      _scrollCtrl = ctrl;
      ctrl.addListener(_check);
    }
  }

  void _check() {
    if (_triggered || !mounted) return;
    final ctx = _myKey.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;
    final pos = box.localToGlobal(Offset.zero);
    final screenH = MediaQuery.sizeOf(context).height;
    if (pos.dy < screenH * 1.05) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _ctrl.forward();
      });
    }
  }

  @override
  void dispose() {
    _scrollCtrl?.removeListener(_check);
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      key: _myKey,
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}
