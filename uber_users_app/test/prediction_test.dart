import 'package:flutter_test/flutter_test.dart';
import 'package:uber_users_app/models/prediction_model.dart';

void main() {
  group('PredictionModel Tests', () {
    test('fromJson correctly parses predictions', () {
      final json = {
        'place_id': 'abc123',
        'structured_formatting': {
          'main_text': 'Lahore',
          'secondary_text': 'Pakistan',
        },
      };

      final prediction = PredictionModel.fromJson(json);

      expect(prediction.place_id, 'abc123');
      expect(prediction.main_text, 'Lahore');
      expect(prediction.secondary_text, 'Pakistan');
    });
  });
}
