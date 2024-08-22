import 'package:yoreparo_app/models/home/categories_response_model.dart';
import 'package:yoreparo_app/utils/utils.dart';
import 'package:http/http.dart' as http;

class CategoryService extends ChangeNotifier {
  //final String _baseUrl =
  //  'ms-users-app.greenfield-285b2ae8.westus.azurecontainerapps.io';
  final String _baseUrl = '127.0.0.1:8085';
  final String _apiPath = '/api/v1/category';

  CategoryService();

  Future<CategoriesResponse> getCategories() async {
    List<Category> listCategories = [];
    CategoriesResponse categoriesResponse =
        CategoriesResponse(categories: listCategories);

    var url = Uri.http(_baseUrl, _apiPath);
    final response = await http.get(url, headers: {"charset": "UTF-8"});
    if (response.statusCode == 200) {
      categoriesResponse = CategoriesResponse.fromRawJson(response.body);
    }
    return categoriesResponse;
  }
}
