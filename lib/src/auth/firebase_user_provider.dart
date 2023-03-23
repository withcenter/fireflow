import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUserProvider {
  FirebaseUserProvider(this.user);
  User? user;
  bool get loggedIn => user != null;
}

FirebaseUserProvider? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;

// 사용자 로그인 상태 변경 감지.
// 아래는 stream 일 뿐, 실제 listen 하지 않는다. main.dart 에서 mount 한다.
Stream<FirebaseUserProvider> firebaseUserProviderStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<FirebaseUserProvider>(
      (user) {
        currentUser = FirebaseUserProvider(user);
        return currentUser!;
      },
    );
