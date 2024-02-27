# simple

- Template 이 없는 Simple Project

```bash
flutter create --org=com.callor simple -e
flutter create --org=com.callor simple --empty
```

## Dart 의 변수 선언문

- 각 자료형(type)을 이용하여 선언하기
- 명시적으로(직접적으로) 데이터 type 을 선언하는 방식

```dart
int num = 0;
String str = "korea";
```

- `const` 키워드를 이용하여 선언하기
- `const` 키워드로 선언된 변수는 컴파일이 되는 과정에서 값이 결정된다
- 소풍을 가는데 미리 소풍가서 먹을 음식을 준비하고, 소풍가서는 다른 음식을 일체 준비할수 없는 상태

```dart
const num = 0;
/// 한번 선언된 변수는 절대 값을 변경할수 없다
const num = add(3,4)
/// dart 에서는 함수의 return 값을 const 변수에 저장할수 없다
const str = "Korea";
```

- `final` 키워드를 사용하여 변수 선언하기
- `final` 키워드는 한번 값을 저장하면 변경할 수 없는것은 `const` 와 유사하다 하지만, `final`은 실행하는 과정에서 변수값이 정해진다

```dart
final int num = add(3,4)
/// 함수의 return 되는 결과를 변수에 단 한번만 저장할 수 있다.
/// 하지만 한번 값이 정해지면 이후 코드에서 값을 변경할 수 없다
```

## dart 에서 함수를 선언할때 `const` 사용

- dart 에서 주로 클래스의 생성자에 `const` 키워드를 부착하여 선언한다
- 객체의 불변성을 강조하기 위한 키워드이다.
- `const constructor(불변 생성자)`
