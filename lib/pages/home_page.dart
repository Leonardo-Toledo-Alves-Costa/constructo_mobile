import 'package:constructo_project/components/drawer.dart';
import 'package:constructo_project/components/product_list_tile.dart';
import 'package:constructo_project/components/user_firebase.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _userFirebase = UserFirebase();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/Logo.png', height: 40),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: Icon(Icons.person_pin, size: 35,),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
                width: 350,
                height: 200,
                child: Card(
                  color: AppColors.letterColorBlackBlue,
                  elevation: 4,
                  child: StreamBuilder(
                    stream: _userFirebase.userStream,
                    builder: (context, snapshot) {
                      final usuario = snapshot.data;
                      return Container(
                        padding: EdgeInsets.all(20.0),
                        alignment: Alignment.bottomCenter,
                        child: Text('Bem Vindo, ${usuario?.name}',
                          style: TextStyle(
                            color: AppColors.letterColorLightBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  ),
                ),
              ),
          ),
        Padding(
          padding: const EdgeInsets.all(35.0),
          child: SizedBox(
            child: Text(
              'Materiais em Falta',
              style: TextStyle(
                color: AppColors.letterColorBlackBlue,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(child: ProductListTile()),
        ],
      ),
      drawer: DrawerComponent(),
      );
  }
}