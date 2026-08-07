import 'package:crash_heal/crash_heal.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Override the default error widget (red screen)
  /* ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              details.exception.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            */ /*  const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // In a real app, you might want to report this or restart
              },
              child: const Text('Report Error'),
            )*/ /*
          ],
        ),
      ),
    );
  };*/
  try {
    await CrashHeal.init(
      apiKey: '6a760642757bfee2f4bbdc34.tcpksc9ybUWua9WILWL_XeDSRSF0j_1eLUFBy5IXpmY',
      appName: 'news_app_flutter',

      syncInterval: const Duration(hours: 1), // Rapid sync interval for interactive testing
      enableLogging: true,
    );
  } catch (e) {
    debugPrint('Failed to initialize CrashHeal in main(): $e');
  }
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A73E8)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F6F8),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
