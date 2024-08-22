import 'package:yoreparo_app/widgets/widgets.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [CustomBackground(), _HomeBody()],
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Column(
      children: [PageTitle(), CardTable()],
    ));
  }
}
