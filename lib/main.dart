import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/screens/home_screen.dart';
import 'package:stopwatch/themes/dark_theme.dart';
import 'package:stopwatch/themes/light_theme.dart';
import 'package:stopwatch/themes/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          title: 'Stopwatch',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: provider.currentTheme(),
          home: const HomeScreen(),
        );
      },
    );
  }
}
