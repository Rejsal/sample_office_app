import 'package:flutter/material.dart';
import 'package:sample_office_project/models/job_model.dart';
import 'package:sample_office_project/repository/project_repository.dart';

class JobProvider extends ChangeNotifier {
  JobProvider({required this.projectRepository});

  final ProjectRepository projectRepository;

  List<JobModel> _jobs = [];

  List<JobModel> get jobs => _jobs;

  Future<void> loadJobs(int projectId) async {
    final data = await projectRepository.getJobs(projectId);
    if (data != null) {
      _jobs = data;
      notifyListeners();
    }
  }

  Future<void> addJob(JobModel job) async {
    await projectRepository.insertJob(job);
    loadJobs(job.projectId);
  }
}
