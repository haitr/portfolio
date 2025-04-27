class Skill {
  final String name;
  final int percentage;

  Skill({required this.name, required this.percentage});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(name: json['name'] as String, percentage: json['percentage'] as int);
  }
}
