import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:springboot_flutter_bloggingapp/model/theme/theme_provider.dart';

class ChangeThemeButtonWidget extends ConsumerStatefulWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  ConsumerState<ChangeThemeButtonWidget> createState() => _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends ConsumerState<ChangeThemeButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = ref.watch(themeDataProvider);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.toggleTheme(isOn: value);
      },
    );
  }
}