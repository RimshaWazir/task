abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {}

class SignUpError extends SignUpState {
  final String? error;

  SignUpError({this.error});
}
