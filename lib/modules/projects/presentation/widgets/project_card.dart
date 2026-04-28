import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/extensions/build_context_extensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/project_entity.dart';
import 'tech_tag.dart';

class ProjectCard extends StatefulWidget {
  final ProjectEntity project;
  final int index;
  final bool isMobile;

  const ProjectCard({
    super.key,
    required this.project,
    this.index = 0,
    this.isMobile = false,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;

  // Staggered entrance
  late final AnimationController _entranceCtrl;
  late final Animation<double> _entranceOpacity;
  late final Animation<Offset> _entranceSlide;

  // Shimmer sweep on hover
  late final AnimationController _shimmerCtrl;
  late final Animation<double> _shimmerAnim;

  String get _filename =>
      '${widget.project.title.toLowerCase().replaceAll(' ', '-')}.dart';

  String get _className =>
      'class ${widget.project.title.replaceAll(' ', '')}';

  @override
  void initState() {
    super.initState();

    // Entrance animation (staggered)
    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _entranceOpacity =
        CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);
    _entranceSlide =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
            CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: 100 * widget.index), () {
      if (mounted) _entranceCtrl.forward();
    });

    // Shimmer sweep
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _shimmerAnim =
        CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _entranceOpacity,
      child: SlideTransition(
        position: _entranceSlide,
        child: MouseRegion(
          onEnter: (_) {
            setState(() => _isHovered = true);
            _shimmerCtrl.forward(from: 0);
          },
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: AppTheme.slate900,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _isHovered
                    ? AppTheme.green500.withValues(alpha: 0.5)
                    : AppTheme.green500.withValues(alpha: 0.2),
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppTheme.green500.withValues(alpha: 0.15),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: widget.isMobile
                        ? MainAxisSize.min
                        : MainAxisSize.max,
                    children: [
                      _TerminalHeader(
                        filename: _filename,
                        linesCount: widget.project.linesCount,
                      ),
                      _ProjectImage(
                        imageUrl: widget.project.imageUrl,
                        classLabel: _className,
                        imageHeight: widget.isMobile ? 140.0 : 192.0,
                      ),
                      widget.isMobile
                          ? _ProjectContent(
                              project: widget.project,
                              isMobile: true,
                            )
                          : Expanded(
                              child: _ProjectContent(
                                project: widget.project,
                                isMobile: false,
                              ),
                            ),
                    ],
                  ),
                  // Shimmer sweep overlay
                  Positioned.fill(
                    child: IgnorePointer(
                      child: AnimatedBuilder(
                        animation: _shimmerAnim,
                        builder: (_, __) {
                          final v = _shimmerAnim.value;
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin:
                                    Alignment(-1.5 + v * 3.5, -0.5),
                                end: Alignment(-0.5 + v * 3.5, 0.5),
                                colors: [
                                  Colors.transparent,
                                  Colors.white
                                      .withValues(alpha: 0.04 * v),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Terminal header ────────────────────────────────────────────────────────────

class _TerminalHeader extends StatelessWidget {
  final String filename;
  final String? linesCount;

  const _TerminalHeader({required this.filename, this.linesCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.slate950,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        border: Border(
          bottom: BorderSide(color: AppTheme.green500.withValues(alpha: 0.2)),
        ),
      ),
      child: Row(
        children: [
          _Dot(AppTheme.red500),
          const SizedBox(width: 6),
          _Dot(AppTheme.yellow500),
          const SizedBox(width: 6),
          _Dot(AppTheme.green500),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              filename,
              style: const TextStyle(
                color: AppTheme.green500,
                fontSize: 12,
                fontFamily: 'monospace',
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (linesCount != null)
            Text(
              '$linesCount lines',
              style: TextStyle(
                color: AppTheme.green500.withValues(alpha: 0.5),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
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
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

// ── Project image ──────────────────────────────────────────────────────────────

class _ProjectImage extends StatelessWidget {
  final String? imageUrl;
  final String classLabel;
  final double imageHeight;

  const _ProjectImage({
    this.imageUrl,
    required this.classLabel,
    this.imageHeight = 192,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageUrl != null)
            CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => _imageFallback,
            )
          else
            _imageFallback,
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.slate900.withValues(alpha: 0),
                  AppTheme.slate900.withValues(alpha: 0.4),
                  AppTheme.slate900,
                ],
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.slate950.withValues(alpha: 0.85),
                border: Border.all(
                    color: AppTheme.green500.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                classLabel,
                style: const TextStyle(
                  color: AppTheme.green400,
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _imageFallback => Container(
        color: AppTheme.slate800,
        child: const Icon(
          Icons.image_outlined,
          size: 48,
          color: AppTheme.slate600,
        ),
      );
}

// ── Project content ────────────────────────────────────────────────────────────

class _ProjectContent extends StatelessWidget {
  final ProjectEntity project;
  final bool isMobile;

  const _ProjectContent({required this.project, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final padding = isMobile ? 16.0 : 24.0;
    final indentLeft = isMobile ? 16.0 : 24.0;

    final titleRow = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '//',
          style: TextStyle(
            color: AppTheme.green500,
            fontSize: 14,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            project.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    );

    final description = Padding(
      padding: EdgeInsets.only(left: indentLeft),
      child: Text(
        project.description,
        style: TextStyle(
          color: AppTheme.slate400,
          fontSize: isMobile ? 13 : 14,
          fontFamily: 'monospace',
          height: 1.6,
        ),
        maxLines: isMobile ? null : 3,
        overflow: isMobile ? null : TextOverflow.ellipsis,
      ),
    );

    final tags = Padding(
      padding: EdgeInsets.only(left: indentLeft),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: project.technologies
            .map((t) => TechTag(label: t))
            .toList(),
      ),
    );

    final buttons = Padding(
      padding: EdgeInsets.only(left: indentLeft),
      child: OutlinedButton.icon(
        onPressed: () => _launchUrl(project.githubUrl),
        icon: const Icon(Icons.code, size: 16),
        label: Text(context.l10n.projectsButtonGithub),
      ),
    );

    if (isMobile) {
      return Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            titleRow,
            const SizedBox(height: 12),
            description,
            const SizedBox(height: 12),
            tags,
            const SizedBox(height: 16),
            buttons,
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRow,
          const SizedBox(height: 12),
          description,
          const SizedBox(height: 16),
          tags,
          const Spacer(),
          buttons,
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, webOnlyWindowName: '_blank');
  }
}
