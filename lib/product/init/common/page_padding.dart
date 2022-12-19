import 'package:flutter/material.dart';

class PagePadding extends EdgeInsets {
  const PagePadding() : super.all(12);
}

class WidgetPadding extends EdgeInsets {
  const WidgetPadding.button() : super.symmetric(vertical: 12);
  const WidgetPadding.formField() : super.symmetric(vertical: 12);
}
