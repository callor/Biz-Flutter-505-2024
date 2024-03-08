# Flutter timer Project

- `PageView` 컴포넌트를 사용하여 `Multi View Page App` 을 구현
- `BottomNavigator`를 이용하여 화면을 전환하면서 보여주기

## Setting 화면 구현하기

- setting ui 도구 dependency 추가하기 : `flutter pub add setting_ui`
- 날짜 설정 도구 dependency 추가 : `flutter pub add datetime_setting`

## Setting 에서 `일할시간`을 설정하면 Home 의 타이머에 반영하기

- `setting_page.dart` 에게 `onChang` 함수를 props 로 전달하여 `workTimer` state 를 변경하도록 코딩하기
- `workTimer` state 를 `home_page.dart` 에 전달하여 `_count` 변수에 할당하여 화면에 반영하기

- `setting` 에서 설정한 값이 `home` 에 반영되도록 하였지만, 어플을 종료한 후 다시 시작하면 값이 초기화가 되어 버린다

## Device 의 `localStorage` 에 `setting` 값 저장하기

- `Web Browser` 의 작은 데이터 저장공간인 `localStorage`와 같은 개념의 저장공간이 `Android`, `IOS`, `WEB` 에는 준비가 되어 있다.
- 하지만 모든 Device 마다 저장하는 방식이 서로 달라서 이 것을 구현하려면 많은 코드가 필요로 하다.
- `localStorage`에 데이터를 저장, 읽기 를 하기 위하여 dependency 를 가져온다.
- 스마트 기기에서는 이 저장 장소를 `shared_preferences` 라는 이름으로 사용하였으며, dependecy 도 이 이름으로 준비되어 있다
- 설치 : `flutter pub add shared_preferences`
