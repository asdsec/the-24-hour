import 'package:flutter/material.dart';
import 'package:the_24_hour/product/extension/context_extensions.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings',
        style: context.textTheme.headlineMedium,
      ),
    );
  }
}
