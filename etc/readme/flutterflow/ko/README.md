
![Image Link](https://github.com/withcenter/fireflow/blob/main/res/fireflow-logo.jpg?raw=true "This is image title")

[English](https://github.com/withcenter/fireflow/blob/main/README.md) | [한국어](https://github.com/withcenter/fireflow/blob/main/etc/readme/ko/README.md)


# FireFlow

- 각 컬렉션/스키마 구조는 영문 문서를 참고한다.
- Fireflow 는 FlutterFlow(이하, FF) 를 지원하기 위해서 만들어진 것이다. 그래서, FlutterFlow 와 가능한 많이 호환되도록, 가능한 많이 FlutterFlow 의 컨셉을 따라 하도록 노력했다. 다만, Flutter 를 사용 할 때에는 Fireflow 를 사용하면 된다.


- [FireFlow](#fireflow)
- [사용자](#사용자)
  - [사용자가 로그인을 할 때 위젯 rebuild 및 데이터 업데이트](#사용자가-로그인을-할-때-위젯-rebuild-및-데이터-업데이트)


# 사용자


## 사용자 계정 생성, 수정, 삭제

- 사용자 정보는 모두 FF 를 통해서 작업을 하면 된다.

## UserService.instance.my

- 사용자 문서가 업데이트 될 때마다 최신 정보를 유지한다.


## UserService.instance.pub

- 사용자 공개 문서가 업데이트 될 때 마다 최신 정보를 유지한다.

## 사용자 정보 업데이트 할 때 위젯 빌드

`MyStream` 은, 사용자 문서가 변할 때 마다 위젯을 빌드한다.
로그인/로그아웃을 감지해서 사용자 문서를 `my` 에 업데이트하고, `UserService.instance.onMyChange` 가 호출되므로, 로그인/로그아웃 할 때 마다 위젯을 빌드하는 효과가 있다. 그래서, `login`, `logout` 속성이 있다.

특히, 이 위젯이 유용한 이유는 authStateChanges() 를 listen 하면, 사용자 문서가 아직, 준비되지 않았을 수 있는데, 이 위젯은 사용자 문서가 준비된 후, 빌드를 하기 때문에 안전하게 사용자 문서를 사용 할 수 있다.

- 예
```dart
MyStream();
MyStream(login: ...);
MyStream(logout: ...);
MyStream(login: ..., logout ...);
```


## 사용자가 로그인을 할 때 위젯 rebuild 및 사용자 정보 업데이트


### loggedIn, currentUser 와 firebaseUserProviderStream

- `lib/src/auth/firebase_user_provider.dat` 에 정의 된 것으로 currentUser 와 firebaseUserProviderStream 는 한 쌍으로 동작한다.

- `FirebaseAuth.instance.authStateChanges()` 를 이용해 단순히 사용자 로그인/로그아웃을 감지하는 스트림을 리턴하는 함수이다.
  그래서 아래와 같이 StreamBuilder 에 쓸 수 있다.
  
```dart
StreamBuilder(
  stream: firebaseUserProviderStream(),
  builder: (context, snapshot) {
    return Text('Email: ${currentUser?.user?.email}');
  }
);
```


- 앱이 실행 될 때 최초 1회 `AppService` 에서 아래와 같이 실행된다. 즉, 사용자 로그인/로그아웃 할 때 마다 항상 동작하는 Stream 이 동작한다.

```dart
userStream = firebaseUserProviderStream()..listen((_) {});
```

- 이 때, 주의해서 볼 것은 firebaseUserProviderStream() 안에서 사용자의 문서를 읽어, `currentUser` 에 업데이트한다.
  - 즉, 사용자 로그인을 할 때 마다 사용자의 최신 정보를 업데이트하는 것이다.
  - 주의 할 것은, 사용자의 문서가 변경 될 때마다 업데이트를 하는 것이 아니라는 것이다. 참고, `UserService.instance.my`

- `loggedIn` 은 사용자가 로그인을 했는지 안했는지를 알 수 있다.

- 참고로 currentUser 와 firebaseUserProviderStream 은 FF 의 컨셉을 적용한 것일 뿐 큰 의미를 두지 않는다. 굳이 사용하지 않아도 된다.






# 채팅

- `/chat_rooms` 에 채팅방 정보 목록, `/chat_room_messages` 에 각 채팅 메시지가 들어 있다.
- 채팅방 정보 목록은 FF 에서 Collection query 를 통해서 직접 하면 된다.
- 채팅방 페이지 안에서 채팅 목록은 `ChatRoomMessageList` 위젯을 사용하면 된다.


## 채팅방 입장

- 채팅방을 입장 할 때에는 해당 채팅방의 reference 를 전달하면 된다.
- 채팅방은 1:1 채팅방, 그룹 채팅방이 있는데 가능한 두개를 분리하여 페이지를 만든다.
  - 물론 하나의 페이지에 만들어도 되지만, 그 만큼 복잡도가 증가한다.
  - 두개의 페이지로 따로 만들어 위젯/컴포넌트를 재 활용해서 쓰면 된다.


## 채팅방 메시지 목록

- 채팅방 메시지 목록을 FF 에서 할 수 없다. 그래서 fireflow 에서 제공하는 `ChatRoomMessageList` 위젯을 쓰면 된다.
  - `ChatRoomMessageList` 위젯에는
    - `myMessageBuilder` - 나의 채팅 메시지. Build 함수이다.
    - `otherMessageBuilder` - 다른 회원의 메시지 Build 함수이다.
    - `onEmpty` - 메시지가 없을 때, 표시할 위젯. Build 함수가 아니다.
    - `protocolMessageBuilder` - 프로토콜 메시지 build 함수.

- `ChatRoomMessageList` 에서 사용할 수 있는 기본(샘플) 위젯들이 제공된다. 물론 직접 FF 로 작성해서 사용해도 된다.
  - `ChatRoomMessageMine` - 나의 채팅 메시지 표시 위젯
  - `ChatRoomMessageOthers` - 다른 사용자의 채팅 메시지 표시 위젯
  - `protocolMessageBuilder` - 프로토콜 메시지 표시 위젯