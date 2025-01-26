import 'package:flutter/material.dart';
import 'package:kapran_test/api/api_service.dart';
import 'package:kapran_test/data/table_dto.dart';
import 'package:kapran_test/data_table_widget.dart';

class PriceDataWidget extends StatefulWidget {
  // final ApiService apiService;

  const PriceDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  _PriceDataWidgetState createState() => _PriceDataWidgetState();
}

class _PriceDataWidgetState extends State<PriceDataWidget> {
  late ApiService apiService;
  late Future<PriceData> futurePriceData;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: 'https://back.genotek.ru/api/price/');
    futurePriceData = apiService.fetchPriceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kapran_test'),
      ),
      body: FutureBuilder<PriceData>(
        future: futurePriceData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final priceData = snapshot.data!;
            return DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'Genealogy'),
                      Tab(text: 'Genetics'),
                      Tab(text: 'Premium'),
                      Tab(text: 'Diagnostic'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        DataTableWidget(
                          data: priceData.genealogy,
                          key: ObjectKey(priceData.genealogy),
                        ),
                        DataTableWidget(
                          data: priceData.genetics,
                          key: ObjectKey(priceData.genetics),
                        ),
                        DataTableWidget(
                          data: priceData.premium,
                          key: ObjectKey(priceData.premium),
                        ),
                        DataTableWidget(
                          data: priceData.diagnostic,
                          key: ObjectKey(priceData.diagnostic),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
