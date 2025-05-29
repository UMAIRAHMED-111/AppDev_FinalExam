import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInWithGoogle extends AuthEvent {}

class CheckLoginStatus extends AuthEvent {}
