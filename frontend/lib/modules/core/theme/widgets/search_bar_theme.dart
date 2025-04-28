import 'package:flutter/material.dart';

SearchBarThemeData buildSearchBarTheme(ColorScheme colorScheme) {
  return SearchBarThemeData(
    backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainerLow),
    textStyle: WidgetStatePropertyAll(
      TextStyle(color: colorScheme.onSurface, fontSize: 16),
    ),
    hintStyle: WidgetStatePropertyAll(
      TextStyle(color: colorScheme.onSurface.withAlpha((0.6 * 255).round())),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    elevation: WidgetStatePropertyAll(0),
    padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8)),
    constraints: BoxConstraints(minHeight: 40),
    side: WidgetStatePropertyAll(
      BorderSide(
        color: Color(0xFFCCCCCC), // tmavší vs světlejší hnědá
      ),
    ),
  );
}
