import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<SignInWithGoogle>(_onSignInWithGoogle);
  }

  Future<void> _onCheckLoginStatus(
    CheckLoginStatus event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // First try to silently restore Google session
      final googleUser = await GoogleSignIn().signInSilently();
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        print("✅ Firebase session restored: ${firebaseUser.email}");
        emit(
          Authenticated(
            AuthUser(
              uid: firebaseUser.uid,
              name: firebaseUser.displayName ?? '',
              email: firebaseUser.email ?? '',
              photoUrl: firebaseUser.photoURL ?? '',
            ),
          ),
        );
      } else if (googleUser != null) {
        print("🔁 Restoring session from Google Sign-In...");
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final userCredential = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );
        final user = userCredential.user;

        if (user != null) {
          emit(
            Authenticated(
              AuthUser(
                uid: user.uid,
                name: user.displayName ?? '',
                email: user.email ?? '',
                photoUrl: user.photoURL ?? '',
              ),
            ),
          );
          return;
        }
      }

      emit(Unauthenticated());
    } catch (e) {
      print("🔥 Error in CheckLoginStatus: $e");
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(Authenticating());

      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(Unauthenticated());
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;

      if (user != null) {
        final userDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid);
        final exists = await userDoc.get();

        if (!exists.exists) {
          await userDoc.set({
            'name': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        emit(
          Authenticated(
            AuthUser(
              uid: user.uid,
              name: user.displayName ?? '',
              email: user.email ?? '',
              photoUrl: user.photoURL ?? '',
            ),
          ),
        );
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      print("🔥 Sign-in error: $e");
      emit(AuthError(e.toString()));
    }
  }
}
