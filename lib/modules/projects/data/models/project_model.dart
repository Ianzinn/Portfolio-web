import '../../domain/entities/project_entity.dart';

/// Extensão da Entity com capacidade de serialização/desserialização JSON.
/// A Domain Layer não conhece este arquivo.
class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.id,
    required super.title,
    required super.description,
    required super.technologies,
    required super.githubUrl,
    super.imageUrl,
    super.linesCount,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      githubUrl: json['githubUrl'] as String,
      imageUrl: json['imageUrl'] as String?,
      linesCount: json['linesCount'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'technologies': technologies,
        'githubUrl': githubUrl,
        'imageUrl': imageUrl,
        'linesCount': linesCount,
      };
}
