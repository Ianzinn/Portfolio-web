class ExperienceEntity {
  final String id;
  final String gitCommand;
  final String commitMessage;
  final String role;
  final String roleLabel;
  final String company;
  final String period;
  final String description;
  final List<String> achievements;
  final String? codeSnippet;

  const ExperienceEntity({
    required this.id,
    required this.gitCommand,
    required this.commitMessage,
    required this.role,
    required this.roleLabel,
    required this.company,
    required this.period,
    required this.description,
    required this.achievements,
    this.codeSnippet,
  });

  bool get isNextStep => codeSnippet != null;
}
