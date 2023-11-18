class Unit {
  const Unit({
    required this.name,
    required this.depth,
    required this.consumptionSolution,
  });

  final String name;

  final String? depth;

  final String? consumptionSolution;

  static const empty = Unit(
    name: '	Horsh Pronto NT12 #1',
    depth: null,
    consumptionSolution: null,
  );

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'depth': depth,
      'consumptionSolution': consumptionSolution,
    };
  }

  List<Object?> get props => [
        name,
        depth,
        consumptionSolution,
      ];
}
