import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_search_naver/ui/home/home_view_model.dart';

void main() {
  test('HomeViewModel test', () async {
    // 앱 내에서는 ProviderScope 안에서 뷰모델 관리
    // 테스트 환경에서 Widget을 생성하지 않고 테스트 할 수 있게 ProviderContainer 제공
    final providerContainer = ProviderContainer();
    addTearDown(providerContainer.dispose);
    final homeVm = providerContainer.read(homeViewModelProvider.notifier);

    // 처음 HomeViewModel 상태 => 처음에는 빈 리스트
    final firstState = providerContainer.read(homeViewModelProvider);
    expect(firstState.locations.isEmpty, true);

    // HomeViewModel에서 searchLocation 메서드 호출 후 상태 변경이 정상적으로 되는지 테스트.
    await homeVm.searchLocations('방이');
    final afterState = providerContainer.read(homeViewModelProvider);
    expect(afterState.locations.isEmpty, false);

    afterState.locations.forEach(
      (element) {
        print(element.toJson());
      },
    );
  });
}
