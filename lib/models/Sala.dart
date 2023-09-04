class Sala {

  final String nomeSala;
  final bool isLivre;
  final int capacidade;
  final List<List<DateTime>> agendamentos; //Array de datas - incial e final 

  Sala({
    required this.isLivre, 
    required this.capacidade, 
    required this.nomeSala,
    required this.agendamentos,
  });
}