import 'package:flutter/material.dart';
import 'package:the_24_hour/product/extension/context_extensions.dart';
import 'package:the_24_hour/product/init/common/page_padding.dart';

class FormErrorContainer extends StatelessWidget {
  const FormErrorContainer({super.key, required this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('dismissible'),
      child: Container(
        padding: const WidgetPadding.container(),
        decoration: BoxDecoration(
          border: Border.all(
            color: context.colorScheme.error.withOpacity(.5),
            strokeAlign: BorderSide.strokeAlignOutside,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.error.withOpacity(.4),
        ),
        child: Center(
          child: Text(
            error ?? 'Unspecified Error',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
