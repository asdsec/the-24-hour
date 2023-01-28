import 'package:flutter/material.dart';
import 'package:the_24_hour/product/extension/context_extensions.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Dashboard',
        style: context.textTheme.headlineMedium,
      ),
    );
  }
}
