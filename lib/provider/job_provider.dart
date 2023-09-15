import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:sample_office_project/models/job_model.dart';
import 'package:sample_office_project/repository/project_repository.dart';

class JobProvider extends ChangeNotifier {
  JobProvider({required this.projectRepository});

  final ProjectRepository projectRepository;

  List<JobModel> _jobs = [];

  List<JobModel> get jobs => _jobs;

  Future<void> loadJobs(int projectId) async {
    if (kIsWeb) {
      return;
    }
    final data = await projectRepository.getJobs(projectId);
    if (data != null) {
      _jobs = data;
      notifyListeners();
    }
  }

  Future<void> addJob(JobModel job) async {
    if (kIsWeb) {
      _jobs = [..._jobs, job];
      notifyListeners();
      return;
    }
    await projectRepository.insertJob(job);
    loadJobs(job.projectId);
  }
}
