# 네이버 검색 OpenAPI를 활용한 플러터 지역 정보 앱

- `Flutter_geo_search_naver` (https://github.com/marofmar/flutter_geo_search_naver)
- Flutter Naver Open API Search App

## 🍏 프로젝트 개요

이 Flutter 프로젝트는 Naver Open API를 활용하여 키워드로 지역 정보를 검색하고, 클릭 시 해당 업장의 네이버에 등록된 링크로 연결되는 모바일 애플리케이션입니다.

## 📌 주요 기능

1. 키워드 검색: 네이버 Open API를 통해 검색 결과를 가져옵니다.
2. 링크 연결: 검색된 결과를 클릭하면 해당 업장의 네이버 링크로 연결됩니다.
3. 링크 없는 경우 처리: 링크가 없는 경우 사용자에게 알림을 표시하고 네이버 메인 페이지로 이동합니다.
4. 상태 관리: Riverpod을 사용하여 MVVM 아키텍처 기반 상태 관리를 구현했습니다.
5. 테스트: 각종 기능 및 상태 관리 로직에 대한 단위 테스트를 작성하여 검증했습니다.

## 🏗️ 프로젝트 수행 목표

1. Naver Open API 사용 연습
2. Riverpod을 이용한 상태 관리 학습
3. MVVM 아키텍쳐 적용 및 실습
4. 기능별 단위 테스트 작성 및 검증

## 📂 프로젝트 디렉토리 구조

```
├── data
│ ├── model
│ │ └── location.dart
│ ├── repository
│ └── location_repository.dart
├── ui
│ ├── detail
│ │ ├── detail_page.dart
│ │ ├── detail_view_model.dart
│ │ └── widgets
│ ├── home
│ │ ├── home_page.dart
│ │ ├── home_view_model.dart
│ │ └── widgets
│ └── widgets
├── main.dart

test
├── home_view_model_test.dart
├── location_model_test.dart
└── location_repository_test.dart
```

### 디렉토리 구조 요약

- `lib/data`: 데이터 계층.
  - `model`: 데이터 모델 정의 (e.g., `location.dart`).
  - `repository`: 데이터 처리 로직 및 API 호출 코드 (e.g., `location_repository.dart`).
- `lib/ui`: 화면 및 상태 관리 계층.
  - `detail`: 상세 화면 관련 파일 (e.g., `detail_page.dart`, `detail_view_model.dart`).
  - `home`: 홈 화면 관련 파일 (e.g., `home_page.dart`,a `home_view_model.dart`).
  - `widgets`: 자주 쓰는 UI 위젯 관리 디렉토리 (현재 비어 있음).
- `test`: 테스트 디렉토리.
  - 각종 기능 및 상태 관리를 검증하기 위한 테스트 파일들.

## 🛠️ 사용한 기술

- Flutter: 애플리케이션 UI 및 기능 구현
- Naver Open API: 지역 검색 데이터 제공
- Riverpod: 상태 관리 라이브러리
- MVVM 아키텍쳐: 모듈화된 코드 구조와 상태 관리를 통해 유지보수성 향상
- Unit Testing: 주요 로직 검증을 위한 테스트 코드 작성

## 🏠 설치 및 실행

### 1. 프로젝트 클론

`git clone https://github.com/marofmar/flutter_geo_search_naver.git`
`cd flutter_geo_search_naver`

### 2. 패키지 설치

`flutter pub get`

### 3. `.env` 파일 생성

루트 디렉토리에 `.env`파일을 만들고 그 안에 다음과 같이 API 키를 추가하세요.
`ID=your_client_id`
`SECRET=your_client_secret`

### 4. 실행

`flutter run`

## 💯 테스트

### 테스트 파일

```
test
├── home_view_model_test.dart : 홈 화면 상태 관리 테스트
├── location_model_test.dart : 데이터 모델 테스트
└── location_repository_test.dart : API 호출 및 데이터 처리 테스트
```

### 테스트 실행

`flutter test`

## 🍔 추가 학습 및 개선 방향

1. Riverpod 외의 다양한 상태관리 라이브러리 추가 학습. GetX 등등.
2. UI 컴포넌트 분리하여 리팩토링, widgets 디렉토리에 이동하여 재사용성 높이기.
3. End-to-End 테스트 추가: 실제 사용 시나리오대로 테스트하여 앱의 안전성 높이기.
4. 디자인 개선(👨‍⚕️ 응급!): 화면 밑 위젯을 더 예쁘게 가다듬는 것 필요.
