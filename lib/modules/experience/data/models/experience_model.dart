import '../../domain/entities/experience_entity.dart';

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.id,
    required super.gitCommand,
    required super.commitMessage,
    required super.role,
    required super.roleLabel,
    required super.company,
    required super.period,
    required super.description,
    required super.achievements,
    super.codeSnippet,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'] as String,
      gitCommand: json['gitCommand'] as String? ?? 'git commit -m',
      commitMessage: json['commitMessage'] as String? ?? '',
      role: json['role'] as String,
      roleLabel: json['roleLabel'] as String? ?? json['role'] as String,
      company: json['company'] as String,
      period: json['period'] as String,
      description: json['description'] as String,
      achievements: List<String>.from(json['achievements'] as List),
      codeSnippet: json['codeSnippet'] as String?,
    );
  }
}
