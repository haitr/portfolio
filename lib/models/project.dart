enum ProjectType {
  openSource,
  app;

  static ProjectType fromString(String value) {
    return ProjectType.values.firstWhere((e) => e.name == value);
  }
}

class Project {
  final String name;
  final String description;
  final String? image;
  final ProjectLinks link;
  final ProjectType type;
  final bool important;
  final String? typeDetail;
  final bool show;
  Project({
    required this.name,
    required this.description,
    required this.image,
    required this.link,
    required this.type,
    required this.important,
    this.typeDetail,
    required this.show,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String?,
      link: ProjectLinks.fromJson(json['link'] as Map<String, dynamic>),
      type: ProjectType.fromString(json['type'] as String),
      important: json['important'] ?? false,
      typeDetail: json['type_detail'] as String?,
      show: json['show'] ?? false,
    );
  }
}

class ProjectLinks {
  final String? github;
  final String? appstore;
  final String? playstore;
  final String? website;

  ProjectLinks({this.github, this.appstore, this.playstore, this.website});

  factory ProjectLinks.fromJson(Map<String, dynamic> json) {
    return ProjectLinks(
      github: json['github'] as String?,
      appstore: json['appstore'] as String?,
      playstore: json['playstore'] as String?,
      website: json['website'] as String?,
    );
  }
}
