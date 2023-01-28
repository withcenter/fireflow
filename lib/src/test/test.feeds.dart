import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.config.dart';
import 'package:fireflow/src/test/test.utils.dart';

Future testFeeds() async {
  await loginA();
  await wait();
  await clearFeeds();
  await createPost();
  await loginB();

  await UserService.instance.clearFollowings();
  await UserService.instance.follow(TestConfig.a.ref);

  final feeds = await UserService.instance.feeds();
  assert(feeds.length == 1, 'Feeds must have 1 item');
}
