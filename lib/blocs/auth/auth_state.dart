import 'package:equatable/equatable.dart';

class AuthUser {
  final String uid;
  final String name;
  final String email;
  final String photoUrl;

  AuthUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
  });
}

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  final AuthUser user;

  Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
