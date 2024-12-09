import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_search_naver/ui/home/home_view_model.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  // 검색 함수
  void onSearch(String text) {
    // TODO 홈뷰모델의 searchLocations 메서드 호출
    if (text.isEmpty) {
      print('검색어를 입력해 주세요.');
      return;
    }
    print("onSearch called with $text");
    ref.read(homeViewModelProvider.notifier).searchLocations(text);
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeViewModelProvider);
    print("로케이션: $homeState.locations");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                onSearch(textEditingController.text);
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.transparent,
                child: Icon(Icons.search),
              ),
            )
          ],
          title: TextField(
            maxLines: 1,
            onSubmitted: onSearch,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "검색어를 입력해 주세요",
              border: MaterialStateOutlineInputBorder.resolveWith(
                (states) {
                  print("states: $states");
                  if (states.contains(WidgetState.focused)) {
                    return OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.orange));
                  }
                  return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey));
                },
              ),
            ),
          ),
        ),
        body: homeState.locations.isEmpty
            ? Center(child: Text('엥..'))
            : Text(
                homeState.locations
                    .map((e) => e.toJson().toString())
                    .join("\n\n"),
              ),
        // body: Text('hello')
        // body: ListView.builder(
        //   itemCount: homeState.locations.length,
        //   itemBuilder: (context, index) {
        //     final location = homeState.locations[index];
        //     return ListTile(
        //       title: Text(location.title),
        //       subtitle: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(location.category),
        //           Text(location.address),
        //         ],
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}
