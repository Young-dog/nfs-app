enum RoleUser {
  machineOperator,
  agronomist,
  dispatcher;

  String toText() {
    switch(this) {
      case RoleUser.machineOperator:
        return 'Механизатор';
      case RoleUser.agronomist:
        return 'Агроном';
      case RoleUser.dispatcher:
        return 'Диспетчер';
    }
  }
}