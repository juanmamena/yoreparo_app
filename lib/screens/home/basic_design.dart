import 'package:yoreparo_app/screens/screens.dart';

class BasicDesignScreen extends StatelessWidget {
  const BasicDesignScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Image(image: AssetImage('assets/images/landscape.jpg')),
        const TitleBasic(),
        const ButtonSection(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Text(
              'Aute fugiat exercitation enim elit ex quis aliqua officia aliqua deserunt irure eu. Magna minim proident Lorem in et nisi sint cillum eiusmod voluptate adipisicing qui. Cillum esse non quis fugiat. Esse cupidatat ullamco deserunt pariatur id duis. Ad est incididunt cillum aute commodo fugiat dolor non.'),
        )
      ],
    ));
  }
}
