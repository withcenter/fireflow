import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.config.dart';
import 'package:fireflow/src/test/test.utils.dart';

Future testFeeds() async {
  await loginA();
  await wait();
  await createPost();
  await loginB();
  await await UserService.instance.follow(TestConfig.b.ref);

  final feeds = await UserService.instance.feeds();

  dog('Got ${feeds.length} feeds');
}
