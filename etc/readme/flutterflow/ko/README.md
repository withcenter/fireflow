
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


- 사용자 정보 중에서 email 과 전화번호, 카드 번호 등의 정보는 아주 중요하게 관리되어야 한다. 그래서 /users 와 /users_public_data 두개로 분리해서 공개하면 안되는 정보를 제외하고는 모두 /users_public_data 에 넣는다.
  - 가능한 모든 정보를 /users_public_data 에 넣고, 이 컬렉션의 문서를 사용하도록 한다.

- 주의 해야 할 점은 `MyDoc`, `PubDoc`, `MyStream` 의 사용 혼동이다.
  - `MyDoc` 은 로그인을 한 다음, /users 문서 변화를 감지 할 때,
  - `PubDoc` 은 로그인을 한 다음, /users_public_data 문서의 변화를 감지 할 때,
  - `MyStream` 은, 로그인/로그아웃이 변할 때, 다른 위젯을 보여주고자할 때 사용 할 수 있는데, /users 컬렉션 문서가 변할 때 마다 위젯을 rebuild 한다.
  - `PubStream` 은, 로그인/로그아웃이 변할 때, 다른 위젯을 보여주고자할 때 사용 할 수 있는데, /users_public_data 컬렉션 문서가 변할 때 마다 위젯을 rebuild 한다.




### MyDoc 과 PubDoc

MyDoc 은 `/users` 컬렉션의 문서, PubDoc 은 `/users_public_data` 컬렉션의 문서를 실시간으로 업데이트한다.

중요한 것은, 사용자가 로그인을 했을 때에만 사용 가능하다. 로그인 하지 않았으면 빈 위젯이 표시된다. 즉, 화면에 아무것도 나타나지 않는다.

만약, 로그인 했을 때와 로그아웃 했을 때, 서로 다른 위젯으로 디자인/UI 작업해서 보여주고 싶다면, `MyStream` 위젯을 사용한다.


### MyStream

사용자 문서가 변할 때 마다 `UserService.instance.my` 가 업데이트 된다.
이 변수 값은 최초 앱이 실행될 때와 로그인/로그아웃을 할 때 마다 업데이트 되고, `/users` 컬렉션의 문서가 업데이트 될 때 마다 `my` 에 동기화/업데이트된다.
그리고 `my` 가 업데이트 될 때 마다, `UserService.instance.onMyChange` 가 호출되는데, 이를 subscribe 해서 위젯을 빌드하는 것이다.
즉, 로그인/로그아웃 할 때 마다 위젯을 빌드하는 효과가 있다. 그래서, 위젯의 이름이 `MyStream` 이며, `login`, `logout` builder 속성이 있다.

특히, 이 위젯이 유용한 이유는 authStateChanges() 를 listen 하면, 사용자 문서가 아직, 준비되지 않았을 수 있는데, 이 위젯은 사용자 문서가 준비된 후, 빌드를 하기 때문에 안전하게 사용자 문서를 사용 할 수 있다.

그래도, 중요하게 생각해야 할 것은, `MyStream` 은 사용자 로그인/로그아웃에서 `/users` 데이터를 안전하게 사용 할 수 있지만, 사용자 문서가 변경 될 때에도 위젯을 다시 빌드한 다는 것이다.

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
MyStream = firebaseUserProviderStream()..listen((_) {});
```

- 이 때, 주의해서 볼 것은 firebaseUserProviderStream() 안에서 사용자의 문서를 읽어, `currentUser` 에 업데이트한다.
  - 즉, 사용자 로그인을 할 때 마다 사용자의 최신 정보를 업데이트하는 것이다.
  - 주의 할 것은, 사용자의 문서가 변경 될 때마다 업데이트를 하는 것이 아니라는 것이다. 참고, `UserService.instance.my`

- `loggedIn` 은 사용자가 로그인을 했는지 안했는지를 알 수 있다.

- 참고로 currentUser 와 firebaseUserProviderStream 은 FF 의 컨셉을 적용한 것일 뿐 큰 의미를 두지 않는다. 굳이 사용하지 않아도 된다.






# 채팅

- 채팅을 할 때가 가장 문서를 많이 읽고 쓴다. 특히, 채팅방 목록도 만만치 않게 많은 읽기가 발생하며, 채팅 메시지 목록도 굉장히 많은 읽기가 발생한다.
  - 그래서 Realtime database 로 할까 생각도 많이 했지만, Firestore 가 작업이 훨씬 편해서 Firestore 로 한다.
  - Firestore 비용은 10만원 Read 할 때, 50원 (0.038 달러) 지출된다. 이 정도면 매월 1천원 정소 비용을 낼 수 있다면, 왠만한 앱에서는 충분하고 남는다.

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



# 파일 업로드, 사진 업로드


- Fireflow 에서 파일 또는 사진 업로드 기능을 제공하지 않는다.

