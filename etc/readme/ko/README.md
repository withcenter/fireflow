
![Image Link](https://github.com/withcenter/fireflow/blob/main/res/fireflow-logo.jpg?raw=true "This is image title")

[English](https://github.com/withcenter/fireflow/blob/main/README.md) | [한국어](https://github.com/withcenter/fireflow/blob/main/etc/readme/ko/README.md)


# FireFlow

- 버전 0.0 과 버전 0.1. 에는 큰 차이가 있다. 특히, 핵심 코드 및 컬렉션 구조가 바뀌어서, 0.0 버전과는 호환이 되지 않는다.
- Fireflow 는 FlutterFlow(이하, FF) 를 지원하기 위해서 만들어진 것이다. 그래서, FlutterFlow 와 가능한 많이 호환되도록, 가능한 많이 FlutterFlow 의 컨셉을 따라 하도록 노력했다. 다만, Flutter 를 사용 할 때에는 Fireflow 를 사용하면 된다.
- 버전 0.1 에서는 기본 위젯을 모두 제공한다. 그래서, 빠르게 앱을 빌드하기 위해서는 기본 제공 위젯을 Custom Widget 으로 연결하면 된다. 그 후 천천히 UI 를 커스터마이징하면 된다.
- 혹시, 버전 0.0.x 대의 소스 코드를 원하시는 분이 있으면, [0.0.x branch](https://github.com/withcenter/fireflow/tree/0.0.x) 를 참고하면 된다.


- [FireFlow](#fireflow)
- [사용자](#사용자)- [FireFlow](#fireflow)
- [사용자](#사용자)
  - [사용자 계정 생성, 수정, 삭제](#사용자-계정-생성-수정-삭제)
  - [UserService.instance.my](#userserviceinstancemy)
  - [UserService.instance.pub](#userserviceinstancepub)
  - [사용자 정보 업데이트 할 때 위젯 빌드](#사용자-정보-업데이트-할-때-위젯-빌드)
    - [MyDoc 과 PubDoc](#mydoc-과-pubdoc)
    - [MyStream](#mystream)
  - [사용자가 로그인을 할 때 위젯 rebuild 및 사용자 정보 업데이트](#사용자가-로그인을-할-때-위젯-rebuild-및-사용자-정보-업데이트)
    - [loggedIn, currentUser 와 firebaseUserProviderStream](#loggedin-currentuser-와-firebaseuserproviderstream)
- [채팅](#채팅)
  - [DocumentSnapshot 을 Schema Document 로 변경](#documentsnapshot-을-schema-document-로-변경)
  - [채팅방 입장](#채팅방-입장)
  - [채팅방 메시지 목록](#채팅방-메시지-목록)
    - [기본 디자인 사용](#기본-디자인-사용)
    - [각각의 요소를 개별 디자인](#각각의-요소를-개별-디자인)
    - [전체 디자인을 하나의 커스텀 컴포넌트로 연결](#전체-디자인을-하나의-커스텀-컴포넌트로-연결)
- [파일 업로드, 사진 업로드](#파일-업로드-사진-업로드)


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


- moveUserData 기능 동작 확인
- `/backend/schema` 폴더에 있는 schema 를 없애고 대신 나만의 BuiltValue 코딩을 한다. 굳이, `getDocumentFromData()` 이런 것 없어도 된다. 직접 할 수 있는 것 까지만 하면 된다. Service 를 활용하면된다.
  - 왜냐하면, FF 에서 코드를 자동 생성되다 보니 좀 BuiltValue 가 깨끝하지 못하고, 필요 없는 코드가 복잡하게 얽혀져 있다.

- 채팅창에 명령어
  - /ai 너는 누구냐?
  - /image give me apples and bananas
  - /api https://philgo.com/etc/api.php
  와 같이 특별 명령을 하면, `onCommand( message ) => Container(...UI Design...)` 가 실행되고, 직접 원하는 커스텀 코드를 수행하고, 결과를 UI 로 보여주게 한다.


- Favorite(북마크, 즐겨찾기)는 별도의 컬렉션을 만들어서, 사용자, 글, 코멘트를 favorite 할 수 있게 한다.
- 단, 채팅방 favorite 은 /users 컬렉션에 보관한다.
- 코멘트, 사용자, 채팅메세지 신고 기능.
  - 신고 목록
  - 신고 삭제
  - 관리자가 신고 확인.


- Supabase 키를 key.dart 파일에 저장하지 말고, 관리자 페이지에서 직접 입력 할 수 있도록 한다. 그리고 system_settings/keys 에 보관한다.



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
  - 

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


# 파일 업로드, 사진 업로드

- Fireflow 에서 파일 또는 사진 업로드 기본 기능을 제공하는데, 그 파일 구조는 FF 와 동일하다.


# 신고

- 글, 코멘트, 사용자, 채팅 메시지 등에 대해서 신고를 할 수 있다.
- 신고를 할 때에는 신고되는 문서의 id 와 나의 uid 를 조합해서, 고유한 문서에 저장한다. 즉, 중복 신고를 하지 않는다.


# 다국어

- 코드는 소문자만 사용 할 수 있다. 대문자를 입력해도 자동으로 소문자가 된다.