import 'package:constructo_project/components/stock_list.dart';
import 'package:constructo_project/pages/filter_page.dart';
import 'package:constructo_project/pages/home_page.dart';
import 'package:constructo_project/pages/profile_page.dart';
import 'package:constructo_project/pages/register_stock_page.dart';
import 'package:constructo_project/pages/stock_page.dart';
import 'package:constructo_project/pages/welcome_page.dart';
import 'package:constructo_project/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StockList()),
      ],
      child: MaterialApp(
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
          AppRoutes.cadastroEstoque: (context) => const RegisterStockPage(),
          AppRoutes.homepage: (context) => const HomePage(),
          AppRoutes.estoque: (context) => const StockPage(),
          AppRoutes.perfil: (context) => const ProfilePage(),
          AppRoutes.filtroEstoque: (context) => const FilterPage(),
        },
      ),
    );
  }
}
  
