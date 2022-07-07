class Clube {
  final int id;
  final String nome;
  final String abreviacao;
  final String utlEscudo;
  Clube(this.id, this.nome, this.abreviacao, this.utlEscudo);

  @override
  String toString() {
    return 'Clube{id: $id, nome: $nome, abreviacao: $abreviacao, utlEscudo: $utlEscudo}';
  }
}

