import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/experience_model.dart';

abstract class IExperienceLocalDataSource {
  Future<List<ExperienceModel>> getExperiences();
}

class ExperienceLocalDataSource implements IExperienceLocalDataSource {
  @override
  Future<List<ExperienceModel>> getExperiences() async {
    final jsonString =
        await rootBundle.loadString('assets/data/experience.json');
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    final list = jsonData['experiences'] as List<dynamic>;
    return list
        .map((e) => ExperienceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
