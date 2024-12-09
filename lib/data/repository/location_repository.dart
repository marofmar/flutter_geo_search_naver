import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geo_search_naver/data/model/location.dart';
import 'package:http/http.dart' as http;

class LocationRepository {
  Future<List<Location>> searchLocation(String query) async {
    print('location repo: ID ${dotenv.env['ID']}');
    try {
      final response = await http.get(
        Uri.parse(
            'https://openapi.naver.com/v1/search/local.json?query=$query&display=5'),
        headers: {
          'X-Naver-Client-Id': dotenv.env['ID'] ?? '',
          'X-Naver-Client-Secret': dotenv.env['SECRET'] ?? '', // 값이 없을 경우를 대비
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        final items = List.from(map['items']);
        final iterable = items.map((e) {
          return Location.fromJson(e);
        });

        final list = iterable.toList();
        return list;
      } else {
        print('에러: ${response.statusCode} ${response.body}');
        return [];
      }
    } catch (e) {
      print('에러 발생: ${e}');
      return [];
    }
  }
}
