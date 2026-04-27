import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class PortfolioNavBar extends StatefulWidget implements PreferredSizeWidget {
  final List<GlobalKey> sectionKeys;

  const PortfolioNavBar({super.key, required this.sectionKeys});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  State<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends State<PortfolioNavBar> {
  int _activeIndex = 0;

  static const _labels = [
    '~/ início',
    'skills',
    'projetos',
    'experiência',
    'contato',
  ];

  void _scrollTo(int index) {
    final ctx = widget.sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
    setState(() => _activeIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.slate950.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: AppTheme.green500.withValues(alpha: 0.2)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            // Logo
            RichText(
              text: const TextSpan(
                style: TextStyle(fontFamily: 'monospace', fontSize: 16),
                children: [
                  TextSpan(
                      text: '<',
                      style: TextStyle(color: AppTheme.green500)),
                  TextSpan(
                      text: 'Dev',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: ' />',
                      style: TextStyle(color: AppTheme.green500)),
                ],
              ),
            ),
            const Spacer(),
            // Nav items (hidden on small screens)
            LayoutBuilder(builder: (context, constraints) {
              return Wrap(
                spacing: 4,
                children: List.generate(_labels.length, (i) {
                  final active = i == _activeIndex;
                  return TextButton(
                    onPressed: () => _scrollTo(i),
                    style: TextButton.styleFrom(
                      foregroundColor:
                          active ? AppTheme.green400 : AppTheme.slate400,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                    child: Text(
                      _labels[i],
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                        color: active ? AppTheme.green400 : AppTheme.slate400,
                        decoration: active
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        decorationColor: AppTheme.green400,
                      ),
                    ),
                  );
                }),
              );
            }),
          ],
        ),
      ),
    );
  }
}
