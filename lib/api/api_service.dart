import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:kapran_test/data/table_dto.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<PriceData> fetchPriceData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return PriceData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load price data');
    }
  }
}
