import 'package:constructo_project/components/baixa.dart';
import 'package:constructo_project/components/baixa_firebase.dart';
import 'package:constructo_project/components/user_firebase.dart';
import 'package:constructo_project/pages/loading_page.dart';
import 'package:constructo_project/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class BaixasListTile extends StatelessWidget {

  const BaixasListTile({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final _baixaFirebase = BaixaFirebase();

    return StreamBuilder<List<Baixa>>(
      stream: _baixaFirebase.baixaStream,
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
          padding: EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) {
            return Card(
              elevation: 10,
              margin: EdgeInsets.all(5),
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nome:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                        Text(snapshot.data?[index].estoque ?? 'Produto Generico', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14, fontWeight: FontWeight.bold)),
                        Text('Data da Baixa:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 12)),
                        Text(snapshot.data?[index].data != null ? _dateFormat.format(snapshot.data![index].data) : 'N/A', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 12)),
                      ],
                    ),
                  ),
                  SizedBox(width: 45),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantidade:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                      Text(snapshot.data?[index].quantidade ?? '0', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 10)),
                      SizedBox(height: 10),
                      Text('Usuario:', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 14)),
                      Text(snapshot.data?[index].usuario ?? 'Desconhecido', style: TextStyle(color: AppColors.secondaryColor0, fontSize: 10)),
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
