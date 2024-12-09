import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_search_naver/ui/detail/detail_page.dart';
import 'package:geo_search_naver/ui/home/home_page.dart';

void main() async {
  try {
    await dotenv.load(
        fileName: "/Users/yujinchung/Projects/geo_search_naver/.env");
  } catch (e) {
    print('.env 로드 실패');
  }
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
