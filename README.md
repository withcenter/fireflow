
![Image Link](https://github.com/withcenter/fireflow/blob/main/res/fireflow-logo.jpg?raw=true "This is image title")

[English README](https://github.com/withcenter/fireflow/blob/main/etc/readme/en/READMD.md)



# FireFlow

- 버전 0.0 과 버전 0.1. 에는 큰 차이가 있다. 특히, 핵심 코드 및 컬렉션 구조가 바뀌어서, 0.0 버전과는 호환이 되지 않는다. 본 문서는 현재, 0.1.x 버전을 작업과 동시에 업데이트 됨에 따라, 자주 업데이트가 있으므로 유의하기 바란다. 
- Fireflow 는 FlutterFlow(이하, FF) 를 지원하기 위해서 만들어진 것이다. 그래서, FlutterFlow 와 가능한 많이 호환되도록, 가능한 많이 FlutterFlow 의 컨셉을 따라 하도록 노력했다. 다만, Flutter 를 사용 할 때에는 Fireflow 를 사용하면 된다.
- 버전 0.1 에서는 기본 위젯을 모두 제공한다. 그래서, 빠르게 앱을 빌드하기 위해서는 기본 제공 위젯을 Custom Widget 으로 연결하면 된다. 그 후 천천히 UI 를 커스터마이징하면 된다.
- 혹시, 버전 0.0.x 대의 소스 코드를 원하시는 분이 있으면, [0.0.x branch](https://github.com/withcenter/fireflow/tree/0.0.x) 를 참고하면 된다.


- [FireFlow](#fireflow)
- [해야 할 것](#해야-할-것)
- [설계](#설계)
- [모델링](#모델링)
  - [데이터 컨버팅](#데이터-컨버팅)
- [코딩 가이드](#코딩-가이드)
  - [초기화](#초기화)
    - [채팅 화면으로 이동](#채팅-화면으로-이동)
  - [UI 디자인 작업](#ui-디자인-작업)
- [사용자](#사용자)
  - [사용자 계정 생성, 수정, 삭제](#사용자-계정-생성-수정-삭제)
  - [사용자 개인 정보](#사용자-개인-정보)
  - [UserService.instance.my](#userserviceinstancemy)
  - [UserService.instance.pub](#userserviceinstancepub)
  - [사용자 정보 업데이트 할 때 위젯 빌드](#사용자-정보-업데이트-할-때-위젯-빌드)
    - [MyDoc 과 PubDoc](#mydoc-과-pubdoc)
    - [AuthStream](#AuthStream)
  - [사용자가 로그인을 할 때 위젯 rebuild 및 사용자 정보 업데이트](#사용자가-로그인을-할-때-위젯-rebuild-및-사용자-정보-업데이트)
    - [loggedIn, currentUser 와 firebaseUserProviderStream](#loggedin-currentuser-와-firebaseuserproviderstream)
  - [공개프로필](#공개프로필)
  - [차단](#차단)
  - [팔로잉](#팔로잉)
- [게시판](#게시판)
  - [카테고리](#카테고리)
- [채팅](#채팅)
  - [DocumentSnapshot 을 Schema Document 로 변경](#documentsnapshot-을-schema-document-로-변경)
  - [채팅방 목록](#채팅방-목록)
  - [채팅방 입장](#채팅방-입장)
  - [채팅방 메시지 목록](#채팅방-메시지-목록)
    - [기본 디자인 사용](#기본-디자인-사용)
    - [각각의 요소를 개별 디자인](#각각의-요소를-개별-디자인)
    - [전체 디자인을 하나의 커스텀 컴포넌트로 연결](#전체-디자인을-하나의-커스텀-컴포넌트로-연결)
- [Chat](#chat)
  - [Chat Overview](#chat-overview)
  - [Chat schema](#chat-schema)
    - [Chat Room collection](#chat-room-collection)
    - [Chat message collection](#chat-message-collection)
  - [Logic of chat](#logic-of-chat)
    - [Entering Chat Room to begin chat](#entering-chat-room-to-begin-chat)
    - [How to list my chat rooms](#how-to-list-my-chat-rooms)
    - [How to display menu when the chat message has tapped.](#how-to-display-menu-when-the-chat-message-has-tapped)
    - [How to leave a group chat room.](#how-to-leave-a-group-chat-room)
    - [How to display an uploaded file.](#how-to-display-an-uploaded-file)
    - [How to not invite the same user.](#how-to-not-invite-the-same-user)
    - [How to display the protocol message.](#how-to-display-the-protocol-message)
    - [How to remove a user](#how-to-remove-a-user)
    - [How to receive and display the push notifications while the app is foreground.](#how-to-receive-and-display-the-push-notifications-while-the-app-is-foreground)
    - [How to display the number of chat rooms with new messages.](#how-to-display-the-number-of-chat-rooms-with-new-messages)
    - [How to query to the Open AI - GPT.](#how-to-query-to-the-open-ai---gpt)
    - [How to change chat room title](#how-to-change-chat-room-title)
    - [How to send chat message](#how-to-send-chat-message)
    - [How to update chat message](#how-to-update-chat-message)
    - [How to create a group chat](#how-to-create-a-group-chat)
  - [Chat Design](#chat-design)
    - [ChatRoomProtocolMessage](#chatroomprotocolmessage)
  - [Chat message count](#chat-message-count)
- [파일 업로드, 사진 업로드](#파일-업로드-사진-업로드)
- [신고](#신고)
- [다국어](#다국어)
  - [단국어 코드 별 치환단어](#단국어-코드-별-치환단어)
- [즐겨찾기](#즐겨찾기)


# 해야 할 것

- 게시판 위젯 - `PostList` 위젯 하나면 추가하면, 이 위젯이 showGeneralDialog 를 이용해서,
  - 글 읽기, 쓰기, 수정, 프로필 보기 등 필요한 모든 기능을 다 하도록 한다. 즉, 이리 저리 페이지를 만들지 않도록 한다.

- 필럽 v2 작성 할 때, 테마와 디자인 라이브러리르 잘 사용해서 개발 한다..
  코믹스 다인을 사용한다.
  - AppContainer
  - AppCard 
  - AppButton
  - AppHeader
  - AppFooter
  - TextBody

  그리고 Theme.of(context).textTheme. 에 맞도록 아래의 각각의 커스텀 위젯을 만들고, 내부적으로 디자인을 미리 해 놓도록 한다.
  - TextBodyLarge
  - TextBodySmall
  - TextHeader
  - TextLarge
  - TextSmall
  - TextLabel

- Push notification

- moveUserData 기능 동작 확인
- `/backend/schema` 폴더에 있는 schema 를 없애고 대신 나만의 BuiltValue 코딩을 한다. 굳이, `getDocumentFromData()` 이런 것 없어도 된다. 직접 할 수 있는 것 까지만 하면 된다. Service 를 활용하면된다.
  - 왜냐하면, FF 에서 코드를 자동 생성되다 보니 좀 BuiltValue 가 깨끝하지 못하고, 필요 없는 코드가 복잡하게 얽혀져 있다.

- 채팅창에 명령어
  - /ai 너는 누구냐?
  - /image give me apples and bananas
  - /api https://philgo.com/etc/api.php
  와 같이 특별 명령을 하면, `onCommand( message ) => Container(...UI Design...)` 가 실행되고, 직접 원하는 커스텀 코드를 수행하고, 결과를 UI 로 보여주게 한다.



- Supabase 키를 key.dart 파일에 저장하지 말고, 관리자 페이지에서 직접 입력 할 수 있도록 한다. 그리고 system_settings/keys 에 보관한다.


- 채팅메세지 신고 기능.
  - 관리자가 신고 확인.

- 게시글, 채팅방 공유
- 추천인 기능
- Android 헤드업 푸시 알림
- 외부에서 내부로 사진/파일 등 공유


- 우선 사용자 문서를 클라이언트에서 캐시 후 사용.
  - 차 후, 사용자 문서를 realtime database 로 동기화 시키고, 클라이언트에서 캐시를 해서 사용.


- Remote Config 말고 그냥 Firestore 관리자 기능으로 할 수 있지만, 어차피, ... 그러한 옵션들이, 의뢰인(운영자)가 할 것이 아니고, 또 한 두번만 설정하면 끝나기 때문에 편한데로 한다.
  - 어떤것이 편할까? 일단, Remote Config 로 한다.

- 자기 자신과 채팅을 할 수 있다.
  - Remote config 로 자기 자신과 채팅 할지 말지를 결정 할 수 있도록 한다.





# 설계

- 에러가 있는지 체크해서 핸들링하는 것이 아니라, 그냥 exception 을 throw 하는 것이 원칙이다.
  - 필요한 경우, global error handler `runZonedGuarded` 를 통해서 화면에 에러 표시를 한다.

- 각종 콜백 함수 파라메타 또는 페이지 파라메타를 전달 할 때에는 문서 ID 또는 Fireflow 의 Model 을 전달한다.
  - 문서 ID 를 전달하면, 웹에서 쉽게 값을 전달 할 수 있으며, FF 에서도 문서 ID 를 문서 reference 로 쉽게 바꿀 수 있다.
    - DB 로 부터 문서를 가져 오지 않고, 메모리에 있는 것을 빠르게 보여줘야하는 경우가 아닌, 특히, 관리자 페이지와 같이 문서 값을 DB 에서 가져와도 되는 경우는 문서 ID 값만 전달한다.
  - 문서를 화면에 빠르게 보여주기 위해서는 메모리에 있는 값을 재 활용 해야 한다. Fireflow 의 Model 타입의 데이터를 FF Schema Document 로 변환하기 위해서는, `Model.toJson()` 과 `Model.reference` 두 값으로 `XxxxxRecord.getDocumentFromData()` 를 사용해 쉽게 스키마로 변경 할 수 있다.


- Fireflow 가 제공하는 위젯으로 문서를 넘길 때,
  - BuiltValue 로 하면, FF 와 호환되어 좋기는 한데, 코드가 깔끔하지 못하다.
  - 그래서, FF 에서는 직접 작성한 Model 을 사용하는데, FF 의 Document 값을 FF 의 Model 로 변환하기 위해서는 가장 쉬운 방법은 FF 의 backend/schema 에서 제공하는 createXxxx() 를 사용해서, FF 의 Document 값을 `Map<String, dynamic>` 으로 만들고, Fireflow 의 `Model.fromJson()` 을 사용하면 된다.

# 모델링

- 백엔드 또는 3rd party 와 데이터 송/수신을 할 때, JSON 을 모델로 변환하는데, 이 때, 초기 값을 가질 수 없는 경우를 제외한 모든 모델 변수는 nullable 이 아니다.
즉, 빈 문자열, false, 0, 빈 배열 등의 값으로 초기화가 된다.

  - 날짜 값은 초기값(빈 값)을 지정 할 수 없으니, nullable 이다. 하지만, 필요한 경우, 처음 날짜 값인 1973, 1, 1 을 사용 할 수 있다.
  - 이미지 경로의 경우도, nullable 이 된다. 이름이나 다른 값은 빈 문자열로 초기화를 하면 되지만, 이미지 경로의 경우는 빈 문자열이 초기 값이 될 수 없다.
  - DocumentReference 의 경우도 초기 값이 없으므로 nullable 이다. 단, `List<DocumentReference>` 는 빈 배열로 초기화를 하면 된다.


## 데이터 컨버팅


- FF 에서는 built value 를 통해서 데이터 모델링을 한다. Fireflow 에서는 직접 모델을 작성해서 관리한다. 그런데 때로는 이 둘 사이에 데이터 교환이 필요 할 수 있다. 즉, FF 의 Schema Document 를 Fireflow 의 Model 로 변경하고, 반대로 Fireflow 의 Model 을 FF 의 Schema Document 로 변경 해야 할 필요가 있을 때, 아래와 같이 하면 된다. 


- FF 의 Schema Document 를 Fireflow Model 로 변경하기
```dart
final user = UserModel.fromJson(
    serializers.toFirestore(UsersRecord.serializer, currentUserDocument),
    reference: currentUserDocument!.reference);
print('---> user: $user');
print(user.reference);
print(user.uid);
print(user.displayName);
print(user.photoUrl);
```


- Fireflow 의 Model 을 FF 의 Schema Document 로 변경하기
```dart
final user = UserModel.fromJson(
    serializers.toFirestore(UsersRecord.serializer, currentUserDocument),
    reference: currentUserDocument!.reference);

final UsersRecord userRecord =
    UsersRecord.getDocumentFromData(user.toJson(), user.reference);
```




# 코딩 가이드


- 각종 다이얼로그에서 가능한 자체적으로 다이얼로그를 닫지 않고, callback 함수를 둔다. 다이얼로그를 열어서, 작업이 종료되어도 계속 화면에 보여 줄 수도 있다. 그래서 다이얼로그를 오픈 한 부모 위젯에서 닫을 수 있도록 한다.
  - 이 때, 콜백 함수는 `onError`, `onCancel`, `onSuccess` 로 통일을 한다.



## 초기화

- 앱을 시작 할 때, `AppService.instance.init()` 을 호출하면 된다. 이 값은 navstack 의 최 하위 페이지(루트)에서 한번만 실행하면 된다.

```dart
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _router = createRouter();

    //
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      navigatorKey = _router.routerDelegate.navigatorKey;

      AppService.instance.init(
        context: navigatorKey.currentContext,
        debug: true,
        moveUserPrivateDataTo: 'users_private_data',
        onChat: (UserModel user) => _router.pushNamed(
          ChatRoomScreen.routeName,
          queryParams: {
            'chatRoomDocumentId': ChatService.instance
                .getSingChatRoomReference(user.reference)
                .id,
          },
        ),
      );
    });
  }
}
```

- 만약, 페이지 변경을 할 때 또는 기타 이유로 navstack 에서 `AppService.instance.init()` 을 한 페이지가 사라지면, `BuildContext` 를 새로 지정해 주어야 한다.
```dart
AppService.instance.init(
  context: content,
);
```

- 참고, FF팀에서 `Custom code in main.dart` 와 같은 업데이트를 준비하고 있다. 그러면 main.dart 에 커스텀 코드로 `init()` 를 직접 추가 할 수 있으니, 작업이 한결 간편해 질 수 있다.




### 채팅 화면으로 이동

- 직접 모든 UI 작업을 하는 경우는 채팅 화면으로 직접 이동하면 되겠지만, 기본 위젯을 사용하는 경우 채팅 화면으로 이동을 하기 위한 별도의 액션이 준비되어야 한다.
  - 예를 들면, `메인 화면 -> 채팅 버튼`, `사용자 목록 -> 사용자 프로필 -> 채팅 버튼`, `글 목록 -> 글 읽기 -> 더보기 메뉴 -> 채팅 버튼` 등 여러가지 메뉴에서 다양하게 채팅방으로 이동을 해야하는데, parameter drilling 으로 필요한 값이나 콜백을 전달하기에는 무리가 있다. 그래서 `AppService.instance.init(onChat: ...)` 에 콜백을 전달해서, 채팅 버튼이 탭 될 때마다 그 콜백에서 적절히 채팅방으로 이동을 하면 된다.

```dart
AppService.instance.init(
  onChat: (UserModel user) => _router.pushNamed(
    ChatRoomScreen.routeName,
    queryParams: {
      'chatRoomDocumentId': ChatService.instance
          .getSingChatRoomReference(user.reference)
          .id,
    },
  ),
);
```


## UI 디자인 작업

- Fireflow 는 각 쓰임새에 맞는 기본 위젯을 제공하며, 원한다면 직접 모든 것을 다 디자인 할 수 있다.
  - 예를 들어, 팔로잉하고 있는 사용자 목록을 할 때, Fireflow 에서 제공하는 기본 위젯을 써도 되고, 직접 백엔드 쿼리를 통해서 디자인을 해도 된다.
  - 기본 위젯을 쓰면, 사용자 목록에서 사용자를 탭하면 그 사용자의 프로필이 화면에 나타나는 것 까지 기본 위젯으로 모두 동작한다.
  - 하지만, 직접 UI 디자인을 하면 그러한 모든 동작을 직접 작업해야 한다.


### 색상

- 색상 디자인은 기본적으로 `MaterialTheme(theme: ... )` 에서 하면 된다.


- 각종 border, outline 색상은 `outline` 을 쓰면 된다.




# 사용자

- Fireflow 버전 0.1.x 에서 `/users_public_data` 를 지우고 `/users` 컬렉션으로 통일하여, 일관성 있는 작업을 하도록 했다.
  - 다만, 사용자의 메일 주소와 전화번호는 유출되면 안되는 민감한 데이터이므로 보안상의 이유로 다른 컬렉션으로 보관할 수 있는 옵션을 제공한다.
  (참고로, Firebase 에서는 접속 키가 공개되어 별도의 보안 작업을 하지 않으면 쉽게 노출 된다.)
    - `AppService.instance.init(moveUserPrivateDataTo: 'users_private_data')` 를 하면, `/users` 컬렉션에서 email 과 phone number 를 삭제하고, 지정한 컬렉션으로 이동시켜 준다. 현재는 email 과 phone number 두 개만 이동을 한다. 이 두개는 FF 에 의해서 자동으로 지정되는 것으로 그 외의 사용자 이름, 집 주소 등은 직접 다른 컬렉션으로 집어 넣으면 된다.
  - 이 때, 사용자 데이터를 보관하는 문서는 security rules 로 안전하게 지켜야 한다.
예
```txt
  match /users_private_data/{documentId} {
    allow read,write: if request.auth.uid == documentId;
  }
```


## 사용자 계정 생성, 수정, 삭제

- 사용자 정보는 모두 FF 를 통해서 작업을 하면 된다.


## 사용자 개인 정보

- Firebase 를 사용하는 많은 앱들의 문제점이 보안이다. 특히, FF 의 경우, 기본 사용자 문서 저장 collection 이 기본적으로 users 인데, 이 문서가 읽기용으로 공개되는 경우가 대부분이다. 그런데 이 문서에 사용자의 이메일이나 전화번호, 집 주소 등이 들어가는데, 대한민국에서는 매우 민감하게 이 문제를 다루고 있다. 하지만, 안타깝게도 FF 개발을 하는 경우 거의 모두 이러한 문제에 노출되어져 있다.



## UserService.instance.my

- 사용자 문서가 업데이트 될 때마다 최신 정보를 유지한다.


## UserService.instance.pub

- 사용자 공개 문서가 업데이트 될 때 마다 최신 정보를 유지한다.




## 사용자 정보 업데이트 할 때 위젯 빌드


- 사용자 정보 중에서 email 과 전화번호, 카드 번호 등의 정보는 아주 중요하게 관리되어야 한다. 예를 들어, 지난 1년간 글/코멘트 정보가 삭제되었다면 사과하면 될 일이지만, 회원의 집주소, 전화번호, 이메일, 이름, 성별, 생년월일 등이 유출되었다면 아주 심각한 문제이다.
  - 그래서 /users 와 /users_public_data 두개로 분리해서 공개하면 안되는 정보를 제외하고는 모두 /users_public_data 에 넣는다.
  - 가능한 모든 정보를 /users_public_data 에 넣고, 이 컬렉션의 문서를 사용하도록 한다.

- 주의 해야 할 점은 `MyDoc`, `UserDoc`, `AuthStream` 의 사용 혼동이다.
  - `MyDoc` 은 로그인을 한 다음, /users 문서 변화를 감지 할 때,
  - `AuthStream` 은, 로그인/로그아웃이 변할 때, 다른 위젯을 보여주고자할 때 사용 할 수 있는데, /users 컬렉션 문서가 변할 때 마다 위젯을 rebuild 한다.
  - `UserDoc` 은 다른 사용자의 정보를 메모리 캐시해서 보여주거나, 실시간으로 사용자 정보가 변하면 업데이트를 해서 보여 줄 수 있다.





### MyDoc

MyDoc 위젯은, 로그인 한 사용자의 `/users` 컬렉션의 문서를 변화를 실시간으로 감지하여, 문서가 업데이트하면 위젯을 rebuild 한다.

중요한 것은, 사용자가 로그인을 했을 때에만 사용 가능하다. 로그인 하지 않았으면 빈 위젯이 표시된다. 즉, 화면에 아무것도 나타나지 않는다.

만약, 로그인 했을 때와 로그아웃 했을 때, 서로 다른 위젯으로 디자인/UI 작업해서 보여주고 싶다면, `AuthStream` 위젯을 사용한다.


### AuthStream

사용자 문서가 변할 때 마다 `UserService.instance.my` 가 업데이트 된다.
이 변수 값은 최초 앱이 실행될 때와 로그인/로그아웃을 할 때 마다 업데이트 되고, `/users` 컬렉션의 문서가 업데이트 될 때 마다 `my` 에 동기화/업데이트된다.
그리고 `my` 가 업데이트 될 때 마다, `UserService.instance.onMyChange` 가 호출되는데, 이를 subscribe 해서 위젯을 빌드하는 것이다.
즉, 로그인/로그아웃 할 때 마다 위젯을 빌드하는 효과가 있다. 그래서, 위젯의 이름이 `AuthStream` 이며, `login`, `logout` builder 속성이 있다.

특히, 이 위젯이 유용한 이유는 authStateChanges() 를 listen 하면, 사용자 문서가 아직, 준비되지 않았을 수 있는데, 이 위젯은 사용자 문서가 준비된 후, 빌드를 하기 때문에 안전하게 사용자 문서를 사용 할 수 있다.

그래도, 중요하게 생각해야 할 것은, `AuthStream` 은 사용자 로그인/로그아웃에서 `/users` 데이터를 안전하게 사용 할 수 있지만, 사용자 문서가 변경 될 때에도 위젯을 다시 빌드한 다는 것이다.

- 예
```dart
AuthStream();
AuthStream(login: ...);
AuthStream(logout: ...);
AuthStream(login: ..., logout ...);
```

### UserDoc

- 다른 사용자 문서를 가져오거나 listen 한다.
- `isLive` 옵션을 true 로 주면, 실시간으로 해당 사용자 문서를 listen 하고 업데이트가 있으면 rebuild 한다.
- `isLive` 옵션이 false 이면, 캐시한 사용자 데이터를 화면에 보여준다. 기본 값은 false.


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
AuthStream = firebaseUserProviderStream()..listen((_) {});
```

- 이 때, 주의해서 볼 것은 firebaseUserProviderStream() 안에서 사용자의 문서를 읽어, `currentUser` 에 업데이트한다.
  - 즉, 사용자 로그인을 할 때 마다 사용자의 최신 정보를 업데이트하는 것이다.
  - 주의 할 것은, 사용자의 문서가 변경 될 때마다 업데이트를 하는 것이 아니라는 것이다. 참고, `UserService.instance.my`

- `loggedIn` 은 사용자가 로그인을 했는지 안했는지를 알 수 있다.

- 참고로 currentUser 와 firebaseUserProviderStream 은 FF 의 컨셉을 적용한 것일 뿐 큰 의미를 두지 않는다. 굳이 사용하지 않아도 된다.


## 공개프로필

- 아래와 같이, `onTap` 콜백을 두어서, 사용자 공개 프로필을 보여주는 페이지로 이동하는 코드를 직접 작성해도 된다.
- 또는 `onTap` 을 null 로 지정(또는 생략)하면, 기본 위젯을 사용해서 사용자의 공개 프로필을 다이얼로그로 화면에 보여준다.


```dart
import 'package:fireflow/fireflow.dart';
import 'package:flutter/material.dart';
import 'package:phil/screens/user/public_profile.screen.dart';
import 'package:go_router/go_router.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  static const String routeName = '/following';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Following'),
      ),
      body: FollowList(onTap: (user) {
        context.pushNamed(PublicProfileScreen.routeName, queryParams: {
          'uid': user.uid,
        });
      }),
    );
  }
}
```



## 차단


- 차단은 사용자를 대상으로 할 수 있다. 글, 코멘트, 채팅, 사진 등에 차단을 하면 결국은 그 컨텐츠를 업로드 한 사용자를 차단하는 것이다.

- 내가 다른 사용자를 차단하면, 나의 문서에서 `blockedUsers` 필드에 차단한 사용자들의 reference 가 배열로 저장된다.

- 사용자를 차단하면, 그 사용자의 글, 코멘트, 채팅, 사진 등 그 사용자의 컨텐츠를 볼 수 없다.




## 팔로잉


- 팔로잉은 사람을 팔로잉하는 것이다. 글이나 코멘트를 팔로잉하는 것이 아니다.
- 그래서 간단히 사용자 문서의 `followings` 필드에 팔로잉하는 사용자의 reference 를 배열로 저장한다.







# 게시판


## 카테고리

- 카테고리의 문서 ID 는 카테고리 ID 와 동일 해야 한다. 즉, 카테고리 ID 가 qna 이면, 문서 ID 도 qna 이어야 한다는 것이다. FF 는 문서 ID 지정을 하지 않으므로 반드시 커스텀 코드를 통해서 생성해야 한다.
  - 예: `/categories/qna { categoryId: qna }`




# 채팅

- 채팅을 할 때가 가장 문서를 많이 읽고 쓴다. 특히, 채팅방 목록도 만만치 않게 많은 읽기가 발생하며, 채팅 메시지 목록도 굉장히 많은 읽기가 발생한다.
  - 그래서 Realtime database 로 할까 생각도 많이 했지만, Firestore 가 작업이 훨씬 편해서 Firestore 로 한다.
  - Firestore 비용은 10만원 Read 할 때, 50원 (0.038 달러) 지출된다. 이 정도면 매월 1천원 정소 비용을 낼 수 있다면, 왠만한 앱에서는 충분하고 남는다.


- 채팅 기능에 필요한 모든 위젯/UI 가 기본 제공되어 바로 쓸 수 있게 한다.
  - 원하는 경우 커스텀 디자인을 추가 할 수 있다.
  - 채팅 목록(친구 목록)
    - 즐겨찾기
    - 1:1 대화방 목록
    - 친구로 추가된 사용자 목록
    - 오픈챗 목록
    - 그룹 챗 목록
    - 내가 속한 모든 채팅방 목록
    - 각 목록에 들어가는 개별 UI 디자인.
  - 채팅방
    - 헤더, 바디(메시지 목록) 스크롤, 입력 위젯(카메라 아이콘, 텍스트필드, 전송 버튼 분리) 및 나의 메세지, 상대방의 메시지, URL preview, 이미지/파일 preview, 프로토콜 메시지 등 모든 UI 를 커스텀 할 수 있다.
    - 바디를 커스텀 디자인을 할 때에는 개별 요소를 각 각 디자인 할 수도 있고, 전체 요소를 하나의 위젯(컴포넌트)으로 연결하, 그 안에 모든 필요한 디자인을 한번에 할 수 있도록 옵션을 준다.
- 채팅 메세지에는 사용자 UID, 이름, 프로필 사진 URL 이 기본적으로 추가되며, 이 정보는 채팅방에 입장 할 때, 위젯으로 전달 해 줄 수 있다.


- `/chat_rooms` 에 채팅방 정보 목록, `/chat_room_messages` 에 각 채팅 메시지가 들어 있다.
- 채팅방 정보 목록은 FF 에서 Collection query 를 통해서 직접 하면 된다.
- 채팅방 페이지 안에서 채팅 목록은 `ChatRoomMessageList` 위젯을 사용하면 된다.

## DocumentSnapshot 을 Schema Document 로 변경

- Fireflow 에서 제공하는 채팅방이나 채팅메시지 데이터는 Firestore 의 DocumentSnapshot 이다. 이 값을 FlutterFlow 에서 인식할 수 있도록
  - `ChatRoomsRecord.getDocumentFromData()` 또는
  - `ChatRoomMessagesRecord.getDocumentFromData()` 와 같이 변환을 해 주어야 한다.


## 채팅방 목록

- 채팅방 목록에는 `친구`, `채팅`, `오픈챗`과 같이 세개가 있다.
  - `친구`목록 화면에는 카카오톡과 같이 최 상단에 나의 프로필이 뜨고, 그 아래에 즐겨찾기 목록, 그 아래에 1:1 채팅의 사용자들이 가나다 순으로 표시된다.
  - `채팅`목록 화면에는 내가 참여한 모든 채팅방 목록이 나타난다. 1:1 챗, 그룹 챗 등이 나열 된다.
    - 채팅 목록은 새로운 메시지가 있는 채팅 방이 위에 표시되고 그외에는 마지막 채팅 메시지 순으로 목록된다.
  - `오픈챗`목록 화면에는 공개된 채팅방으로 아무나 입장을 할 수 있다.



## 채팅방 입장

- 채팅방을 입장 할 때에는 해당 채팅방의 reference 를 전달하면 된다.
- 채팅방은 1:1 채팅방, 그룹 채팅방이 있는데 가능한 두개를 분리하여 페이지를 만든다.
  - 물론 하나의 페이지에 만들어도 되지만, 그 만큼 복잡도가 증가한다.
  - 두개의 페이지로 따로 만들어 위젯/컴포넌트를 재 활용해서 쓰면 된다.


## 채팅방 메시지 목록

- 채팅방 메시지 목록을 FF 에서 할 수 없다. FF 에서는 Collection Query 를 할 때, 새로 생성/삭제된 문서를 보여주기 위해서는 모든 문서를 한번에 다 가져와야 해서 안된다. Infinite scroll 을 하면 새 문서를 가져 올 수 없다. 그래서 Fireflow 에서 채팅 메시지 목록을 위해서 만든 `ChatRoomMessageList` 위젯을 쓰면 된다.
  - `ChatRoomMessageList` 위젯에는 아래와 같은 widget builder 함수가 있다.
    - `myMessageBuilder` - 나의 채팅 메시지. Build 함수이다.
    - `otherMessageBuilder` - 다른 회원의 메시지 Build 함수이다.
    - `onEmpty` - 메시지가 없을 때, 표시할 위젯. Build 함수가 아니다.
    - `protocolMessageBuilder` - 프로토콜 메시지 build 함수.

- 참고로, `ChatRoomMessageList` 의 widget builder 에서 사용할 수 있는 기본(샘플) 위젯들이 제공된다. 물론 직접 FF 에서 커스텀 위젯으로 만들거나 커스텀 컴포넌트로 연결해서 사용해도 된다.
  - `ChatRoomMessageMine` - 나의 채팅 메시지 표시 위젯
  - `ChatRoomMessageOthers` - 다른 사용자의 채팅 메시지 표시 위젯
  - `ChatRoomMessageProtocol` - 프로토콜 메시지 표시 위젯
  - `ChatRoomMessageEmpty` - 채팅 메시지가 없을 때 보여주는 위젯


### 기본 디자인 사용

- 아래와 같이 간단하게 채팅방 reference 만 전달하면 기본 디자인을 사용한다.

```dart
ChatRoomMessageList(
  chatRoomDocumentReference: widget.chatRoomDocumentReference,
),
```

### 각각의 요소를 개별 디자인

```dart
ChatRoomMessageList(
    chatRoomDocumentReference: widget.chatRoomDocumentReference,
    myMessageBuilder: (DocumentSnapshot snapshot) =>
        ChatRoomMessageMine(
      message: ChatRoomMessagesRecord.getDocumentFromData(
        snapshot.data()! as Map<String, dynamic>,
        snapshot.reference,
      ),
    ),
    otherMessageBuilder: (DocumentSnapshot snapshot) =>
        ChatRoomMessageOthers(
      message: ChatRoomMessagesRecord.getDocumentFromData(
        snapshot.data()! as Map<String, dynamic>,
        snapshot.reference,
      ),
    ),
    protocolMessageBuilder: (DocumentSnapshot snapshot) =>
        ChatRoomMessageProtocol(
      message: ChatRoomMessagesRecord.getDocumentFromData(
        snapshot.data()! as Map<String, dynamic>,
        snapshot.reference,
      ),
    ),
    onEmpty: const Text('No messages yet'),
  ),
```


- 원하지 않는 요소의 경우 그냥 빈 디자인(커스텀 컴포넌트)를 표시하면 된다.
  - 예를 들어, 채팅 메시지가 없을 때, 화면에 아무것도 보여주지 않고 싶다면, `onEmpty` 에 `SizedBox.shrink()` 또는 그냥 빈 커스텀 컴포넌트를 연결하면 된다. 이것은 `protocolMessageBuilder` 또는 다른 속성에도 마찬가지 이다.



### 전체 디자인을 하나의 커스텀 컴포넌트로 연결

- 아래와 같이 ChatRoomMessageList 의 builder 에 하나의 위젯(또는 커스텀 컴포넌트 하나)만 연결한 후, 그 안에서 모든 디자인을 다 할 수 있다.

```dart
ChatRoomMessageList(
  chatRoomDocumentReference: widget.chatRoomDocumentReference,
  builder: (String type, DocumentSnapshot? snapshot) =>
      ChatRoomMessage(
    type: type,
    snapshot: snapshot,
  ),
)
```


- `type` 은 `my`, `other`, `protocol`, `empty` 와 같이 있다. if 문장이나 Conditional Visibility 를 써서 적절히 UI 를 보여주면 된다.
  - `type` 이 `empty` 인 경우, snapshot 은 null 이다.
  - 참고, snapshot 을 schema 문서로 변경




## 채팅 컬렉션

### 채팅방 컬렉션

FF 스키마 **chat_rooms**

|Field Name | Data Type |
|--------|-------:|
| id | String |
| userDocumentReferences | List < Doc Reference (users) > |
| lastMessage | String |
| lastMessageUploadUrl | String |
| lastMessageSentAt | Timestamp |
| lastMessageSeenBy | List < Doc Reference (users) > |
| lastMessageSentBy | Doc Reference (users) |
| title | String |
| unsubscribedUserDocumentReferences | List < Doc Reference (users) > |
| moderatorUserDocumentReferences | List < Doc Reference (users) > |
| isGroupChat | Boolean |
| isOpenChat | Boolean |
| reminder | String |
| backgroundColor | String |
| urlClick | Boolean |
| urlPreview | Boolean |
| isSubChatRoom| Boolean |
| parentChatRoomDocumentReference | Doc Reference (chat_rooms) |
| subChatRoomCount | Integer |
| noOfMessages| Integer |
| readOnly | Boolean |







- `id` is the id of the chat_rooms document itself.
- `userDocumentReferences` is the participants document reference of the chat room.
- `lastMessage` is the last chat message if the user sent a text.
- `lastMessageUploadUrl` is the url of the upload if the user uploaded a file(photo).
- `lastMessageSentAt` is the timestamp of last message
- `lastMessageSeenBy` is the list of user reference who have read the message
- `lastMessageSentBy` is the user reference of the last chat message sender.
- `title` is the chat room title. The moderator can change it.
- `moderatorUserDocumentReferences` is the user document references of the moderators. The first user who created the chat room becomes a moderator automatically. And he can add more moderators.
- `unsubscribedUserDocumentReferences` is the document references of the users who disabled the notification of a new message for the chat room.
- `isGroupChat` is set to `true` if it's a group chat. Otherwise, false.
- `isOpenChat` is set to `true` if the chat room is open to anyone. When it is set to true, users can join the chat room.
- `urlClick` is set to `true` if the moderator lets users click the url.
- `urlPreview` - Set it to `true` to show the preview of the url link.
- `isSubChatRoom` - If the chat room is a sub chat room, then it is set to true.
- `parentChatRoomDocumentReference` - This is the parent chat room document reference if the sub chat group functionality is enabled.
- `isSubChatRoom` - This is `true` when the chat room is a sub chat room of a parent chat room. (updated by `ChatService.instance.chatRoomAfterCreate`)
- `subChatRoomCount` - This has no the number of the sub chat room if the chat room is a parent chat room. (updated by `ChatService.instance.chatRoomAfterCreate`). `isSubChatRoom` field is set in `catRoomAfterCreate`. But it is also set in `ChatMessageList` widget.
- `noOfMessages` - This has the total number of messages that were sent by the users in the room. You may use this to display as favorites chat rooms. For instance, you want to display 10 1:1 chat rooms ordered by the no of messages.
- `readOnly` is set to true when the moderator of the chat room set it to read only. Then, the users in the room can only read. Moderators can write.
- `createdAt` is the time that the chat room is created.


### 채팅 메시지 컬렉션

FF 채팅방 메시지 스키마 **chat_room_messages**

|Field Name | Data Type |
|--------|-------:|
| userDocumentReference | Doc Reference (users) |
| chatRoomDocumentReference | Doc Reference (chat_rooms) |
| text | String |
| sentAt | Timestamp |
| uploadUrl | String |
| uploadUrlType | String |
| protocol | String |
| protocolTargetUserDocumentReference | Doc Reference (users) |
| previewUrl | String |
| previewTitle | String |
| previewDescription | String |
| previewImageUrl | Image Path |
| replyDisplayName | String |
| replyText | String |


- `userDocumentReference` 는 메시지를 보낸 사용자이다.
- `chatRoomDocumentReference` 는 채팅방 레퍼런스이다.
- `text` is the chat message.
- `uploadUrl` is the url of the uploaded file. It can be an Image Path, Video Path, Audio Path or any upload url.
- `uploadUrlType` is the type of the upload file. It can be one of the following;
  - Empty string if there is no upload.
  - image
  - video
  - audio
  - file ( if the upload file is not one of image, video, audio, then it is file type ).
- `protocol` is the protocol states the purpose(or action) of the message. For instance, when a user invites another user, then the protocol is set to `invite`. It could be one of;
  - invite
  - enter
  - remove
  - leave
  When the protocol is set, there might be extra information.
- `protocolTargetUserDocumentReference` 는 프로토콜 대상자 ref 이다.
  - 예를 들어,
    - invite 프로토콜에서는 userDocumentReference 가 protocolTargetUserDocumentReference 를 초대한 것이다.
    - enter 에서는 userDocumentReference 가 protocolTargetUserDocumentReference 와 동일하다.
- `sentAt` is the time that the message was sent.

- When there is a url in the text, the fireflow will save the url preview information at `previewUrl`, `previewTitle`, `previewDescription`, `previewImageUrl`. If there is no url in the text or it cannot save preview informatin, the fields become empty string.
  - The `previewDescriptoin` has the full description from the site. If you need to cut it short, you may use a custom fuction (or a code expression).

- `replyDisplayName` is the name of the message in reply. A user can reply on another message. And it is the name of the other message.
- `replyText` is the message of the reply.



## Logic of chat


### Entering Chat Room to begin chat

- For A, to chat with B
  - A enters the `ChatRoom` screen with the parameter of the `userPublicDataDocument` of B over
  - Then, in the `ChatRoom` Screen,
  - Display user’s photo and name on the app bar from `userPublicDataDocument`
  - Use the `ChatRoomMessages` custom widget with the reference of `userPublicDataDocument`.
  - Note that, If a user document reference is given to fireflow ChatRoomMessages widget, it is considered as 1:1 chat.


- To begin a group chat,
  - A opens a group chat with `chatRoomDocument`.
  - Display chat room information from `chatRoomDocument`.
  - In the chat room, it uses the `ChatRoomMessages` custom widget with the reference of `chatRoomDocument`.
  - If a chat room document reference is given to fireflow ChatRoomMessages widget, it is considered as group chat.




### How to list my chat rooms

* Get the chat rooms that have the logged in user’s document reference in the `userDocumentReferences` field.

* To get the list of chat rooms from the Firestore
  * Add ListView (or Column)
  * Add Backend Query
    * Choose `chat_rooms` on Collection.
    * Query Type to `List of Documents`
    * Add a Filter
      * Collection Field Name to `userDocumentReferences`
      * Relation to `Array Contains`
      * Value Source to `User Record Reference`
    * Add an ordering
      * Collection Field Name to `lastMesageSentAt`
      * Order to `Decreasing`


* To display the chat rooms
  * Add a `Column` as the child of `List View`.
  * Add `Two Containers` to the `Column`. The first Container is for displaying the one to one chat and the second Container is for displaying the group chat.
  
  * (One to One chat Container)
    * Add Backend Query
      * `Query Collection`.
      * Query Type to `Single Document`.
      * Add a Filter.
      * Collection Field Name to `userDocumentReference`.
      * Relation to `Equal To`.
      * Value Source to Custom Function named `chatOtherUserReference` and set its two parameters.
        * userDocumentReferences to `chat_rooms userDocumentReferences`.
        * myUserDocumentReference to `logged in user's reference`.
    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-onetoone-backend.png?raw=true "Chat rooms collection")
    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-onetoone-backend-2.png?raw=true "Chat rooms collection")
        
    * Add conditional visibility as the Num List Items of `monderatorUserDocumentReferences` is equal to 0.

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-condition-sing-chat.jpg?raw=true "Chat rooms collection")

    * Inside the `Container` add `Row`
    * Inside the `Row` add `Container`
    * Inside the `Container` add `Row` again

    Inside the `Row` you can now add a widget to display the `user's photo` and text widgets to display the `user's name`, `last message` and `the time` it was sent

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-onetoone-row.png?raw=true "Chat rooms collection")

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-onetoone-row-2.png?raw=true "Chat rooms collection")

    * To display the user's photo:
      * Add `Image Widget` or `Custom Widget`
      * Set its path to `if else condition` (we need to check first if the user's photo is set or not)

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-condition-onetoone-chat-2.png?raw=true "Chat rooms collection")
            
        * (if condition) check if the user's photo url is set, if it is, then set it as the path of the image widget
        * (else condition) another if else condition to check if the user's gender is `male or female` to correctly show the placeholder image based on the user's gender
          * (if condition) check if the user is female, if it is, then set the path of the image widget to the female placeholder image url stored in local state
          * (else condition) if the user is not female, set the path of the image widget to the male placeholder image url stored in local state

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-condition-sing-chat-user-photo-condition-2.png?raw=true "Chat rooms collection")
        

    * To display the user's name and the last message sent:
      * Add `Column`
      * Inside the `Column` add two text widgets

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-user-name-last-mesage.png?raw=true "Chat rooms collection")

        * (top text widget) set its value to user's display name

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-user-display-name.png?raw=true "Chat rooms collection")
                
        * (bottom text widget) set its value to chat_rooms last message

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-last-mesage.png?raw=true "Chat rooms collection")

    * To display the chat_rooms last message timestamp
      * Add `Column`
      * Inside the `Column` add text widget
      * Set text widget's value to chat_rooms `lastMessageSentAt` timestamp with a format of `M/d h:mm a`

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-last-mesage-timestamp.png?raw=true "Chat rooms collection")

      * Add conditional visibility to check if the lastMessageSent is set

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-sing-chat-last-message-timestamp-visibility.png?raw=true "Chat rooms collection")

            


  * (group chat container)
    * Add conditional visibility as the `Num List Items` of `monderatorUserDocumentReferences` is greater than 0.

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-condition-group-chat.jpg?raw=true "Chat rooms collection")

    * Inside the `Container` add `Row`

    * Inside the `Row` add `Container`

    * Inside the `Container` add `Row` again

    * Inside the `Row` you can now add a widget to display the users' photos and text widgets to display group chat's last message and the time it was sent

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-grouchat-row.png?raw=true "Chat rooms collection")

    ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-grouchat-row-2.png?raw=true "Chat rooms collection")

    * To display the group chat's two users' photos:
      * Add `Stack` to the `Row`
      * Inside the `Stack` add two image widget or custom widget to display the group chat's two users' photos (the first photo will display the last message sender photo and the second photo will display the last person who entered the chat room)

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-stack-group-chat-two-users-photos.png?raw=true "Chat rooms collection")

      * To display the last message sender photo:
        * Add `Backend Query`
        * `Query Collection`
        * Collection Field to `users_public_data`
        * Query Type to `Single Document`
        * Add a filter
          * Collection Field Name to `userDocumentReference`
          * Relation to `Equal To`
          * Vaue Source to `lastMessageSentBy`

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-group-chat-last-message-user-photo.png?raw=true "Chat rooms collection")

        * Add conditional visibility by checking if the `lastMessageSentBy` field is set.

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-last-message-user-photo-conditional-visibility.png?raw=true "Chat rooms collection")

      * To display the last person photo who entered the chat room:
        * Add `Backend Query`
        * `Query Collection`
        * `Collection Field` to users_public_data
        * `Query Type` to `Single Document`
        * Add a `Filter`
          * `Collection Field Name` to `userDocumentReference`
          * `Relation` to `Equal To`
          * `Vaue Source` to custom function named `userDocumentReferenceOfChatRoomLastEnter` and set its parameter:
            * `chatRoom` equal to `chat_rooms Document`

      Note if the chat room don't have any user yet or it has only one user yet, then the photo of the creator of the chatroom will be displayed. Furthermore, since the first image widget will display the photo of the last message sender, if the last message sender is the same with the last person who entered the chat room, the photo of the predecessor of the last person who entered the chat room will be displayed to avoid displaying the same image on the two image widgets.

      ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-last-enter-user-photo-backend-query.png?raw=true "Chat rooms collection")

      * To display the number of users in the group chat room:
        * Add `Container`
        * Inside the `Container` add `Text widget`
        * Set the `text widget's value` to the number of `userDocumentReferences` inside the chat_rooms document

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-number-of-users.png?raw=true "Chat rooms collection")
                
      * To display the group chat's title and the last message sent:
        * Add `Column`
        * Inside the `Column` add two text widgets

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-title-last-message-sent-column.png?raw=true "Chat rooms collection")

          * (top text widget) set its value to chat_rooms title

          ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-title-text.png?raw=true "Chat rooms collection")

          * (bottom text widget) set its value to chat_rooms last message

          ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-last-message-text.png?raw=true "Chat rooms collection")

      * To display the chat_rooms last message timestamp:
        * Add `Column` to the `Row`
        * Inside the `Column` add text widget
        * Set text widget's value to chat_rooms `lastMessageSentAt` timestamp with a format of M/d h:mm a

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-column-sing-chat-last-mesage-timestamp.png?raw=true "Chat rooms collection")

        * Add conditional visibility to check if the `lastMessageSent` is set

        ![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-group-chat-last-message-timestamp-visibility.png?raw=true "Chat rooms collection")


### How to display menu when the chat message has tapped.

* Create a component that will accept `chatRoomMessageDocument` as parameter.
* Inside the component, put some widgets that will display the menu actions such as copy, edit, delete, open, etc.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat-chat-message-menu-component.png?raw=true "Chat rooms collection")

* Inside the chat room, when the message has been tapped, open the component created above as a bottom sheet and pass the `chatRoomMessageDocument`.

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-chat_room-message-tapped.png?raw=true "Chat rooms collection")





### How to leave a group chat room.

1. Close the dialog or drawer (if the button to leave the chat room is in a dialog or drawer)
2. Call the leave method of the ChatService and pass the chat room's document reference
3. Navigate to chat page with the replace route option enabled



### How to display an uploaded file.

1. Call the FireFlow DisplayMedia widget
2. Pass the required parameters such as width, height and url

### How to not invite the same user.

- When the user document reference is already in the chat room userDocumentReferences

### How to display the protocol message.

- When someone invited.
- When someone removed.
- When someone leave.

### How to remove a user


### How to receive and display the push notifications while the app is foreground.

### How to display the number of chat rooms with new messages.

- Use `ChatNoOfRoomsWithNewMessage` widget like below.

```dart
import 'package:fireflow/fireflow.dart';

class NoOfNewChatRoom extends StatefulWidget {
  const NoOfNewChatRoom({
    Key? key,
    this.width,
    this.height,
    this.textSize,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double? textSize;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  _NoOfNewChatRoomState createState() => _NoOfNewChatRoomState();
}

class _NoOfNewChatRoomState extends State<NoOfNewChatRoom> {
  @override
  Widget build(BuildContext context) {
    return ChatNoOfRoomsWithNewMessage(
      width: widget.width,
      height: widget.height,
      textSize: widget.textSize,
      backgroundColor: widget.backgroundColor,
      textColor: widget.textColor,
    );
  }
}
```

![Image Link](https://github.com/withcenter/fireflow/blob/main/etc/readme/img/ff-new-chat-room.jpg?raw=true "No of new chat rooms")


- It is counted by the number of rooms, not by the number of messages.
- It is done in steps, 
  - Listen for the changes of my chat rooms,
  - Count the number of rooms that don’t have my user document reference in `lastMessageSeenBy` field.




### How to query to the Open AI - GPT.

- If you don't want to implement GPT query, simply don't add the Open AI key and don't put options for GPT query.

### How to change chat room title



### How to send chat message

When a user inputs and sends a message, simply call the `ChatService.instance.sendMessage()` method.
You can create a custom action `onChatMessageSubmit` that wraps the `ChatService.instance.sendMessage()` method.

```dart
import 'package:fireflow/fireflow.dart';

// Get document (Not reference) to make it easy on UI builder.
Future chatSendMessage(
  UsersPublicDataRecord? otherUserPublicDataDocument,
  ChatRoomsRecord? chatRoomDocument,
  String? text,
  String? uploadUrl,
) async {
  // Add your function code here!

  // Note, don't wait for the message to be sent. So, it will perform faster.
  return ChatService.instance.sendMessage(
    otherUserDocumentReference: otherUserPublicDataDocument?.reference,
    chatRoomDocumentReference: chatRoomDocument?.reference,
    text: text,
    uploadUrl: uploadUrl,
  );
}
```

### How to update chat message

When a user updates a message, simply call the `ChatService.instance.updateMessage()` method.
You can create a custom action `onChatMessageUpdate` that wraps the `ChatService.instance.updateMessage()` method.

```dart
import 'package:fireflow/fireflow.dart';

// Get document (Not reference) to make it easy on UI builder.
Future chatSendMessage(
  UsersPublicDataRecord? otherUserPublicDataDocument,
  ChatRoomsRecord? chatRoomDocument,
  String? text,
  String? uploadUrl,
) async {
  // Add your function code here!

  // Note, don't wait for the message to be sent. So, it will perform faster.
  return ChatService.instance.sendMessage(
    otherUserDocumentReference: otherUserPublicDataDocument?.reference,
    chatRoomDocumentReference: chatRoomDocument?.reference,
    text: text,
    uploadUrl: uploadUrl,
  );
}
```






### How to create a group chat

Create `chat_rooms` document with fields and values of
moderatorUserDocumentReference as the creator’s reference
title as the title of the chat room
userDocumentReferences with the create’s reference.
lastMessageSentAt with Current Time (Not Firestore server timestamp)

Save the created document to `createdChatRoom` as action output


And navigate ChatRoom screen passing the `createdChatRoom` as chatRoomDocument parameter.



## Chat Design


### ChatRoomProtocolMessage




## Chat message count

- Fireflow counts the no of chat message that a user sent. The count increases on every minutes. It's 60 seconds by default. You can change it in config.dart
  - For instance, when the user sends a message for the first after app boots, it will not count. After the first message, it will count after a minutes if the user chats again. and from there it will count on every minutes. It will only increase by 1 even if the user sends chat messages more than 1 in a minute.

- The no of count is saved in `/users_public_data/<uid> { chatMessageCount: xx }`.
- You can use it for leveling user's activity or whatever.



# 파일 업로드, 사진 업로드

- Fireflow 에서 파일 또는 사진 업로드 기본 기능을 제공하는데, 그 파일 구조는 FF 와 동일하다.


# 신고

- 글, 코멘트, 사용자, 채팅 메시지 등에 대해서 신고를 할 수 있다.
- 신고를 할 때에는 신고되는 문서의 id 와 나의 uid 를 조합해서, 고유한 문서에 저장한다. 즉, 중복 신고를 하지 않는다.


# 다국어

- 코드는 소문자만 사용 할 수 있다. 대문자를 입력해도 자동으로 소문자가 된다.

- 관리자 페이지에서 다국어 번역문을 저장 할 때, 아래와 같이 `#name`, `#uid` 와 같이 치환 단어를 쓸 수 있다.
```txt
  en: Your name is #name. UID: #uid.
  ko: 회원님의 이름은 #name입니다. (#uid)
```
이렇게 입력하면, `#xxx` 에 맞는 적절하게 치환 단어가 표시된다. 이 때, 각 언어 코드 별 치환 단어가 어떤 것이 있는지는 아래 목록을 참고한다.

## 단국어 코드 별 치환단어

|코드|치환단어|뜻|예|
|--------|--------------|----|----|
|your_name_is|#name, #uid|회원의 이름을 표시|회원님의 이름은 #name입니다.|
|followed|#name|팔로우 한 경우|#name님을 팔로우했습니다.|
|unfollowed|#name|팔로우 해제 한 경우|#name님을 팔로우 해제했습니다.|
|no_item_in_follow_list| | 팔로우 한 회원이 없는 경우 | 아직 다른 회원을 팔로잉하고 있지 않습니다. |
|no_item_in_block_list| | 블럭 한 회원이 없는 경우 | 아직 다른 회원을 차단하지 않았습니다. |
|no_item_in_favorite_list| | 즐겨찾기 항목이 없는 경우 | 아직 즐겨찾기 항목이 없습니다. |




# 즐겨찾기

- 즐겨찾기(favorite)는 각 사용자 마다 다시 보고 싶은 글, 코멘트, 프로필 등을 따로 모아 놓는 것이다.
  - 참고로, 채팅방 즐겨찾기는 /users 컬렉션에 직접 기록된다.


- 스키마 etc/schema/favorite.md 참고

- `type` 은 자동으로 각 컬렉션의 이름을 따서 `users`, `posts`, `comments` 중 하나가 된다. 그래서, `type` 필드는 컬렉션 이름이라고 생각을 해도 된다.







