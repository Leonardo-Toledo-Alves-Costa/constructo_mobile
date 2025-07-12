import 'package:flutter/material.dart';
import 'package:constructo_project/utils/app_colors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Carregando aplicação...',
            style: Theme.of(context).textTheme.headlineMedium)
          ],
        ),
      ),
    );
  }
}