class Meta {
  final int id;
  final String descricao;
  final double valor;
  final DateTime dataInicio;
  final DateTime dataConclusao;

  Meta({
    required this.id,
    required this.descricao,
    required this.valor,
    required this.dataInicio,
    required this.dataConclusao,
  });

factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
      id: map['id'] as int,
      descricao: map['descricao'] as String,
      valor: (map['valor'] as num).toDouble(),
      dataInicio: DateTime.parse(map['data_inicio'] as String),
      dataConclusao: DateTime.parse(map['data_conclusao'] as String),
    );
  }

}


