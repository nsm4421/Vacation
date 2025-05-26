import 'package:flutter/material.dart';
import 'package:vacation/dependency_injection.dart';
import 'package:vacation/presentation/pages/export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Vacation',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      routerConfig: getIt<CustomRouter>().routerConfig,
    );
  }
}
