import 'package:yoreparo_app/states/states.dart';

class TranslationUtil {
  static String username(LanguageOption language) =>
      language.code == 'ES' ? 'Nombre y Apellido' : 'Name and Lastname';

  static String login(LanguageOption language) =>
      language.code == 'ES' ? 'Iniciar Sesión' : 'Login';

  static String signup(LanguageOption language) =>
      language.code == 'ES' ? 'Registrarme' : 'Sign Up';

  static String welcome(LanguageOption language) =>
      language.code == 'ES' ? 'Bienvenido' : 'Welcome';

  static String emailHint(LanguageOption language) =>
      language.code == 'ES' ? 'Correo Electrónico' : 'Email';

  static String passwordHint(LanguageOption language) =>
      language.code == 'ES' ? 'Contraseña' : 'Password';

  static String confirmPasswordHint(LanguageOption language) =>
      language.code == 'ES' ? 'Confirmar Contraseña' : 'Confirm Password';

  static String welcomeDescription(LanguageOption language) =>
      language.code == 'ES'
          ? '¿Quieres reparar tus artículos?'
          : 'Do you want repair things?';

  static String emailUseLogin(LanguageOption language) => language.code == 'ES'
      ? 'o usa tu cuenta de correo electrónico'
      : 'or use your email account';

  static String forgotPassword(LanguageOption language) =>
      language.code == 'ES' ? '¿Olvidaste tu contraseña?' : 'Forgot Password?';

  static String notHaveAccount(LanguageOption language) =>
      language.code == 'ES' ? '¿No tengo una cuenta?' : 'Not have an account?';

  static String alreadyHaveAccount(LanguageOption language) =>
      language.code == 'ES'
          ? '¿Ya tienes una cuenta?'
          : 'Already have an account?';

  static String spanish(LanguageOption language) =>
      language.code == 'ES' ? 'Español' : 'Spanish';

  static String english(LanguageOption language) =>
      language.code == 'ES' ? 'Ingles' : 'English';

  static String title(LanguageOption language) =>
      language.code == 'ES' ? 'Seleccione un idioma' : 'Choose your language';

  static String validatorEmailError(LanguageOption language) =>
      language.code == 'ES'
          ? 'Correo electrónico incorrecto'
          : 'What an email!';

  static String languageChangedMsg(LanguageOption language) =>
      language.code == 'ES'
          ? 'Idioma cambiado exitosamente'
          : 'Successfully changed the language';

  static String loginSuccessfullMsg(LanguageOption language) =>
      language.code == 'ES'
          ? 'Inicio de sesión exitoso con '
          : 'Successfully logged in with ';

  static String succesfull(LanguageOption language) =>
      language.code == 'ES' ? 'Exitoso.' : 'Successful.';

  static String validatorPasswordError(LanguageOption language) =>
      language.code == 'ES'
          ? 'Debe ser mayor o igual a 6 caracteres'
          : 'Must be longer than or equal to 6 characters';
  static String validatorNameError(LanguageOption language) =>
      language.code == 'ES'
          ? 'Debe ser mayor o igual a 2 caracteres'
          : 'Must be longer than or equal to 2 characters';
}
