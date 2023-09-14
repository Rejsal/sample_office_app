import 'package:sample_office_project/models/job_model.dart';
import 'package:sample_office_project/models/project_model.dart';
import 'package:sample_office_project/utils/database_helper.dart';

class ProjectRepository {
  final DatabaseHelper databaseHelper;

  ProjectRepository({required this.databaseHelper});

  // get projects list from db
  Future<List<ProjectModel>?> getProjects() async {
    final db = await databaseHelper.database;
    if (db == null) {
      return null;
    }
    final List<Map<String, dynamic>> maps = await db.query('projects');
    return List.generate(maps.length, (i) {
      return ProjectModel.fromMap(maps[i]);
    });
  }

  // insert project in to db
  Future<void> insertProject(ProjectModel project) async {
    final db = await databaseHelper.database;
    if (db == null) {
      return;
    }
    await db.insert('projects', project.toMap());
  }

  // get jobs under project based on project id
  Future<List<JobModel>?> getJobs(int projectId) async {
    final db = await databaseHelper.database;
    if (db == null) {
      return null;
    }
    final List<Map<String, dynamic>> maps = await db.query(
      'jobs',
      where: 'project_id = ?',
      whereArgs: [projectId],
    );
    return List.generate(maps.length, (i) {
      return JobModel.fromMap(maps[i]);
    });
  }

  // insert job
  Future<void> insertJob(JobModel job) async {
    final db = await databaseHelper.database;
    if (db == null) {
      return;
    }
    await db.insert('jobs', job.toMap());
  }
}
