import 'dart:io';

import 'package:constructo_project/components/product_firebase.dart';
import 'package:constructo_project/components/user_firebase.dart';
import 'package:constructo_project/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:constructo_project/components/product.dart';
import 'package:constructo_project/utils/app_colors.dart';

class ProductListTile extends StatefulWidget {
  int orderbyTipo = 0;
  int orderbyMarca = 0;
  int orderbyData = 0;
  String? marcaFiltro;
  String? tipoFiltro;
  String? dataFiltroDe;
  String? dataFiltroAte;
  String? nomeFiltro;

  ProductListTile({super.key, this.orderbyTipo = 0, this.orderbyMarca = 0, this.orderbyData = 0, this.marcaFiltro, this.tipoFiltro, this.dataFiltroDe, this.dataFiltroAte, this.nomeFiltro});

  @override
  State<ProductListTile> createState() => _ProductListTileState();
}

class _ProductListTileState extends State<ProductListTile> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  final _productFirebase = ProductFirebase();

  final _userFirebase = UserFirebase().userStream;

  Stream<List<Product>> filterStreambyMarca(){
    return _productFirebase.productStream.map((products) {
      return products.where((product) {
        final matchesMarca = product.marca == widget.marcaFiltro;
        return matchesMarca;
      }).toList();
    });
  }
  Stream<List<Product>> filterStreambyTipo(){

    return _productFirebase.productStream.map((products) {
      return products.where((product) {
        final matchesTipo = product.tipo == widget.tipoFiltro;
        return matchesTipo;
      }).toList();
    });
  }

  Stream<List<Product>> filterStreambyData() {
    return _productFirebase.productStream.map((products) {
      return products.where((product) {
        final matchesDataDe = widget.dataFiltroDe != null && product.dataCadastro.isAfter(DateTime.parse(widget.dataFiltroDe!));
        final matchesDataAte = widget.dataFiltroAte != null && product.dataCadastro.isBefore(DateTime.parse(widget.dataFiltroAte!));
        return matchesDataDe && matchesDataAte;
      }).toList();
    });
  }

  Stream<List<Product>> filterStreambyNome() {
    return _productFirebase.productStream.map((products) {
      return products.where((product) {
        final matchesNome = product.nome.toLowerCase().contains(widget.nomeFiltro?.toLowerCase() ?? '');
        return matchesNome;
      }).toList();
    });
  }

  Stream<List<Product>> orderstream() {

    if (widget.tipoFiltro != null && widget.tipoFiltro!.isNotEmpty) {
      return filterStreambyTipo();
    }

    if (widget.marcaFiltro != null && widget.marcaFiltro!.isNotEmpty) {
      return filterStreambyMarca();
    }

    if (widget.dataFiltroDe != null && widget.dataFiltroDe!.isNotEmpty && widget.dataFiltroAte != null && widget.dataFiltroAte!.isNotEmpty) {
      return filterStreambyData();
    }

    if (widget.nomeFiltro != null && widget.nomeFiltro!.isNotEmpty) {
      return filterStreambyNome();
    }

    return _productFirebase.productStream.map((products){
      if (widget.orderbyTipo == 1) {
        products.sort((a, b) => a.tipo.compareTo(b.tipo));
      } else if (widget.orderbyTipo == 2) {
        products.sort((a, b) => b.tipo.compareTo(a.tipo));
      }
      if (widget.orderbyMarca == 1) {
        products.sort((a, b) => a.marca.compareTo(b.marca));
      } else if (widget.orderbyMarca == 2) {
        products.sort((a, b) => b.marca.compareTo(a.marca));
      }
      if (widget.orderbyData == 1) {
        products.sort((a, b) => a.dataCadastro.compareTo(b.dataCadastro));
      } else if (widget.orderbyData == 2) {
        products.sort((a, b) => b.dataCadastro.compareTo(a.dataCadastro));
      }
      return products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: orderstream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum produto cadastrado.'));
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
                      Text(snapshot.data?[index].tipo ?? 'Tipo Genérico', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 9)),
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