class Sala {

  final String nome;
  final int capacidade;
  final String linkFoto;
  final List agendamentos;

  Sala({
    required this.capacidade, 
    required this.nome,
    required this.linkFoto,
    required this.agendamentos,
  });

  Map<String, dynamic> toMap() {
    return {
      'capacidade': capacidade,
      'nome': nome,
      'linkFoto': linkFoto,
      'agendamentos': agendamentos.map((a) => a.toMap()).toList(),
    };
  }
}