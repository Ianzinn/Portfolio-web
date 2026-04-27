import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/reveal_on_scroll.dart';
import '../../../contact/presentation/widgets/contact_section.dart';
import '../../../experience/presentation/widgets/experience_section.dart';
import '../../../footer/presentation/widgets/footer_section.dart';
import '../../../hero/presentation/widgets/hero_section.dart';
import '../../../projects/presentation/pages/projects_page.dart';
import '../../../skills/presentation/widgets/skills_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollCtrl;

  @override
  void initState() {
    super.initState();
    _scrollCtrl = ScrollController();
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: _scrollCtrl,
      child: Scaffold(
        backgroundColor: AppTheme.slate950,
        body: SingleChildScrollView(
          controller: _scrollCtrl,
          child: Column(
            children: [
              const HeroSection(),
              RevealOnScroll(
                delay: const Duration(milliseconds: 80),
                child: const SkillsSection(),
              ),
              RevealOnScroll(
                delay: const Duration(milliseconds: 80),
                child: const ProjectsPageContent(),
              ),
              RevealOnScroll(
                delay: const Duration(milliseconds: 80),
                child: const ExperienceSection(),
              ),
              RevealOnScroll(
                delay: const Duration(milliseconds: 80),
                child: const ContactSection(),
              ),
              RevealOnScroll(child: const FooterSection()),
            ],
          ),
        ),
      ),
    );
  }
}
