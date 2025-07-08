import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
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
                    TextButton(onPressed: () {},
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Color(0xFFB24E00)),
                    fixedSize: WidgetStateProperty.all(Size(100, 45)),
                    ), 
                    child: Text('Login'),
                    ),
                    SizedBox(width: 10),
                    TextButton(onPressed: () {},
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Color(0xFF061D3D)),
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
