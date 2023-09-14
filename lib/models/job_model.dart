class JobModel {
  int? id;
  int projectId;
  String title;
  String description;
  int numberOfRequirements;
  int filledCount;

  JobModel({
    this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.numberOfRequirements,
    required this.filledCount,
  });

  // Convert a map to a Task object
  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'],
      projectId: map['project_id'],
      title: map['title'],
      description: map['description'],
      numberOfRequirements: map['requirement_count'],
      filledCount: map['filled_count'],
    );
  }

  // Convert Task object to a map
  Map<String, dynamic> toMap() {
    return {
      'project_id': projectId,
      'title': title,
      'description': description,
      'requirement_count': numberOfRequirements,
      'filled_count': filledCount
    };
  }
}
