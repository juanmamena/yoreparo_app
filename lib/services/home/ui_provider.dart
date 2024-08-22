import 'package:yoreparo_app/services/services.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;
  PageController _pageController = new PageController();
  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  set selectedMenuOpt(int i) {
    _selectedMenuOpt = i;
    _pageController.animateToPage(i,
        duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
