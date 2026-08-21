import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/models/prediction_model.dart';

void main() {
  test('PredictionModel.fromJson parses JSON correctly', () {
    final json = {
      "place_id": "12345",
      "structured_formatting": {
        "main_text": "Main Street",
        "secondary_text": "City, Country"
      }
    };

    final prediction = PredictionModel.fromJson(json);

    expect(prediction.place_id, "12345");
    expect(prediction.main_text, "Main Street");
    expect(prediction.secondary_text, "City, Country");
  });
}
