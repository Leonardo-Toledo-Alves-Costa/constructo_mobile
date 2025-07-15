import 'package:constructo_project/utils/app_colors.dart';
import 'package:constructo_project/utils/app_routes.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
                  child: Image.asset('assets/images/Logo.png'),
                ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 200.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.loginpage)
                    ,
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColors.brandColor0),
                    fixedSize: WidgetStateProperty.all(Size(100, 45)),
                    ), 
                    child: Text('Login'),
                    ),
                    SizedBox(width: 10),
                    TextButton(onPressed: () {
                      Navigator.pushNamed(context,
                      AppRoutes.signuppage
                      );
                    },
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(AppColors.secondaryColor0),
                    fixedSize: WidgetStateProperty.all(Size(100, 45)),
                    ), 
                    child: Text('Cadastro'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ); 
  }
}
