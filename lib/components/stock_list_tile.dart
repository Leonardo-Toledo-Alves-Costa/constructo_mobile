import 'package:constructo_project/components/stock.dart';
import 'package:constructo_project/components/stock_firebase.dart';
import 'package:constructo_project/components/user_firebase.dart';
import 'package:constructo_project/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:constructo_project/utils/app_colors.dart';

class StockListTile extends StatefulWidget {
  int orderbyTipo = 0;
  int orderbyData = 0;
  int orderbyNumeroLote = 0;
  int orderbyQuantidade = 0;
  String? tipoFiltro;
  String? dataFiltroDe;
  String? dataFiltroAte;
  String? nomeFiltro;
  String? loteFiltro;

  StockListTile({super.key, this.orderbyNumeroLote = 0, this.orderbyQuantidade = 0, this.orderbyTipo = 0, this.orderbyData = 0, this.tipoFiltro, this.dataFiltroDe, this.dataFiltroAte, this.nomeFiltro, this.loteFiltro});

  @override
  State<StockListTile> createState() => _StockListTileState();
}

class _StockListTileState extends State<StockListTile> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  final _stockFirebase = StockFirebase();

  final _userFirebase = UserFirebase().userStream;


  Stream<List<Stock>> filterStreambyTipo(){

    return _stockFirebase.stockStream.map((stocks) {
      return stocks.where((stock) {
        final matchesTipo = stock.tipo == widget.tipoFiltro;
        return matchesTipo;
      }).toList();
    });
  }

  Stream<List<Stock>> filterStreambyData() {
    return _stockFirebase.stockStream.map((stocks) {
      return stocks.where((stock) {
        final matchesDataDe = widget.dataFiltroDe != null && stock.dataCadastro.isAfter(DateTime.parse(widget.dataFiltroDe!));
        final matchesDataAte = widget.dataFiltroAte != null && stock.dataCadastro.isBefore(DateTime.parse(widget.dataFiltroAte!));
        return matchesDataDe && matchesDataAte;
      }).toList();
    });
  }
  
  Stream<List<Stock>> filterStreambyLote() {
    return _stockFirebase.stockStream.map((stocks) {
      return stocks.where((stock) {
        final matchesLote = stock.lote == widget.loteFiltro;
        return matchesLote;
      }).toList();
    });
  }

  Stream<List<Stock>> filterStreambyNome() {
    return _stockFirebase.stockStream.map((stocks) {
      return stocks.where((stock) {
        final matchesNome = stock.product.toLowerCase().contains(widget.nomeFiltro?.toLowerCase() ?? '');
        return matchesNome;
      }).toList();
    });
  }

  Stream<List<Stock>> orderstream() {

    if (widget.tipoFiltro != null && widget.tipoFiltro!.isNotEmpty) {
      return filterStreambyTipo();
    }

    if (widget.dataFiltroDe != null && widget.dataFiltroDe!.isNotEmpty && widget.dataFiltroAte != null && widget.dataFiltroAte!.isNotEmpty) {
      return filterStreambyData();
    }

    if (widget.nomeFiltro != null && widget.nomeFiltro!.isNotEmpty) {
      return filterStreambyNome();
    }

    return _stockFirebase.stockStream.map((stocks){
      if (widget.orderbyTipo == 1) {
        stocks.sort((a, b) => a.tipo.compareTo(b.tipo));
      } else if (widget.orderbyTipo == 2) {
        stocks.sort((a, b) => b.tipo.compareTo(a.tipo));
      }
      if (widget.orderbyData == 1) {
        stocks.sort((a, b) => a.dataCadastro.compareTo(b.dataCadastro));
      } else if (widget.orderbyData == 2) {
        stocks.sort((a, b) => b.dataCadastro.compareTo(a.dataCadastro));
      }
      if (widget.orderbyNumeroLote == 1) {
        stocks.sort((a, b) => int.parse(a.lote).compareTo(int.parse(b.lote)));
      } else if (widget.orderbyNumeroLote == 2) {
        stocks.sort((a, b) => int.parse(b.lote).compareTo(int.parse(a.lote)));
      }
      if(widget.orderbyQuantidade == 1) {
        stocks.sort((a, b) => int.parse(a.quantidade).compareTo(int.parse(b.quantidade)));
      } else if(widget.orderbyQuantidade == 2) {
        stocks.sort((a, b) => int.parse(b.quantidade).compareTo(int.parse(a.quantidade)));
      }
      return stocks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Stock>>(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nome:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                          Text(snapshot.data?[index].product ?? 'Produto Generico', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('Data de cadastro:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 12)),
                      Text(snapshot.data?[index].dataCadastro != null
                          ? _dateFormat.format(snapshot.data![index].dataCadastro)
                          : 'N/A', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 12)),
                      Text('Tipo:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                      Text(snapshot.data?[index].tipo ?? 'Tipo Genérico', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Lote:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                      Text(snapshot.data?[index].lote.toString() ?? 'Sem Lote', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 10)),
                      SizedBox(height: 10),
                      Text('Quantidade:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                      Text(snapshot.data?[index].quantidade.toString() ?? '0', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 10)),
                      
                    ],
                  ),
                  SizedBox(width: 25),
                  Column(
                    children: [
                      SizedBox(height: 35),
                      StreamBuilder(
                        stream: _userFirebase,
                        builder: (context, asyncSnapshot) {
                          final user = asyncSnapshot.data;
                          if (user?.role == 'Administrador' || user?.role == 'Estoquista') {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: AppColors.brandColor0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () => Navigator.pushNamed(context, '/cadastro_estoque', arguments: snapshot.data?[index]),
                              child: Row(
                                children: [
                                  Icon(Icons.edit),
                                  SizedBox(width: 5),
                                  Text('Editar'),
                                ],
                              ),
                            );
                          }
                          else {
                            return SizedBox.shrink();
                          }
                        }
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
