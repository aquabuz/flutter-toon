import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  Future<List<WebttonModel>> getTodaysToons() async {
    List<WebttonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> webttons = jsonDecode(response.body);
      for (var webtoon in webttons) {
        webtoonInstances.add(WebttonModel.fromJson(webtoon));
      }
      print(webtoonInstances);
      return webtoonInstances;
    }
    throw Error();
  }
}
