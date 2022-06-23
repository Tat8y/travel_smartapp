import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_smartapp/domain/authentication/auth_exceptions.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw SignInErrorException();
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw SignUpErrorException();
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get user => _firebaseAuth.authStateChanges();
}
