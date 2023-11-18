part of 'navigation_cubit.dart';

enum NavbarItem {
  home,
  tasks,
  issues,
  profile,
}

class NavigationState extends Equatable {
  final NavbarItem navbarItem;
  final int index;

  const NavigationState(
    this.navbarItem,
    this.index,
  );

  @override
  List<Object?> get props => [navbarItem, index];
}