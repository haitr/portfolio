import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/project.dart';

final projectProvider = FutureProvider<List<Project>>((ref) async {
  final jsonString = await rootBundle.loadString('assets/data/projects.json');
  final jsonList = json.decode(jsonString) as List;
  return jsonList
      .map((data) => Project.fromJson(data as Map<String, dynamic>))
      .where((project) => project.show)
      .toList();
});

final importantProjectProvider = Provider<List<Project>>((ref) {
  final projects = ref.watch(projectProvider);
  return projects.when(
    data: (projects) => projects.where((project) => project.important).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
});
