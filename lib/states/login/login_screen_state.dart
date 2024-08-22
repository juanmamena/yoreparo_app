import 'package:yoreparo_app/states/states.dart';

class LoginScreenState extends State<HomeScreen> {
  /// Example selected language, default is English.
  LanguageOption language = const LanguageOption(value: 'Spanish', code: 'ES');

  /// Current auth mode, default is [AuthMode.login].
  AuthMode currentMode = AuthMode.login;

  CancelableOperation? _operation;

  UserService? userService;

  @override
  void initState() {
    language = _languageOptions[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userService = Provider.of<UserService>(context);
    return AnimatedLogin(
      onLogin: (LoginData data) async =>
          _authOperation(LoginFunctions(context).onLogin(data)),
      onSignup: (SignUpData data) async =>
          _authOperation(LoginFunctions(context).onSignup(data, userService!)),
      onForgotPassword: _onForgotPassword,
      logo: Image.asset('assets/images/Fondo1.png'),
      backgroundImage: 'assets/images/background_image.jpg',
      signUpMode: SignUpModes.both,
      socialLogins: _socialLogins(context),
      loginMobileTheme: _mobileTheme,
      loginTexts: _loginTexts,
      emailValidator: ValidatorModel(
          validatorCallback: (String? email) =>
              '${TranslationUtil.validatorEmailError(language)} $email'),
      passwordValidator: ValidatorModel(
          validatorCallback: (String? password) =>
              '${TranslationUtil.validatorPasswordError(language)} $password'),
      nameValidator: ValidatorModel(
          validatorCallback: (String? name) =>
              '${TranslationUtil.validatorNameError(language)} $name'),
      changeLanguageCallback: (LanguageOption? _language) {
        if (_language != null) {
          DialogBuilder(context)
              .showResultDialog(TranslationUtil.languageChangedMsg(_language));
          if (mounted) setState(() => language = _language);
        }
      },
      changeLangDefaultOnPressed: () async => _operation?.cancel(),
      languageOptions: _languageOptions,
      selectedLanguage: language,
      initialMode: currentMode,
      onAuthModeChange: (AuthMode newMode) async {
        currentMode = newMode;
        await _operation?.cancel();
      },
    );
  }

  Future<String?> _authOperation(Future<String?> func) async {
    final dialogBuilder = DialogBuilder(context);
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(func);
    final String? res = await _operation?.valueOrCancellation();
    if (_operation?.isCompleted == true) {
      dialogBuilder
          .showResultDialog(res ?? TranslationUtil.succesfull(language));
    }
    return res;
  }

  Future<String?> _onForgotPassword(String email) async {
    final loginFunctions = LoginFunctions(context);
    await _operation?.cancel();
    return await loginFunctions.onForgotPassword(email);
  }

  List<LanguageOption> get _languageOptions => <LanguageOption>[
        LanguageOption(
          value: TranslationUtil.spanish(language),
          code: 'ES',
          iconPath: 'assets/images/ec.png',
        ),
        LanguageOption(
          value: TranslationUtil.english(language),
          code: 'EN',
          iconPath: 'assets/images/en.png',
        ),
      ];

  /// You can adjust the colors, text styles, button styles, borders
  /// according to your design preferences for *MOBILE* view.
  /// You can also set some additional display options such as [showLabelTexts].
  LoginViewTheme get _mobileTheme => LoginViewTheme(
        // showLabelTexts: false,
        backgroundColor: Colors.blue[900], // const Color(0xFF6666FF),
        formFieldBackgroundColor: Colors.white,
        formWidthRatio: 60,
        actionButtonStyle: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.blue[900]),
        ),
        animatedComponentOrder: const <AnimatedComponent>[
          AnimatedComponent(
            component: LoginComponents.logo,
            animationType: AnimationType.right,
          ),
          AnimatedComponent(component: LoginComponents.description),
          AnimatedComponent(component: LoginComponents.formTitle),
          AnimatedComponent(component: LoginComponents.socialLogins),
          AnimatedComponent(component: LoginComponents.useEmail),
          AnimatedComponent(component: LoginComponents.form),
          AnimatedComponent(component: LoginComponents.notHaveAnAccount),
          AnimatedComponent(component: LoginComponents.forgotPassword),
          AnimatedComponent(component: LoginComponents.changeActionButton),
          AnimatedComponent(component: LoginComponents.actionButton),
        ],
        privacyPolicyStyle: const TextStyle(color: Colors.white70),
        privacyPolicyLinkStyle: const TextStyle(
            color: Colors.white, decoration: TextDecoration.underline),
        changeLangButtonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue[800]),
        ),
        errorBorderColor: Colors.redAccent[700],
        focusedErrorBorderColor: Colors.redAccent[200],
        errorTextStyle: TextStyle(
            color: Colors.red[400], fontSize: 12, fontWeight: FontWeight.bold),
      );

  LoginTexts get _loginTexts => LoginTexts(
      nameHint: TranslationUtil.username(language),
      login: TranslationUtil.login(language),
      signUp: TranslationUtil.signup(language),
      welcomeBack: TranslationUtil.welcome(language),
      loginEmailHint: TranslationUtil.emailHint(language),
      loginPasswordHint: TranslationUtil.passwordHint(language),
      welcomeBackDescription: TranslationUtil.welcomeDescription(language),
      loginUseEmail: TranslationUtil.emailUseLogin(language),
      forgotPassword: TranslationUtil.forgotPassword(language),
      notHaveAnAccount: TranslationUtil.notHaveAccount(language),
      signupEmailHint: TranslationUtil.emailHint(language),
      signupPasswordHint: TranslationUtil.passwordHint(language),
      signUpUseEmail: TranslationUtil.emailUseLogin(language),
      alreadyHaveAnAccount: TranslationUtil.alreadyHaveAccount(language),
      confirmPasswordHint: TranslationUtil.confirmPasswordHint(language));

  /// Social login options, you should provide callback function and icon path.
  /// Icon paths should be the full path in the assets
  /// Don't forget to also add the icon folder to the "pubspec.yaml" file.
  List<SocialLogin> _socialLogins(BuildContext context) => <SocialLogin>[
        SocialLogin(
            callback: () async => _socialCallback('Google'),
            iconPath: 'assets/images/google.png'),
        SocialLogin(
            callback: () async => _socialCallback('Facebook'),
            iconPath: 'assets/images/facebook.png'),
      ];

  Future<String?> _socialCallback(String type) async {
    final loginFunctions = LoginFunctions(context);
    await _operation?.cancel();
    _operation = CancelableOperation.fromFuture(
        loginFunctions.socialLogin(type, userService!));
    final String? res = await _operation?.valueOrCancellation();

    return res;
  }
}
