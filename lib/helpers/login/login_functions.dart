import 'package:provider/provider.dart';
import 'package:yoreparo_app/helpers/helpers.dart';

class LoginFunctions {
  /// Collection of functions will be performed on login/signup.
  /// * e.g. [onLogin], [onSignup], [socialLogin], and [onForgotPassword]
  const LoginFunctions(this.context);
  final BuildContext context;

  /// Login action that will be performed on click to action button in login mode.
  Future<String?> onLogin(LoginData loginData) async {
    String message, firebaseResponse;
    final navigator = Navigator.of(context);
    //UserResponse userResponse = await userService.getUser(loginData.email);
    firebaseResponse = await loginFireBaseUser(loginData);
    if (firebaseResponse == 'ER001') {
      message =
          'Tu usuario aún no ha sido verificado, te enviaremos un nuevo correo de verificación';
    } else if (firebaseResponse == 'ER002') {
      message = 'Bienvenido';
      navigator.pop();
      navigator.pushNamed('details');
    } else {
      message = firebaseResponse;
    }

    return message;
  }

  /// Sign up action that will be performed on click to action button in sign up mode.
  Future<String?> onSignup(
      SignUpData signupData, UserService userService) async {
    String message, firebaseResponse;

    final navigator = Navigator.of(context);
    if (signupData.password != signupData.confirmPassword) {
      return 'Las contraseñas ingresadas no coinciden.';
    } else {
      firebaseResponse = await signFirebaseUser(signupData);
      if (firebaseResponse == 'SNGOK') {
        await userService.registerUser(
            UserRequest(fullName: signupData.name, email: signupData.email));
        message =
            'Se ha enviado un correo de verificaion para activar tu usuario';
        navigator.pop();
        navigator.pushNamed('home');
      } else {
        message = firebaseResponse;
      }
    }
    return message;
  }

  /// Social login callback example.
  Future<String?> socialLogin(String type, UserService userService) async {
    String message;
    final navigator = Navigator.of(context);
    if (type == 'Google') {
      UserCredential credential =
          await context.read<FirebaseAuthMethods>().signInWithGoogle(context);
      await userService.registerUser(UserRequest(
          fullName: credential.user!.displayName!,
          email: credential.user!.email!));
      message = 'Inicio de sesion exitoso con Google';
      navigator.pop();
      navigator.pushNamed('details');
    } else if (type == 'Facebook') {
      UserCredential credential =
          await context.read<FirebaseAuthMethods>().signInWithFacebook(context);
      await userService.registerUser(UserRequest(
          fullName: credential.user!.displayName!,
          email: credential.user!.email!));
      message = 'Inicio de sesion exitoso con Facebook';
      navigator.pop();
      navigator.pushNamed('details');
    } else {
      message = 'Succesfull';
    }
    return message;
  }

  /// Action that will be performed on click to "Forgot Password?" text/CTA.
  /// Probably you will navigate user to a page to create a new password after the verification.
  Future<String?> onForgotPassword(String email) async {
    final navigator = Navigator.of(context);
    DialogBuilder(context).showLoadingDialog();
    await Future.delayed(const Duration(seconds: 2));
    navigator.pop();
    navigator.pushNamed('forgotPass');
    return null;
  }

  Future<String> signFirebaseUser(SignUpData signupData) async {
    return await context.read<FirebaseAuthMethods>().signUpWithEmail(
        email: signupData.email,
        password: signupData.password,
        context: context);
  }

  Future<String> loginFireBaseUser(LoginData loginData) async {
    return await context.read<FirebaseAuthMethods>().loginWithEmail(
        email: loginData.email, password: loginData.password, context: context);
  }
}
