import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'constants/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const HealtheticApp());
  });
}

class HealtheticApp extends StatelessWidget {
  const HealtheticApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healthetic Lifestyle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto', // Default modern fallback
        primaryColor: primaryGreen,
        scaffoldBackgroundColor: neutralWhite,
      ),
      home: const SplashScreen(),
    );
  }
}
