import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/theme/app_theme.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _arrowCtrl;
  late final Animation<double> _arrowY;

  @override
  void initState() {
    super.initState();

    // Arrow bounce: smooth up-down cycle
    _arrowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _arrowY = Tween<double>(begin: 0, end: 10).animate(
        CurvedAnimation(parent: _arrowCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _arrowCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      child: Stack(
        children: [
          // ── Matrix rain background ──────────────────────────────────────────
          const Positioned.fill(child: _MatrixRain()),
          // ── Glow orbs ───────────────────────────────────────────────────────
          if (!isMobile) ...[
            Positioned(
                top: 60, left: 60, child: _GlowOrb(color: AppTheme.green500)),
            Positioned(
                bottom: 60,
                right: 60,
                child: _GlowOrb(color: AppTheme.emerald500)),
          ],
          // ── Main content ────────────────────────────────────────────────────
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1280),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _TerminalCard(),
                  const SizedBox(height: 32),
                  const Text(
                    '<developer>',
                    style: TextStyle(
                        color: AppTheme.green500,
                        fontSize: 14,
                        fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    context.l10n.heroTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 30 : 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '</developer>',
                    style: TextStyle(
                        color: AppTheme.green500,
                        fontSize: 14,
                        fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 16),
                  // Skills snippet
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.slate900.withValues(alpha: 0.8),
                      border: Border.all(
                          color: AppTheme.green500.withValues(alpha: 0.2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isMobile
                          ? "const skills = ['Flutter', 'Dart', 'Android'];"
                          : "const skills = ['Flutter', 'Dart', 'Android', 'iOS'];",
                      style: const TextStyle(
                          color: AppTheme.green400,
                          fontSize: 13,
                          fontFamily: 'monospace'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 32),
                    child: Text(
                      '// ${context.l10n.heroDescription}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.slate300,
                        fontSize: isMobile ? 14 : 16,
                        height: 1.6,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // CTA buttons
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.green600,
                          foregroundColor: AppTheme.green200,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          side: BorderSide(
                              color: AppTheme.green500.withValues(alpha: 0.5)),
                          elevation: 8,
                          shadowColor:
                              AppTheme.green500.withValues(alpha: 0.2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('> ${context.l10n.heroCtaProjects}',
                            style: const TextStyle(
                                fontSize: 16, fontFamily: 'monospace')),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.download, size: 16),
                        label: Text(context.l10n.heroCtaDownloadCv,
                            style: const TextStyle(
                                fontSize: 16, fontFamily: 'monospace')),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.green400,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 20),
                          side: const BorderSide(color: AppTheme.green600),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  // Social links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialButton(
                          svgPath: 'assets/icons/github.svg',
                          url: 'https://github.com/Ianzinn'),
                      const SizedBox(width: 16),
                      _SocialButton(
                          svgPath: 'assets/icons/linkedin.svg',
                          url: 'https://www.linkedin.com/in/ian-pedro-barbosa-de-santana-8a81ab307'),
                      const SizedBox(width: 16),
                      _SocialButton(
                          svgPath: 'assets/icons/email.svg',
                          url: 'mailto:ianpedro1812@gmail.com'),
                    ],
                  ),
                  const SizedBox(height: 64),
                  // ── Bouncing scroll arrow ──────────────────────────────────
                  AnimatedBuilder(
                    animation: _arrowY,
                    builder: (_, child) => Transform.translate(
                      offset: Offset(0, _arrowY.value),
                      child: child,
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppTheme.green500,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Matrix Rain ────────────────────────────────────────────────────────────────

class _MatrixRain extends StatefulWidget {
  const _MatrixRain();

  @override
  State<_MatrixRain> createState() => _MatrixRainState();
}

class _MatrixRainState extends State<_MatrixRain>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  double _t = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() => _t = elapsed.inMilliseconds / 1000.0);
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RainPainter(_t),
      child: const SizedBox.expand(),
    );
  }
}

class _RainPainter extends CustomPainter {
  final double t;

  const _RainPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    const colW = 22.0;
    final cols = (size.width / colW).ceil().clamp(0, 70);

    for (int col = 0; col < cols; col++) {
      final rng = Random(col * 1009 + 7);
      final speed = 48.0 + rng.nextDouble() * 60; // px/s
      final phase = rng.nextDouble() * size.height * 1.8;
      final trailLen = 80.0 + rng.nextDouble() * 110;

      final cycleH = size.height + trailLen;
      final headY = (t * speed + phase) % cycleH - trailLen;
      final tipY = headY + trailLen;

      if (tipY < 0 || headY > size.height) continue;

      final x = col * colW + colW / 2;
      final vHead = headY.clamp(0.0, size.height);
      final vTip = tipY.clamp(0.0, size.height);
      if (vTip <= vHead) continue;

      // Gradient trail line
      canvas.drawLine(
        Offset(x, vHead),
        Offset(x, vTip),
        Paint()
          ..strokeWidth = 1.5
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.green500.withValues(alpha: 0),
              AppTheme.green600.withValues(alpha: 0.1),
              AppTheme.green500.withValues(alpha: 0.28),
            ],
            stops: const [0.0, 0.55, 1.0],
          ).createShader(Rect.fromLTWH(x - 1, vHead, 2, vTip - vHead)),
      );

      // Bright tip dot (only when head is inside viewport)
      if (tipY >= 0 && tipY <= size.height) {
        canvas.drawCircle(
          Offset(x, tipY),
          2.2,
          Paint()..color = AppTheme.green300.withValues(alpha: 0.85),
        );
      }

      // Small horizontal tick marks to simulate character cells
      const charH = 16.0;
      for (double y = vHead + charH; y < vTip - 4; y += charH) {
        final progress = (y - headY) / trailLen;
        canvas.drawLine(
          Offset(x - 4, y),
          Offset(x + 4, y),
          Paint()
            ..strokeWidth = 0.8
            ..color = AppTheme.green500
                .withValues(alpha: progress * progress * 0.18),
        );
      }
    }
  }

  @override
  bool shouldRepaint(_RainPainter old) => old.t != t;
}

// ── Terminal card ──────────────────────────────────────────────────────────────

class _TerminalCard extends StatelessWidget {
  const _TerminalCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.slate900,
        border: Border.all(
            color: AppTheme.green500.withValues(alpha: 0.3), width: 2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: AppTheme.green500.withValues(alpha: 0.2),
              blurRadius: 20),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Dot(AppTheme.red500),
              const SizedBox(width: 6),
              _Dot(AppTheme.yellow500),
              const SizedBox(width: 6),
              _Dot(AppTheme.green500),
              const SizedBox(width: 12),
              const Text(
                '~/developer/portfolio',
                style: TextStyle(
                    color: AppTheme.slate500,
                    fontSize: 14,
                    fontFamily: 'monospace'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.terminal, color: AppTheme.green500, size: 32),
              SizedBox(width: 12),
              Text(
                r'$_',
                style: TextStyle(
                    color: AppTheme.green500,
                    fontSize: 20,
                    fontFamily: 'monospace'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  const _Dot(this.color);

  @override
  Widget build(BuildContext context) => Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}

// ── Glow orb ──────────────────────────────────────────────────────────────────

class _GlowOrb extends StatelessWidget {
  final Color color;
  const _GlowOrb({required this.color});

  @override
  Widget build(BuildContext context) => Container(
        width: 320,
        height: 320,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: color.withValues(alpha: 0.08),
                blurRadius: 100,
                spreadRadius: 40),
          ],
        ),
      );
}

// ── Social button ──────────────────────────────────────────────────────────────

class _SocialButton extends StatefulWidget {
  final String svgPath;
  final String url;
  const _SocialButton({required this.svgPath, required this.url});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppTheme.slate900,
          border: Border.all(
            color: _hovered
                ? AppTheme.green500
                : AppTheme.green500.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: AppTheme.green500.withValues(alpha: 0.25),
                      blurRadius: 20)
                ]
              : [],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () =>
              launchUrl(Uri.parse(widget.url), webOnlyWindowName: '_blank'),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              widget.svgPath,
              width: 22,
              height: 22,
              colorFilter: ColorFilter.mode(
                AppTheme.green500,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
