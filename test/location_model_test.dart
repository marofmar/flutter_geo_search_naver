import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_search_naver/data/model/location.dart';

void main() {
  setUpAll(() async {
    await dotenv.load(
        fileName: "/Users/yujinchung/Projects/geo_search_naver/.env");
  });
  test('location model test', () {
    String dummyData = """
    {
      "title": "이월로스터스 송파점",
      "category": "카페,디저트>카페",
      "address": "서울특별시 송파구 송파동 51-7"
    }
    """;

    // 1. 맵으로 변환
    Map<String, dynamic> map = jsonDecode(dummyData);
    // 2. 객체로 변환
    Location location = Location.fromJson(map);
    expect(location.address, "서울특별시 송파구 송파동 51-7");
    print(location.toJson());
  });
}
