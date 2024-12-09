import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_search_naver/data/model/location.dart';
import 'package:geo_search_naver/data/repository/location_repository.dart';

// 1. 상태 클래스 만들기
class HomeState {
  List<Location> locations;
  HomeState(this.locations);
}

// 2. 뷰모델 만들기 - Notifier 상속
class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState([]); // 빈 리스트 초기화
  }

  Future<void> searchLocations(String query) async {
    final locationRepository = LocationRepository();
    final locations = await locationRepository.searchLocation(query);
    state = HomeState(locations); // 상태 업데이트: 새로운 객체 만들어서 받은 값 할당
  }
}

// 3. 뷰모델 관리자 만들기 - NotifierProvider 객체
final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});
