import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockListTile extends StatelessWidget {
  const StockListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('estoque').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar dados.'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;

        if (docs.isEmpty) {
          return const Center(child: Text('Nenhum produto no estoque.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;

            final nome = data['estoque']?['nomeProduto'] ?? 'Sem nome';
            final quantidade = data['quantidade'] ?? 0;
            final lote = data['lote'] ?? 'Sem lote';

            final dataValidade = _formatarData(data['dataValidade']);
            final dataCadastro = _formatarData(data['dataCadastro']);
            final dataEditado = _formatarData(data['dataEditado']);

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              elevation: 2,
              child: ListTile(
                title: Text(
                  nome,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quantidade: $quantidade'),
                    Text('Lote: $lote'),
                    if (dataValidade != null) Text('Validade: $dataValidade'),
                    Text('Cadastrado em: $dataCadastro'),
                    Text('Última edição: $dataEditado'),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('estoque')
                        .doc(docs[index].id)
                        .delete();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  String? _formatarData(dynamic data) {
    if (data == null) return null;
    try {
      DateTime date;
      if (data is Timestamp) {
        date = data.toDate();
      } else if (data is String) {
        date = DateTime.parse(data);
      } else {
        return null;
      }
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return null;
    }
  }
}
