import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geo_search_naver/data/model/location.dart';
import 'package:http/http.dart' as http;

class LocationRepository {
  final Dio dio;
  LocationRepository() : dio = Dio() {
    dio.options = BaseOptions(
      baseUrl: 'https://openapi.naver.com/v1/search/local.json',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'X-Naver-Client-Id': dotenv.env['ID'] ?? '',
        'X-Naver-Client-Secret': dotenv.env['SECRET'] ?? '', // 값이 없을 경우를 대비
      },
    );
  }
  Future<List<Location>> searchLocation(String query) async {
    print('location repo: ID ${dotenv.env['ID']}');
    try {
      final response = await dio.get(
        '',
        queryParameters: {
          'query': query,
          'display': 5,
        },
      );
      if (response.statusCode == 200) {
        print('api request 200');
        final items = List.from(response.data['items']); // 5개 아이템들
        final locations = items.map((e) => Location.fromJson(e)).toList();
        return locations;
      } else {
        print('에러: ${response.statusCode} ${response.statusMessage}');
        return [];
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        return [];
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
        return [];
      }
    }
  }
}
