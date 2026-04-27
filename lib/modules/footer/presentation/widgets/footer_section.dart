import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/theme/app_theme.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        color: AppTheme.slate950.withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(
              color: AppTheme.green500.withValues(alpha: 0.2)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              LayoutBuilder(builder: (_, constraints) {
                if (constraints.maxWidth > 768) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _Copyright(),
                      _SocialRow(),
                    ],
                  );
                }
                return Column(children: [
                  _Copyright(),
                  const SizedBox(height: 24),
                  _SocialRow(),
                ]);
              }),
              const SizedBox(height: 32),
              Text(
                '// ${context.l10n.footerEof}',
                style: TextStyle(
                    color: AppTheme.green500.withValues(alpha: 0.35),
                    fontSize: 12,
                    fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Copyright extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// © 2025 ${context.l10n.footerCopyright}',
          style: const TextStyle(
              color: AppTheme.slate400,
              fontSize: 14,
              fontFamily: 'monospace'),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.code, color: AppTheme.green500, size: 16),
            const SizedBox(width: 8),
            Text('${context.l10n.footerBuiltWith} ',
                style: const TextStyle(
                    color: AppTheme.slate500,
                    fontSize: 14,
                    fontFamily: 'monospace')),
            const Text('<Flutter />',
                style: TextStyle(
                    color: AppTheme.green400,
                    fontSize: 14,
                    fontFamily: 'monospace')),
            const Text(' & ',
                style: TextStyle(
                    color: AppTheme.slate500,
                    fontSize: 14,
                    fontFamily: 'monospace')),
            const Text('Dart',
                style: TextStyle(
                    color: AppTheme.green400,
                    fontSize: 14,
                    fontFamily: 'monospace')),
          ],
        ),
      ],
    );
  }
}

class _SocialRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialBtn(
            svgPath: 'assets/icons/github.svg',
            label: 'GitHub',
            url: 'https://github.com/Ianzinn'),
        const SizedBox(width: 12),
        _SocialBtn(
            svgPath: 'assets/icons/linkedin.svg',
            label: 'LinkedIn',
            url: 'https://www.linkedin.com/in/ian-pedro-barbosa-de-santana-8a81ab307'),
        const SizedBox(width: 12),
        _SocialBtn(
            svgPath: 'assets/icons/email.svg',
            label: 'Email',
            url: 'mailto:ianpedro1812@gmail.com'),
      ],
    );
  }
}

class _SocialBtn extends StatefulWidget {
  final String svgPath;
  final String label;
  final String url;
  const _SocialBtn(
      {required this.svgPath, required this.label, required this.url});
  @override
  State<_SocialBtn> createState() => _SocialBtnState();
}

class _SocialBtnState extends State<_SocialBtn> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40,
          height: 40,
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
                        color: AppTheme.green500.withValues(alpha: 0.2),
                        blurRadius: 16)
                  ]
                : [],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => launchUrl(Uri.parse(widget.url),
                webOnlyWindowName: '_blank'),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                widget.svgPath,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  AppTheme.green400,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
