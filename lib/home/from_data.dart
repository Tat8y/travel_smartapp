import 'package:faker/faker.dart';

class FromData {
  static final faker = Faker();

  static final List<String> fromDestination =
      List.generate(20, (index) => faker.address.city());

  static List<String> getSuggestions(String query) =>
      List.of(fromDestination).where((city) {
        final cityLower = city.toLowerCase();
        final queryLower = query.toLowerCase();

        return cityLower.contains(queryLower);
      }).toList();
}
