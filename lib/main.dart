import 'package:constructo_project/pages/login_page.dart';
import 'package:constructo_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:constructo_project/pages/signup_page.dart';
import 'package:constructo_project/pages/welcome_page.dart';
import 'package:constructo_project/utils/app_colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Constructo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.brandColor1,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.letterColorBlackBlue,
        foregroundColor: AppColors.letterColorLightBlue,
        ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontSize: 16, color: AppColors.letterColorBlackBlue),
        headlineMedium: TextStyle(fontSize: 18, color: AppColors.letterColorBlackBlue),
        bodySmall: TextStyle(fontSize: 16, color: AppColors.letterColorLightBlue),
        bodyMedium: TextStyle(fontSize: 16, color: AppColors.letterColorLightBlue),
          ),
        textButtonTheme: TextButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.letterColorLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ),
      initialRoute: AppRoutes.welcomepage,
      routes: {
        AppRoutes.welcomepage: (context) => const WelcomePage(),
        AppRoutes.signuppage: (context) => const SignupPage(),
        AppRoutes.loginpage: (context) => const LoginPage(),
      },
    );
  }
}
  
