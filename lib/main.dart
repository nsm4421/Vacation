import 'package:flutter/material.dart';
import 'package:vacation/dependency_injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vacation/presentation/pages/export.dart';

import 'env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnonKey,
    debug: true,
  );

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
