class ProjectModel {
  int? id;
  String title;
  String name;

  ProjectModel({
    this.id,
    required this.title,
    required this.name,
  });

  // Convert a map to a Task object
  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: map['id'],
      title: map['title'],
      name: map['name'],
    );
  }

  // Convert Task object to a map
  Map<String, dynamic> toMap() {
    return {'title': title, 'name': name};
  }
}
