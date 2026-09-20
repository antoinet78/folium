import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/database/isar_service.dart';
import 'features/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final stopwatch = Stopwatch()..start();
  try {
    await IsarService.instance.open();
    debugPrint('Isar opened in ${stopwatch.elapsedMilliseconds}ms');
  } catch (e) {
    debugPrint('Isar open error: $e');
  }

  runApp(const ProviderScope(child: FoliumApp()));
}

class FoliumApp extends StatelessWidget {
  const FoliumApp({super.key});

  @override
  Widget build(BuildContext context) {
    final lightScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF2D4A22), brightness: Brightness.light);
    final darkScheme = ColorScheme.fromSeed(seedColor: const Color(0xFF2D4A22), brightness: Brightness.dark);

    return MaterialApp(
      title: 'Folium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: lightScheme.surface,
        appBarTheme: AppBarTheme(backgroundColor: lightScheme.surface, surfaceTintColor: Colors.transparent),
        cardTheme: CardThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      ),
      darkTheme: ThemeData(
        colorScheme: darkScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: darkScheme.surface,
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
