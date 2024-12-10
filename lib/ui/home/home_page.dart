import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_search_naver/ui/detail/detail_page.dart';
import 'package:geo_search_naver/ui/home/home_view_model.dart';
import 'package:html_unescape/html_unescape.dart';

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

  // HTML 태그 제거, HTML entity 중 '&amp' 처리하는 함수
  String processTitle(String text) {
    final unescape = HtmlUnescape(); // unescape.convert(text);
    final RegExp exp = RegExp(r'<[^>]*>');
    String woTags = text.replaceAll(exp, '');
    if (woTags.contains('&')) {
      return unescape.convert(woTags);
    } else {
      return text.replaceAll(exp, '');
    }
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
            ? Center(
                child: Text(
                '엥..텅,,! 비었어요.',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ))
            : Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: ListView.builder(
                  itemCount: homeState.locations.length,
                  itemBuilder: (context, index) {
                    final location = homeState.locations[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                        ),
                        child: ListTile(
                          title: Text(
                            processTitle(location.title),
                            style: TextStyle(fontSize: 18),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(location.category),
                              Text(location.address),
                            ],
                          ),
                          onTap: () {
                            if (location.link.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                        title: Text('유효하지 않은 링크'),
                                        content: Text('네이버로 이동합니다.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailPage(
                                                              url:
                                                                  "https://www.naver.com")));
                                            },
                                            child: Text('확인'),
                                          )
                                        ]);
                                  });
                              print('링크 없음. 네이버로 이동');
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPage(url: location.link)));
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
