import 'package:yoreparo_app/widgets/widgets.dart';

class TitleBasic extends StatelessWidget {
  const TitleBasic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TITULO',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Subtitulo', style: TextStyle(color: Colors.black45))
            ],
          ),
          Expanded(child: Container()),
          const Icon(Icons.star, color: Colors.red),
          const Text('41')
        ],
      ),
    );
  }
}
