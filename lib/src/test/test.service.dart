import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.feeds.dart';
import 'package:fireflow/src/test/test.follow.dart';
import 'package:fireflow/src/test/test.supabase.search.dart';
import 'package:fireflow/src/test/test.utils.dart';

class TestService {
  static final TestService instance = _instance ??= TestService();
  static TestService? _instance;
  TestService();

  Future run() async {
    gDebug = true;
    await prepareUsers();
    await clear();

    await follow();
    await feeds();
  }

  Future follow() async {
    await prepareUsers();
    await clear();
    await testFollow();
  }

  Future feeds() async {
    await prepareUsers();
    await clear();
    await testFeeds();
  }

  Future supabaseSearch() async {
    await testSupabaseSearch();
  }

  /// Prepare test.
  ///
  /// Call this only one time if the test has been run before.
  Future prepare() async {
    dog('Prepare test. Create test users.');
    await loginA();
    await wait(1000);
    await loginB();
    await wait(1000);
    await loginC();
    await wait(1000);
    await loginD();
    await wait(1000);
    await loginAsAdmin();
    await wait();
  }
}
