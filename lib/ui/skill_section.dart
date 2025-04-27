import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:portfolio/utils/context.dart';

import '../models/skill.dart';
import 'ui.dart';

class SkillSection extends StatefulWidget {
  const SkillSection({super.key});

  @override
  State<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends State<SkillSection> {
  var _skills = <Skill>[];

  @override
  void initState() {
    super.initState();
    _loadSkills();
  }

  Future<void> _loadSkills() async {
    try {
      final jsonString = await DefaultAssetBundle.of(context).loadString('assets/data/skills.json');
      final jsonList = json.decode(jsonString) as List;
      setState(() {
        _skills = jsonList.map((data) => Skill.fromJson(data as Map<String, dynamic>)).toList();
      });
    } catch (e) {
      debugPrint('Error loading skills: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text('<skills>', style: context.textTheme.displaySmall!.copyWith(color: context.colorScheme.primary)),
          h24,
          ..._skills.map(
            (skill) => Container(
              margin: EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Expanded(
                    flex: skill.percentage,
                    child: Container(
                      padding: EdgeInsets.only(left: 8.0),
                      alignment: Alignment.centerLeft,
                      height: 36.0,
                      color: context.colorScheme.primary,
                      child: Text(skill.name, style: TextStyle(color: context.colorScheme.onPrimary)),
                    ),
                  ),
                  w8,
                  Expanded(
                    // remaining (blank part)
                    flex: 100 - skill.percentage,
                    child: Divider(),
                  ),
                  w8,
                  Text("${skill.percentage}%", style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
