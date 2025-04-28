import 'package:flutter/material.dart';

SegmentedButtonThemeData buildSegmentedButtonTheme(ColorScheme colorScheme) {
  return SegmentedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      side: WidgetStatePropertyAll(
        BorderSide(
          color: const Color(0xFFCCCCCC), // světle hnědá / neutrální
        ),
      ),
      padding: WidgetStatePropertyAll(
        const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),

      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return colorScheme.primary.withOpacity(0.1);
        }
        return colorScheme.surface;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.onSurface;
      }),
    ),
  );
}
