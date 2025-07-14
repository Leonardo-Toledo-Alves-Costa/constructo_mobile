import 'package:constructo_project/components/stock.dart';
import 'package:constructo_project/components/stock_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockListTile extends StatelessWidget {

  const StockListTile({super.key,});

  @override
  Widget build(BuildContext context) {
    final stocklist = Provider.of<StockList>(context);
    final stocks = stocklist.stocks;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: stocks.length,
        itemBuilder: (context, index) {
          final stock = stocks[index];
          return ListTile(
            title: Text(stock.product.nome),
            subtitle: Text('Quantidade: ${stock.quantidade}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                stocklist.removeStock(stock);
              },
            ),
          );
        },
      );
  }
}