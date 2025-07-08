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
                child: Text(
                  'Constructo initial page',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {},
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Color(0xFF061D3D))), 
                  child: Text('Login'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
