class Unit {
  final String name;
  final String? depth;
  final String? consumptionSolution;

  const Unit({
    required this.name,
    required this.depth,
    required this.consumptionSolution,
  });


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
