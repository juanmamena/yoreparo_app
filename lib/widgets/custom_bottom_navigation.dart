import 'package:yoreparo_app/widgets/widgets.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 13, 72, 160),
        unselectedItemColor: Color.fromARGB(255, 149, 151, 160),
        //showSelectedLabels: false,
        //showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: 'Mi Ubicación'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined), label: 'Categorías'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_repair_service), label: 'Servicios'),
        ]);
  }
}
