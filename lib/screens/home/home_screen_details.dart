import 'package:yoreparo_app/screens/home/map_screen.dart';
import 'package:yoreparo_app/screens/screens.dart';

import '../../services/login/firebase_auth_methods.dart';

class HomeScreenDetails extends StatelessWidget {
  const HomeScreenDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 13, 72, 160),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/Fondo1.png',
              fit: BoxFit.contain,
              height: 50,
            )
          ],
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.person_outline_rounded,
              color: Colors.white,
              size: 40,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
                    .copyWith(topRight: const Radius.circular(0))),
            padding: const EdgeInsets.all(10),
            elevation: 10,
            color: Color.fromARGB(138, 13, 72, 160),
            onSelected: (value) {
              final navigator = Navigator.of(context);
              if (value == 'Sign out') {
                context.read<FirebaseAuthMethods>().signOut(context);
                navigator.pop();
                navigator.pushNamed('home');
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                    padding: EdgeInsets.only(right: 25, left: 20),
                    value: 'Sign out',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Cerrar sesión',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Divider()
                      ],
                    )),
              ];
            },
          )
        ],
      ),
      body: const _ScreenSelection(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _ScreenSelection extends StatelessWidget {
  const _ScreenSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    return PageView(
      controller: uiProvider.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        const MapScreen(),
        const HomeSection(),
        ScrollScreen()
      ],
    );
  }
}
