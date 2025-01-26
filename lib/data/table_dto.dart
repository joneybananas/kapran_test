import 'dart:convert';

class PriceData {
  final Map<String, Map<String, dynamic>> genealogy;
  final Map<String, Map<String, dynamic>> genetics;
  final Map<String, Map<String, dynamic>> premium;
  final Map<String, Map<String, dynamic>> diagnostic;

  PriceData({
    required this.genealogy,
    required this.genetics,
    required this.premium,
    required this.diagnostic,
  });

  factory PriceData.fromJson(Map<String, dynamic> json) {
    return PriceData(
      genealogy: Map<String, Map<String, dynamic>>.from(json['genealogy']),
      genetics: Map<String, Map<String, dynamic>>.from(json['genetics']),
      premium: Map<String, Map<String, dynamic>>.from(json['premium']),
      diagnostic: Map<String, Map<String, dynamic>>.from(json['diagnostic']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'genealogy': genealogy,
      'genetics': genetics,
      'premium': premium,
      'diagnostic': diagnostic,
    };
  }
}
