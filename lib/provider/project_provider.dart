import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sample_office_project/models/project_model.dart';
import 'package:sample_office_project/repository/project_repository.dart';

class ProjectProvider extends ChangeNotifier {
  ProjectProvider({required this.projectRepository});

  final ProjectRepository projectRepository;

  List<ProjectModel> _projects = [];

  List<ProjectModel> get projects => _projects;

  Future<void> loadProjects() async {
    final data = await projectRepository.getProjects();
    if (data != null) {
      _projects = data;
      notifyListeners();
    }
  }

  Future<void> addProject(ProjectModel project) async {
    if (kIsWeb) {
      _projects = [..._projects, project];
      notifyListeners();
      return;
    }
    await projectRepository.insertProject(project);
    loadProjects();
  }
}
