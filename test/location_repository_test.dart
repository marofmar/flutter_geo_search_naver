import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_search_naver/data/repository/location_repository.dart';

void main() {
  setUpAll(() async {
    await dotenv.load(
        fileName: "/Users/yujinchung/Projects/geo_search_naver/.env");
  });
  test('location repository test', () async {
    LocationRepository locationRepository = LocationRepository();
    final locations = await locationRepository.searchLocation('samsung');
    expect(locations.isEmpty, false);
    for (var location in locations) {
      print(location.toJson());
    }
  });
}
