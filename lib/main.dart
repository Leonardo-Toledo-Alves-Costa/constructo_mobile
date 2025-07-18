
import 'package:constructo_project/pages/change_password_page.dart';
import 'package:constructo_project/pages/login_page.dart';
import 'package:constructo_project/pages/product_filter_page.dart';
import 'package:constructo_project/pages/products_page.dart';
import 'package:constructo_project/pages/register_product_page.dart';
import 'package:constructo_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:constructo_project/pages/signup_page.dart';
import 'package:constructo_project/pages/welcome_page.dart';
import 'package:constructo_project/components/stock_list.dart';
import 'package:constructo_project/pages/filter_page.dart';
import 'package:constructo_project/pages/home_page.dart';
import 'package:constructo_project/pages/profile_page.dart';
import 'package:constructo_project/pages/register_baixa_page.dart';
import 'package:constructo_project/pages/register_stock_page.dart';
import 'package:constructo_project/pages/registro_baixas_page.dart';
import 'package:constructo_project/pages/stock_page.dart';
import 'package:provider/provider.dart';

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
        primaryColor: Color(0xFFB24E00),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFF061D3D),
          foregroundColor: Color(0xFFDFE9F5)
          ),
        textTheme: TextTheme(
          headlineSmall: TextStyle(fontSize: 16, color: Color(0xFF061D3D)),
          headlineMedium: TextStyle(fontSize: 18, color: Color(0xFF061D3D)),
          headlineLarge: TextStyle(fontSize: 30, color: Color(0xFF061D3D)),
          bodySmall: TextStyle(fontSize: 16, color: Color(0xFFDFE9F5)),
          bodyMedium: TextStyle(fontSize: 16, color: Color(0xFFDFE9F5)),
            ),
          textButtonTheme: TextButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Color(0xFFDFE9F5),
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
          AppRoutes.homepage: (context) => const HomePage(),
          AppRoutes.cadastroEstoque: (context) => const RegisterStockPage(),
          AppRoutes.estoque: (context) => const StockPage(),
          AppRoutes.perfil: (context) => const ProfilePage(),
          AppRoutes.filtroEstoque: (context) => const FilterPage(),
          AppRoutes.registroBaixas: (context) => const RegistroBaixasPage(),
          AppRoutes.cadastroBaixa: (context) => const RegisterBaixaPage(),
          AppRoutes.mudarsenha: (context) => const ChangePasswordPage(),
          AppRoutes.produtos: (context) => const ProductsPage(),
          AppRoutes.cadastroProduto: (context) => const RegisterProductPage(),
        },
      );
  }
}
  
