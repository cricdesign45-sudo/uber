import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/models/prediction_model.dart';

void main() {
  group('PredictionModel Test', () {
    test('fromJson correctly parses place prediction data', () {
      final json = {
        'place_id': 'place_123',
        'structured_formatting': {
          'main_text': 'Main Street',
          'secondary_text': 'City, Country',
        },
      };

      final prediction = PredictionModel.fromJson(json);

      expect(prediction.place_id, equals('place_123'));
      expect(prediction.main_text, equals('Main Street'));
      expect(prediction.secondary_text, equals('City, Country'));
    });
  });
}
