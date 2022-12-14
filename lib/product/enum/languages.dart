import 'package:flutter/material.dart';

enum Languages {
  tr,
  en;

  Locale get locale {
    switch (this) {
      case Languages.en:
        return const Locale('en', 'US');
      case Languages.tr:
        return const Locale('tr', 'TR');
    }
  }
}
