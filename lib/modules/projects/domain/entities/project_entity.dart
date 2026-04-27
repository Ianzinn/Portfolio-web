class ProjectEntity {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String githubUrl;
  final String? imageUrl;
  final String? linesCount;

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    required this.githubUrl,
    this.imageUrl,
    this.linesCount,
  });
}
