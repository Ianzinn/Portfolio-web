import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/project_model.dart';

abstract class IProjectsLocalDataSource {
  /// Lê o arquivo JSON local (assets/data/projects.json) e retorna os projetos.
  Future<List<ProjectModel>> getProjects();
}

class ProjectsLocalDataSource implements IProjectsLocalDataSource {
  @override
  Future<List<ProjectModel>> getProjects() async {
    final jsonString =
        await rootBundle.loadString('assets/data/projects.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final projectsList = jsonData['projects'] as List<dynamic>;

    return projectsList
        .map((item) => ProjectModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
