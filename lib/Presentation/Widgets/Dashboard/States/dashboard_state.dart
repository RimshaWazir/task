import '../../../../Data/DataSource/Resources/imports.dart';

abstract class DashboardCubitState {}

class DashboardCubitInitial extends DashboardCubitState {}

class DashboardCubitLoaded extends DashboardCubitState {
  List<ChatUser> user;
  DashboardCubitLoaded({required this.user});
}

class DashboardCubitError extends DashboardCubitState {
  String errorMessage;
  DashboardCubitError({required this.errorMessage});
}