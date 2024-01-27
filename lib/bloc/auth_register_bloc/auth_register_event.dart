part of 'auth_register_bloc.dart';

@immutable
abstract class AuthRegisterEvent {}

class SignUpButtonPressedEvent extends AuthRegisterEvent {
  final String name;
  final String lastName;
  final String phone;
  final String password;
  final String confirmPassword;

  SignUpButtonPressedEvent({required this.name, required this.lastName, required this.phone, required this.password, required this.confirmPassword});
}
