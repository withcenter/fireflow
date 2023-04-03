import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.config.dart';

Future testFeeds() async {
  await loginA();
  await wait();
  await UserService.instance.clearFeeds();
  await createPost(title: '1');
  await loginB();

  await UserService.instance.clearFollowings();
  await UserService.instance.follow(TestConfig.a.reference);

  final feeds = await UserService.instance.feeds();
  assert(feeds.length == 1, 'Feeds must have 1 item');

  await loginC();
  await wait();
  await UserService.instance.clearFeeds();
  await createPost(title: '2');
  await createPost(title: '3');
  await wait();
  await loginB();
  await wait();
  await UserService.instance.follow(TestConfig.c.reference);

  final feeds2 = await UserService.instance.feeds();
  assert(feeds2.length == 3, 'Feeds must have 3 items');

  await loginA();
  await wait();
  await createPost(title: '4');
  await wait();
  await loginB();
  await wait();

  final feeds3 = await UserService.instance.feeds();
  assert(feeds3.length == 4, 'Feeds must have 4 items');

  assert(feeds3.first.title == '4', 'The first feed title must be letter 4');
  assert(feeds3[1].title == '3', 'The second feed title must be letter 3');
  assert(feeds3[2].title == '2', 'The third feed title must be letter 2');
  assert(feeds3.last.title == '1', 'The last feed title must be letter 1');

  List<FeedModel> feeds4 = await UserService.instance.feeds();
  assert(feeds4.length == 4, 'Feeds must have 4 items');
  assert(feeds4.first.title == feeds3.first.title && feeds4.first.title == '4',
      'The first feed title must be letter 4');

  feeds4 = await UserService.instance.feeds(noOfFollowers: 1);
  assert(feeds4.length == 2, 'Feeds must have 2 items');
  assert(feeds4[1].title == '1', 'The last feed title must be letter 1');
}
