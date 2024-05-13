import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:remake/common/extension/extension.dart';
import 'package:remake/common/style/size/size.dart';
import 'package:remake/domain/entities/task_entities.dart';

class MyCard extends StatelessWidget {
  final String title;
  final DateTime time;
  final Color color;
  final Priority priority;

  const MyCard({
    Key? key,
    required this.title,
    required this.time,
    required this.color,
    required this.priority,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 1,
      child: ClipPath(
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 120,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: color, width: 5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _widget1(),
              Text(title),
              Text(
                'Type ${priority.name[0].toUpperCase()}${priority.name.substring(1)}',
              )
            ],
          ),
        ),
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  Widget _widget1() {
    return Row(
      children: [
        Icon(
          LucideIcons.calendar,
          size: 20,
        ),
        SizedBox(width: 5),
        Text(
          time.dayOfWeek,
        ),
      ],
    );
  }
}

