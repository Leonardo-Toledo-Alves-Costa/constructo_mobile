import 'dart:io';

import 'package:constructo_project/components/product_firebase.dart';
import 'package:constructo_project/components/user_firebase.dart';
import 'package:constructo_project/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:constructo_project/components/product.dart';
import 'package:constructo_project/utils/app_colors.dart';

class ProductListTile extends StatelessWidget {
  ProductListTile({super.key});
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final _productFirebase = ProductFirebase();
  final _userFirebase = UserFirebase().userStream;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: _productFirebase.productStream,
      builder: (context, snapshot) {
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              margin: EdgeInsets.all(5),  
              child: Row(
                children: [
                    Container(
                        width: 80,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(File(snapshot.data?[index].imageUrl ?? '')),
                            fit: BoxFit.fill,
                            scale: 1
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nome:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                          Text(snapshot.data?[index].nome ?? 'Produto Generico', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('Data de cadastro:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 12)),
                      Text(snapshot.data?[index].dataCadastro != null
                          ? _dateFormat.format(snapshot.data![index].dataCadastro)
                          : 'N/A', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 12)),
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Marca:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                      Text(snapshot.data?[index].marca ?? 'Marca Genérica', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 10)),
                      SizedBox(height: 10),
                      Text('Tipo:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                      Text(snapshot.data?[index].tipo ?? 'Tipo Genérico', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 10)),
                    ],
                  ),
                  StreamBuilder(
                    stream: _userFirebase,
                    builder: (context, asyncSnapshot) {
                      final user = asyncSnapshot.data;
                      if (user?.role == 'Administrador') {
                        return IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/cadastro_produto', arguments: snapshot.data?[index]);
                          },
                          icon: Icon(Icons.edit),
                        );
                      }
                      else{
                        return SizedBox(width: 1);
                      }
                    }
                  )
                ],
                  ),
                );
              },
              );
            },
          );
        }
}