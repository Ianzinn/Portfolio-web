import 'package:flutter/material.dart';
import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/theme/app_theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final categories = [
      _SkillCategory(
        icon: Icons.smartphone,
        title: l10n.skillsCategoryMobile,
        skills: ['Flutter', 'Dart', 'Android SDK', 'iOS Development'],
        color1: AppTheme.green500,
        color2: AppTheme.emerald500,
        codePrefix: 'class',
      ),
      _SkillCategory(
        icon: Icons.code,
        title: l10n.skillsCategoryLanguages,
        skills: ['Dart', 'Kotlin', 'Swift', 'JavaScript', 'C#', 'Java', 'HTML', 'CSS'],
        color1: AppTheme.green600,
        color2: AppTheme.green400,
        codePrefix: 'const',
      ),
      _SkillCategory(
        icon: Icons.layers,
        title: l10n.skillsCategoryArchitecture,
        skills: ['Clean Architecture', 'BLoC', 'Provider', 'GetX', 'MVC/MVVM'],
        color1: AppTheme.emerald500,
        color2: AppTheme.teal500,
        codePrefix: 'interface',
      ),
      _SkillCategory(
        icon: Icons.palette,
        title: l10n.skillsCategoryUiUx,
        skills: ['Material Design', 'Cupertino', 'Responsive Design', 'Animations', 'Custom Widgets'],
        color1: AppTheme.teal500,
        color2: AppTheme.cyan500,
        codePrefix: 'widget',
      ),
      _SkillCategory(
        icon: Icons.storage,
        title: l10n.skillsCategoryBackend,
        skills: ['Firebase', 'REST APIs', 'SQLite'],
        color1: AppTheme.cyan500,
        color2: AppTheme.blue500,
        codePrefix: 'async',
      ),
      _SkillCategory(
        icon: Icons.settings,
        title: l10n.skillsCategoryTools,
        skills: ['Git', 'Android Studio', 'Xcode', 'VS Code', 'Figma', 'Postman', 'Jira'],
        color1: AppTheme.blue500,
        color2: AppTheme.green500,
        codePrefix: 'import',
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              // Header
              Text(
                '// ${l10n.skillsSectionComment}',
                style: const TextStyle(
                    color: AppTheme.green500,
                    fontSize: 14,
                    fontFamily: 'monospace'),
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace'),
                  children: [
                    const TextSpan(
                        text: 'function ',
                        style: TextStyle(color: AppTheme.green500)),
                    TextSpan(
                        text: l10n.skillsSectionTitle,
                        style: const TextStyle(color: Colors.white)),
                    const TextSpan(
                        text: '() {',
                        style: TextStyle(color: AppTheme.green500)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
                  children: [
                    const TextSpan(
                        text: 'return ',
                        style: TextStyle(color: AppTheme.green500)),
                    TextSpan(
                        text: l10n.skillsSectionSubtitle,
                        style: const TextStyle(color: AppTheme.slate400)),
                    const TextSpan(
                        text: ';',
                        style: TextStyle(color: AppTheme.green500)),
                  ],
                ),
              ),
              const SizedBox(height: 64),
              // Grid with staggered entrance per card
              LayoutBuilder(builder: (context, constraints) {
                final w = constraints.maxWidth;
                int cols = 1;
                if (w > 1024) {
                  cols = 3;
                } else if (w > 768) {
                  cols = 2;
                }
                // Calculate a mainAxisExtent that fits content at each column count
                // Mobile (1 col): card is full width, needs more height for skills wrap
                // Desktop (2-3 col): cards are narrower, 1.15 ratio works
                final double extent = cols == 1
                    ? (w - 32) / 0.9  // generous height for single column
                    : cols == 2
                        ? ((w - 24) / 2) / 1.1
                        : ((w - 48) / 3) / 1.15;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: cols,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    mainAxisExtent: extent.clamp(220, 400),
                  ),
                  itemCount: categories.length,
                  itemBuilder: (_, i) =>
                      _SkillCard(category: categories[i], index: i),
                );
              }),
              const SizedBox(height: 32),
              const Text(
                '}',
                style: TextStyle(
                    color: AppTheme.green500,
                    fontSize: 24,
                    fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _SkillCategory {
  final IconData icon;
  final String title;
  final List<String> skills;
  final Color color1;
  final Color color2;
  final String codePrefix;

  const _SkillCategory({
    required this.icon,
    required this.title,
    required this.skills,
    required this.color1,
    required this.color2,
    required this.codePrefix,
  });
}

class _SkillCard extends StatefulWidget {
  final _SkillCategory category;
  final int index;
  const _SkillCard({required this.category, required this.index});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;

  late final AnimationController _entranceCtrl;
  late final Animation<double> _entranceOpacity;
  late final Animation<Offset> _entranceSlide;

  @override
  void initState() {
    super.initState();
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _entranceOpacity =
        CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);
    _entranceSlide =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
            CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic));

    // Stagger: each card delays by 90ms × its index
    Future.delayed(Duration(milliseconds: 90 * widget.index), () {
      if (mounted) _entranceCtrl.forward();
    });
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _entranceOpacity,
      child: SlideTransition(
        position: _entranceSlide,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.diagonal3Values(
                _hovered ? 1.03 : 1.0, _hovered ? 1.03 : 1.0, 1.0),
            transformAlignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppTheme.slate900,
              border: Border.all(
                color: _hovered
                    ? AppTheme.green500.withValues(alpha: 0.5)
                    : AppTheme.green500.withValues(alpha: 0.2),
              ),
              borderRadius: BorderRadius.circular(8),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                          color: AppTheme.green500.withValues(alpha: 0.2),
                          blurRadius: 20)
                    ]
                  : [],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  right: 8,
                  child: Text(
                    '{...}',
                    style: TextStyle(
                      color: AppTheme.green500
                          .withValues(alpha: _hovered ? 0.4 : 0.15),
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  widget.category.color1,
                                  widget.category.color2
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color:
                                      AppTheme.green500.withValues(alpha: 0.3)),
                            ),
                            child: Icon(widget.category.icon,
                                color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            widget.category.codePrefix,
                            style: const TextStyle(
                                color: AppTheme.green500,
                                fontSize: 14,
                                fontFamily: 'monospace'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.category.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'monospace'),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.category.skills.map((s) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppTheme.green500.withValues(alpha: 0.1),
                                border: Border.all(
                                    color: AppTheme.green500
                                        .withValues(alpha: 0.3)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                s,
                                style: const TextStyle(
                                    color: AppTheme.green400,
                                    fontSize: 12,
                                    fontFamily: 'monospace'),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Divider(
                          color: AppTheme.green500.withValues(alpha: 0.3),
                          height: 24),
                      Text(
                        '// ${widget.category.skills.length} skills',
                        style: TextStyle(
                            color: AppTheme.green500.withValues(alpha: 0.4),
                            fontSize: 12,
                            fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
