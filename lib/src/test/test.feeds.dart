import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.utils.dart';

Future testFeeds() async {
  await loginA();
  await wait();
  await clearFeeds();
  await createPost(title: '1');
  await loginB();

  await UserService.instance.clearFollowings();
  // await UserService.instance.follow(TestConfig.a.ref);

  final feeds = await UserService.instance.feeds();
  assert(feeds.length == 1, 'Feeds must have 1 item');

  await loginC();
  await wait();
  await clearFeeds();
  await createPost(title: '2');
  await createPost(title: '3');
  await wait();
  await loginB();
  await wait();
  // await UserService.instance.follow(TestConfig.c.ref);

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

  List<Map<String, dynamic>> json = await UserService.instance.jsonFeeds();
  assert(json.length == 4, 'Feeds must have 4 items');
  assert(
      json.first['title'] == feeds3.first.title && json.first['title'] == '4',
      'The first feed title must be letter 4');

  json = await UserService.instance.jsonFeeds(noOfFollowers: 1);
  assert(json.length == 2, 'Feeds must have 2 items');
  assert(json[1]['title'] == '1', 'The last feed title must be letter 1');
}
