
import 'package:expense_tracker/components/metas_item.dart';
import 'package:expense_tracker/models/meta.dart';
import 'package:expense_tracker/repository/meta_repository.dart';
import 'package:flutter/material.dart';


class MetasEconomiaPage extends StatefulWidget {
  const MetasEconomiaPage({super.key});

  @override
  State<MetasEconomiaPage> createState() => _MetasEconomiaPageState();
}

class _MetasEconomiaPageState extends State<MetasEconomiaPage> {
 final metasFutere = MetaRepository().listarMetas();

 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas de economia'),
      ),
      body: FutureBuilder<List<Meta>>(
        future: metasFutere,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma meta cadastrada.'));
          }else {
            final metas = snapshot.data!;
            return ListView.builder(
                  itemCount: metas.length,
                  itemBuilder: (context, index) {
                    final meta = metas[index];
                    return MetasItem(meta: meta);
                  },
                );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "meta-cadastro",
        onPressed: () {
          Navigator.pushNamed(context, '/metas-cadastro');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}