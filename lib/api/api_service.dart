import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kapran_test/data/table_dto.dart';

class ApiService {
  final String baseUrl;
  final http.Client client;

  ApiService({required this.baseUrl, http.Client? client})
      : client = client ?? http.Client();

  Future<PriceData> fetchPriceData() async {
    final response = await client.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return PriceData.fromJson(jsonData);
    } else {
      throw Exception('Failed to load price data');
    }
  }
}
