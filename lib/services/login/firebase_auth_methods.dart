import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yoreparo_app/services/services.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);
  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

// EMAIL SIGN UP
  Future<String> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String message;
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      message = await sendEmailVerification(context, 'SNGOK');
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        message = 'Password no cumple con la politica.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Ya existe un usuario registrado con este correo electrónico';
      } else {
        message = e.message!; // Displaying the usual firebase error message
      }
    }
    return message;
  }

  // EMAIL VERIFICATION
  Future<String> sendEmailVerification(
      BuildContext context, String verificationMessage) async {
    String message;
    try {
      _auth.currentUser!.sendEmailVerification();
      message = verificationMessage;
    } on FirebaseAuthException catch (e) {
      message = e.message!; // Display error message
    }
    return message;
  }

  // EMAIL LOGIN
  Future<String> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String message;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!user.emailVerified) {
        message = await sendEmailVerification(context, 'ER001');
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      } else {
        message = 'ER002';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        message = 'Correo electrónico o contraseña invalidos';
      } else if (e.code == 'invalid-email') {
        message = 'Correo electrónico o contraseña invalidos';
      } else if (e.code == 'user-disabled') {
        message = 'Su usuario ha sido deshabilitado temporalmente';
      } else if (e.code == 'user-not-found') {
        message = 'Usuario no registrado';
      } else {
        message = e.message!; // Displaying the usual firebase error message
      }
    }
    return message;
  }

  // GOOGLE SIGN IN
  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    UserCredential? userCredential;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        userCredential = await _auth.signInWithCredential(credential);

        // if you want to do specific task like storing information in firestore
        // only for new users using google sign in (since there are no two options
        // for google sign in and google sign up, only one as of now),
        // do the following:

        // if (userCredential.user != null) {
        //   if (userCredential.additionalUserInfo!.isNewUser) {}
        // }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message!); // Displaying the error message
    }
    return userCredential!;
  }

// FACEBOOK SIGN IN
  Future<UserCredential> signInWithFacebook(BuildContext context) async {
    UserCredential? userCredential;
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      userCredential = await _auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      print(e.message!); // Displaying the error message
    }
    return userCredential!;
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message!); // Displaying the error message
    }
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print(e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}
