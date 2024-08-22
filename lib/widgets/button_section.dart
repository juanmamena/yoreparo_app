import 'package:yoreparo_app/widgets/widgets.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(icon: Icons.call, text: 'Call'),
          CustomButton(icon: Icons.near_me_rounded, text: 'Route'),
          CustomButton(icon: Icons.share, text: 'Share')
        ],
      ),
    );
  }
}
