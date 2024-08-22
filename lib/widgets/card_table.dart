import 'dart:ui';

import 'package:yoreparo_app/models/home/categories_response_model.dart';
import 'package:yoreparo_app/services/home/category_service.dart';
import 'package:yoreparo_app/widgets/widgets.dart';
import 'dart:convert';
import 'dart:typed_data';

class CardTable extends StatelessWidget {
  const CardTable({super.key});
  @override
  Widget build(BuildContext context) {
    CategoryService categoryService = Provider.of<CategoryService>(context);
    return FutureBuilder(
      future: categoryService.getCategories(),
      builder:
          (BuildContext context, AsyncSnapshot<CategoriesResponse> snapshot) {
        if (snapshot.hasData) {
          return Table(
            children: [
              //for (var item in snapshot.data!.categories)
              for (int i = 0; i < snapshot.data!.categories.length; i = i + 2)
                TableRow(children: [
                  TableCell(
                    child: _SingleCard(
                        color: Colors.white,
                        icon:
                            AssetImage(snapshot.data!.categories[i].imageIcon),
                        text: snapshot.data!.categories[i].description,
                        categoryId: snapshot.data!.categories[i].id),
                  ),
                  TableCell(
                    child: (i + 1) > (snapshot.data!.categories.length - 1)
                        ? Container()
                        : _SingleCard(
                            color: Colors.white,
                            icon: AssetImage(
                                snapshot.data!.categories[i + 1].imageIcon),
                            text: snapshot.data!.categories[i + 1].description,
                            categoryId: snapshot.data!.categories[i + 1].id),
                  ),
                ])
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class _SingleCard extends StatelessWidget {
  final ImageProvider icon;
  final Color color;
  final String text;
  final int categoryId;

  const _SingleCard(
      {Key? key,
      required this.icon,
      required this.color,
      required this.text,
      required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Selected category: $categoryId");
      },
      child: _CardBackground(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Image(image: icon),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;

  const _CardBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
                color: Color.fromRGBO(65, 161, 251, 0.424),
                borderRadius: BorderRadius.circular(20)),
            child: child,
          ),
        ),
      ),
    );
  }
}
