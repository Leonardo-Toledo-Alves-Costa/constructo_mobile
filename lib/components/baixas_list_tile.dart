import 'package:flutter/material.dart';
import 'package:constructo_project/utils/app_colors.dart';
class BaixasListTile extends StatelessWidget {

  const BaixasListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Nome do Produto'),
            subtitle: Text('Quantidade: 1'),
          );
        },
      );
  }
}