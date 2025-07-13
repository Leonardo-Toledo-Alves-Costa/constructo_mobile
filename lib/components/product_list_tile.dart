import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          elevation: 10,
          margin: EdgeInsets.all(5),
          
          child: ListTile(
            title: Row(
              children: [
                Text('Nome: Produto ${index + 1}'),
              ],
            ),
            titleTextStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF061D3D),
            ),
            subtitle: Text('Data de cadastro: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}'),
            subtitleTextStyle: TextStyle(
              fontSize: 14,
              color: Color(0xFF061D3D),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text('Marca: Votoran', style: TextStyle(color: Color(0xFF061D3D))),
                    SizedBox(height: 15),
                    Text('Quantidade: ${index + 1}', style: TextStyle(color: Colors.red, fontSize: 14) ),
                  ],
                ),
                SizedBox(width: 10),
                IconButton(onPressed: () {}, 
                icon: Icon(Icons.edit, color: Color(0xFF061D3D)),
                          ),
              ],
            ),
        ),
        );
      },
    );
  }
}