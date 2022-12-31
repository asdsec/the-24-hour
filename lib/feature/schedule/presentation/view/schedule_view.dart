import 'package:flutter/material.dart';
import 'package:the_24_hour/product/extension/context_extensions.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Schedule',
        style: context.textTheme.headline4,
      ),
    );
  }
}
