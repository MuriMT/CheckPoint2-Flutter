import 'package:expense_tracker/repository/meta_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

import '../models/meta.dart';

class MetasCadastro extends StatefulWidget {
  const MetasCadastro({super.key});

  @override
  State<MetasCadastro> createState() => _MetasCadastroState();
}

class _MetasCadastroState extends State<MetasCadastro> {
final descricaoController = TextEditingController();
final valorController = TextEditingController();
final dataInicioController = TextEditingController();
final dataConclusaoController = TextEditingController();

final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDescricao(),
                const SizedBox(height: 30),
                _buildValor(),
                const SizedBox(height: 30),
                _buildDataInicio(),
                const SizedBox(height: 30),
                _buildDataConclusao(),
                ElevatedButton(
                 
                 
                  onPressed:(){
                   final isValid = _formKey.currentState!.validate();
                   if(isValid){
                    final descricao = descricaoController.text;
                   final valor = NumberFormat.currency(locale: 'pt_BR')
                .parse(valorController.text.replaceAll('R\$', ''));
                final dataInicio = DateFormat('dd/MM/yyyy').parse(dataInicioController.text);
                final dataConclusao = DateFormat('dd/MM/yyyy').parse(dataConclusaoController.text);
                   
                   final meta = Meta(
                      id: 0,
                      descricao: descricao,
                      valor: valor.toDouble(),
                      dataInicio: dataInicio,
                      dataConclusao: dataConclusao
                    );
                  _cadastrarMeta(meta);
                   }
                   
                  },
                 child: Text("Cadastrar"),
                 
                 )
              ],
            ),
          ),
        ),
      ),
    );
  }



TextFormField _buildDescricao() {
    return TextFormField(
      controller: descricaoController,
      decoration: const InputDecoration(
        hintText: 'Informe a descrição',
        labelText: 'Descrição',
        prefixIcon: Icon(Ionicons.text_outline),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Descrição';
        }
        if (value.length < 5 || value.length > 30) {
          return 'A Descrição deve entre 5 e 30 caracteres';
        }
        return null;
      },
    );

}

TextFormField _buildValor() {
    return TextFormField(
      controller: valorController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: 'Informe o valor',
        labelText: 'Valor',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Ionicons.cash_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe um Valor';
        }
        final valor = NumberFormat.currency(locale: 'pt_BR')
            .parse(valorController.text.replaceAll('R\$', ''));
        if (valor <= 0) {
          return 'Informe um valor maior que zero';
        }

        return null;
      },
    );
  }

  TextFormField _buildDataInicio() {
    return TextFormField(
      controller: dataInicioController,
      keyboardType: TextInputType.none,
      decoration: const InputDecoration(
        hintText: 'Informe uma Data',
        labelText: 'Data',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Ionicons.calendar_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
      onTap: () async {
        //FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          dataInicioController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
    );
  }


  TextFormField _buildDataConclusao() {
    return TextFormField(
      controller: dataConclusaoController,
      keyboardType: TextInputType.none,
      decoration: const InputDecoration(
        hintText: 'Informe uma Data',
        labelText: 'Data',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Ionicons.calendar_outline),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe uma Data';
        }

        try {
          DateFormat('dd/MM/yyyy').parse(value);
        } on FormatException {
          return 'Formato de data inválida';
        }

        return null;
      },
      onTap: () async {
        //FocusScope.of(context).requestFocus(FocusNode());

        DateTime? dataSelecionada = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (dataSelecionada != null) {
          dataConclusaoController.text =
              DateFormat('dd/MM/yyyy').format(dataSelecionada);
        }
      },
    );
  }

Future<void> _cadastrarMeta(Meta meta) async {
  final scaffold = ScaffoldMessenger.of(context);
  try {
    await MetaRepository().cadastrarMetas(meta);
    // Mensagem de Sucesso
    scaffold.showSnackBar(SnackBar(
      content: Text('Meta cadastrada com sucesso'),
    ));
    Navigator.of(context).pop(true);
  } catch (error) {
    // Mensagem de Erro
    scaffold.showSnackBar(SnackBar(
      content: Text('Erro ao cadastrar meta: $error'),
    ));
    Navigator.of(context).pop(false);
  }
}



}