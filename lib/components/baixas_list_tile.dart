import 'package:constructo_project/components/baixa_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaixasListTile extends StatelessWidget {

  const BaixasListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final baixaList = Provider.of<BaixaList>(context);
    final baixas = baixaList.baixas;
    return ListView.builder(
        itemCount: baixas.length,
        itemBuilder: (context, index) {
          final baixa = baixas[index];
          return ListTile(
            title: Text(baixa.estoque.product.nome),
            subtitle: Text('Quantidade: ${baixa.quantidade}'),
          );
        },
      );
  }
}