class Sala {

  final String nome;
  final int capacidade;
  final List agendamentos;

  Sala({
    required this.capacidade, 
    required this.nome,
    required this.agendamentos,
  });

  Map<String, dynamic> toMap() {
    return {
      'capacidade': capacidade,
      'nome': nome,
      'agendamentos': agendamentos.map((a) => a.toMap()).toList(),
    };
  }
}