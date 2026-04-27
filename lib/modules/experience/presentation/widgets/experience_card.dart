import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/experience_entity.dart';

class ExperienceCard extends StatefulWidget {
  final ExperienceEntity experience;
  final bool showTimeline;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.showTimeline,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _pulse;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _pulseAnim = Tween<double>(begin: 0, end: 1).animate(_pulse);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showTimeline) _buildTimeline(),
          Expanded(child: _buildCard()),
        ],
      ),
    );
  }

  // ── Timeline dot ────────────────────────────────────────────────────────────

  Widget _buildTimeline() {
    final dotColor = widget.experience.isNextStep
        ? AppTheme.slate600
        : AppTheme.green500;

    return SizedBox(
      width: 64,
      child: Column(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (!widget.experience.isNextStep)
                  AnimatedBuilder(
                    animation: _pulseAnim,
                    builder: (_, __) => Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.green500
                            .withValues(alpha: 0.6 * (1 - _pulseAnim.value)),
                      ),
                    ),
                  ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppTheme.slate900, width: 3),
                    boxShadow: widget.experience.isNextStep
                        ? []
                        : [
                            BoxShadow(
                              color: AppTheme.green500.withValues(alpha: 0.5),
                              blurRadius: 8,
                            ),
                          ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 2,
            height: 300,
            color: widget.experience.isNextStep
                ? AppTheme.slate700.withValues(alpha: 0.4)
                : AppTheme.green500.withValues(alpha: 0.25),
          ),
        ],
      ),
    );
  }

  // ── Card ────────────────────────────────────────────────────────────────────

  Widget _buildCard() {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: widget.experience.isNextStep
              ? AppTheme.slate900.withValues(alpha: 0.6)
              : AppTheme.slate900,
          border: Border.all(
            color: widget.experience.isNextStep
                ? (_hovered
                    ? AppTheme.slate500.withValues(alpha: 0.5)
                    : AppTheme.slate700.withValues(alpha: 0.4))
                : (_hovered
                    ? AppTheme.green500.withValues(alpha: 0.5)
                    : AppTheme.green500.withValues(alpha: 0.2)),
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: _hovered && !widget.experience.isNextStep
              ? [
                  BoxShadow(
                    color: AppTheme.green500.withValues(alpha: 0.15),
                    blurRadius: 20,
                  ),
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGitHeader(),
              const SizedBox(height: 16),
              _buildRoleRow(),
              const SizedBox(height: 16),
              _buildDescription(),
              const SizedBox(height: 16),
              widget.experience.isNextStep
                  ? _buildCodeSnippet()
                  : _buildAchievements(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Git header ───────────────────────────────────────────────────────────────

  Widget _buildGitHeader() {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: widget.experience.isNextStep
                ? AppTheme.slate700.withValues(alpha: 0.3)
                : AppTheme.green500.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          Text(
            widget.experience.gitCommand,
            style: TextStyle(
              color: widget.experience.isNextStep
                  ? AppTheme.slate500
                  : AppTheme.green500,
              fontSize: 14,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            '"${widget.experience.commitMessage}"',
            style: TextStyle(
              color: widget.experience.isNextStep
                  ? AppTheme.slate600
                  : AppTheme.green400.withValues(alpha: 0.6),
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  // ── Role + period ────────────────────────────────────────────────────────────

  Widget _buildRoleRow() {
    final accentColor = widget.experience.isNextStep
        ? AppTheme.slate500
        : AppTheme.green500;
    final nameColor = widget.experience.isNextStep
        ? AppTheme.slate400
        : Colors.white;
    final companyColor = widget.experience.isNextStep
        ? AppTheme.slate500
        : AppTheme.green400;

    return LayoutBuilder(builder: (_, constraints) {
      final wide = constraints.maxWidth > 480;

      final roleWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // roleLabel badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: accentColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              widget.experience.roleLabel,
              style: TextStyle(
                color: accentColor,
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // class ClassName
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 18, fontFamily: 'monospace'),
              children: [
                TextSpan(
                    text: 'class ',
                    style: TextStyle(color: accentColor)),
                TextSpan(
                    text: widget.experience.role,
                    style: TextStyle(
                        color: nameColor,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // @company
          Row(
            children: [
              Icon(Icons.business, color: companyColor, size: 14),
              const SizedBox(width: 6),
              Text(
                '@${widget.experience.company}',
                style: TextStyle(
                    color: companyColor,
                    fontSize: 13,
                    fontFamily: 'monospace'),
              ),
            ],
          ),
        ],
      );

      final periodWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: accentColor.withValues(alpha: 0.05),
          border: Border.all(color: accentColor.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.calendar_today, color: AppTheme.slate400, size: 13),
            const SizedBox(width: 6),
            Text(
              widget.experience.period,
              style: const TextStyle(
                  color: AppTheme.slate400,
                  fontSize: 13,
                  fontFamily: 'monospace'),
            ),
          ],
        ),
      );

      if (wide) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: roleWidget),
            const SizedBox(width: 12),
            periodWidget,
          ],
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [roleWidget, const SizedBox(height: 12), periodWidget],
      );
    });
  }

  // ── Description ──────────────────────────────────────────────────────────────

  Widget _buildDescription() {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: widget.experience.isNextStep
                ? AppTheme.slate700.withValues(alpha: 0.5)
                : AppTheme.green500.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
      ),
      child: RichText(
        text: TextSpan(
          style:
              const TextStyle(fontSize: 14, fontFamily: 'monospace', height: 1.6),
          children: [
            TextSpan(
              text: '// ',
              style: TextStyle(
                color: widget.experience.isNextStep
                    ? AppTheme.slate600
                    : AppTheme.green500,
              ),
            ),
            TextSpan(
              text: widget.experience.description,
              style: TextStyle(
                color: widget.experience.isNextStep
                    ? AppTheme.slate500
                    : AppTheme.slate300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Achievements (normal cards) ──────────────────────────────────────────────

  Widget _buildAchievements() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.slate950.withValues(alpha: 0.5),
        border: Border.all(color: AppTheme.green500.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '{ achievements: [',
            style: TextStyle(
                color: AppTheme.green500.withValues(alpha: 0.6),
                fontSize: 12,
                fontFamily: 'monospace'),
          ),
          const SizedBox(height: 8),
          ...widget.experience.achievements.map(
            (a) => Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('+  ',
                      style: TextStyle(
                          color: AppTheme.green400,
                          fontFamily: 'monospace')),
                  Expanded(
                    child: Text(
                      '"$a",',
                      style: const TextStyle(
                          color: AppTheme.slate400,
                          fontSize: 13,
                          fontFamily: 'monospace'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '] }',
            style: TextStyle(
                color: AppTheme.green500.withValues(alpha: 0.6),
                fontSize: 12,
                fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }

  // ── Code snippet (Júnior card) ───────────────────────────────────────────────

  Widget _buildCodeSnippet() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.slate950.withValues(alpha: 0.6),
        border: Border.all(color: AppTheme.slate700.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart',
            style: TextStyle(
                color: AppTheme.slate600,
                fontSize: 11,
                fontFamily: 'monospace'),
          ),
          const SizedBox(height: 8),
          Text(
            widget.experience.codeSnippet!,
            style: const TextStyle(
              color: AppTheme.slate400,
              fontSize: 13,
              fontFamily: 'monospace',
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }
}
