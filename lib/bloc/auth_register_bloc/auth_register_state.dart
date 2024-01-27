part of 'auth_register_bloc.dart';

@immutable
abstract class AuthRegisterState {}

class AuthRegisterInitial extends AuthRegisterState {}

class AuthRegisterLoadingState extends AuthRegisterState {}

class AuthRegisterSuccessState extends AuthRegisterState {
  final String message;
  final String accessToken;

  AuthRegisterSuccessState({required this.message, required this.accessToken});
}

class AuthRegisterErrorState extends AuthRegisterState {
  final String errorMessage;

  AuthRegisterErrorState({required this.errorMessage});
}
