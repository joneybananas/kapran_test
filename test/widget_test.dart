import 'package:flutter_test/flutter_test.dart';
import 'package:kapran_test/api/api_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kapran_test/data/table_dto.dart';

@GenerateMocks([http.Client])
import 'widget_test.mocks.dart';

void main() {
  group('ApiService', () {
    late MockClient mockClient;
    late ApiService apiService;

    setUp(() {
      mockClient = MockClient();
      apiService =
          ApiService(baseUrl: 'https://example.com', client: mockClient);
    });

    test('fetchPriceData returns PriceData on success', () async {
      // Подготавливаем мок-ответ
      final mockResponse = {
        'genealogy': {
          'item1': {'key': 'value1'},
          'item2': {'key': 'value2'},
        },
        'genetics': {
          'item3': {'key': 'value3'},
        },
        'premium': {
          'item4': {'key': 'value4'},
        },
        'diagnostic': {
          'item5': {'key': 'value5'},
        },
      };

      when(mockClient.get(Uri.parse('https://example.com'))).thenAnswer(
          (_) async => http.Response(jsonEncode(mockResponse), 200));

      // Выполняем тестируемый метод
      final priceData = await apiService.fetchPriceData();

      // Проверяем результат
      expect(priceData.genealogy['item1']?['key'], equals('value1'));
      expect(priceData.genetics['item3']?['key'], equals('value3'));
      expect(priceData.premium['item4']?['key'], equals('value4'));
      expect(priceData.diagnostic['item5']?['key'], equals('value5'));
    });

    test('fetchPriceData throws an exception on error', () async {
      when(mockClient.get(Uri.parse('https://example.com')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(apiService.fetchPriceData(), throwsException);
    });
  });
}
