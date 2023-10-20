import 'package:expense_tracker/models/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MetaRepository {

Future<List<Meta>> listarMetas() async {
    final supabase = Supabase.instance.client;
    final data =
        await supabase.from('economias').select<List<Map<String, dynamic>>>();

    final metas = data.map((e) => Meta.fromMap(e)).toList();

    return metas;
  }


  Future cadastrarMetas(Meta metas)async {
    final supabase = Supabase.instance.client;


await supabase.from('economias').insert({
      'descricao': metas.descricao,
      'valor': metas.valor,
      'data_inicio': metas.dataInicio.toIso8601String(),
      'data_conclusao': metas.dataConclusao.toIso8601String(),
    });
}




  Future alterarMetas(Meta metas) async {
    final supabase = Supabase.instance.client;

    await supabase.from('economias').update({
      'descricao': metas.descricao,
      'valor': metas.valor,
      'data_inicio': metas.dataInicio.toIso8601String(),
      'data_conclusao': metas.dataConclusao.toIso8601String(),
    }).match({'id': metas.id});
  }

  Future excluirMetas(int id) async {
    final supabase = Supabase.instance.client;

    await supabase.from('economias').delete().match({'id': id});
  }

}