// {
//   "lastBuildDate": "Sun, 08 Dec 2024 10:20:10 +0900",
//   "total": 1,
//   "start": 1,
//   "display": 1,
//   "items": [
//     {
//       "title": "이월로스터스 송파점",
//       "link": "https://www.instagram.com/february_roasters_songpa/",
//       "category": "카페,디저트>카페",
//       "description": "",
//       "telephone": "",
//       "address": "서울특별시 송파구 송파동 51-7",
//       "roadAddress": "서울특별시 송파구 백제고분로45길 14",
//       "mapx": "1271099678",
//       "mapy": "375096759"
//     }
//   ]  // items: List
// }

class Location {
  String title;
  String category;
  String address;
  String link;

  Location({
    required this.title,
    required this.category,
    required this.address,
    required this.link,
  });

  // 1. fromJson 네임드 생성자 만들기
  Location.fromJson(Map<String, dynamic> map)
      : this(
          title: map['title'] ?? 'Title 없음',
          category: map['category'] ?? 'Category 없음',
          address: map['address'] ?? '주소 없음',
          link: map['link'] ?? '링크 없음',
        );
  // 2. toJson 메서드 만들기
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'address': address,
      'link': link,
    };
  }
}
