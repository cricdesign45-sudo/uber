import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/methods/common_methods.dart';
import 'package:uber_users_app/models/prediction_model.dart';

void main() {
  group('Search & Prediction Unit Tests', () {
    test('PredictionModel.fromJson parses Google Places API JSON correctly', () {
      final json = {
        'place_id': 'place_123',
        'structured_formatting': {
          'main_text': 'Main Street',
          'secondary_text': 'City Center',
        },
      };

      final prediction = PredictionModel.fromJson(json);

      expect(prediction.place_id, 'place_123');
      expect(prediction.main_text, 'Main Street');
      expect(prediction.secondary_text, 'City Center');
    });

    test('shortenAddress extracts first two address parts', () {
      final address = '123 Main St, Downtown, Metropolis, Country';
      final shortened = CommonMethods.shortenAddress(address);

      expect(shortened, '123 Main St, Downtown');
    });

    test('formatTime formats minutes correctly into hours and minutes', () {
      final commonMethods = CommonMethods();

      expect(commonMethods.formatTime(45), '45 mins');
      expect(commonMethods.formatTime(125), '2 hours 5 mins');
    });
  });
}
