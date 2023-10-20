import 'package:flutter/material.dart';


import '../models/meta.dart';

class MetasItem extends StatelessWidget {
  final Meta meta;

  MetasItem({Key? key, required this.meta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue, // Cor do ícone (ajuste conforme necessário)
        child: Icon(
          Icons. security_rounded, // Ícone da meta (ajuste conforme necessário)
          size: 20,
          color: Colors.white,
        ),
      ),
      title: Text(
        meta.descricao,
      ),
      subtitle: Text(
        'Valor: R\$ ${meta.valor.toStringAsFixed(2)}', // Formatando o valor da meta
      ),
      trailing: Text(
        'Conclusão: ${_formatDate(meta.dataConclusao)}', // Formatando a data de conclusão
        style: TextStyle(
          fontSize: 14,
          color: Colors.blue, // Cor da data de conclusão (ajuste conforme necessário)
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Função para formatar a data como 'dd/MM/yyyy'
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }
}
