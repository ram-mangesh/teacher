import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'providers/naac_state.dart';
import 'screens/common/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => NaacState()),
      ],
      child: const SchoolErpApp(),
    ),
  );
}

class SchoolErpApp extends StatefulWidget {
  const SchoolErpApp({super.key});

  @override
  State<SchoolErpApp> createState() => _SchoolErpAppState();
}

class _SchoolErpAppState extends State<SchoolErpApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppState>().loadFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart MCB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFE8342A),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE8342A),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFE8342A),
          secondary: Color(0xFFFF6A3D),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
