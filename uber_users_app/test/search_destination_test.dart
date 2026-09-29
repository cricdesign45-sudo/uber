import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';
import 'package:uber_users_app/models/prediction_model.dart';

void main() {
  group('CommonMethods & Models Tests', () {
    test('shortenAddress formats long addresses correctly', () {
      String fullAddress = "123 Main St, Sector F-8, Islamabad, Pakistan";
      String shortened = CommonMethods.shortenAddress(fullAddress);
      expect(shortened, equals("123 Main St, Sector F-8"));
    });

    test('PredictionModel.fromJson parses JSON correctly', () {
      Map<String, dynamic> json = {
        "place_id": "12345",
        "structured_formatting": {
          "main_text": "Islamabad",
          "secondary_text": "Pakistan"
        }
      };
      PredictionModel model = PredictionModel.fromJson(json);
      expect(model.place_id, equals("12345"));
      expect(model.main_text, equals("Islamabad"));
      expect(model.secondary_text, equals("Pakistan"));
    });
  });
}
