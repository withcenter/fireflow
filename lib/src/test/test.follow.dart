import 'package:fireflow/fireflow.dart';
import 'package:fireflow/src/test/test.utils.dart';

Future testFollow() async {
  await loginA();
  await UserService.instance.clearFollowings();
  // UserPublicDataModel? user = await UserService.instance.getPublicData();
  // assert(user!.followings.isEmpty, 'Followings must be empty');

  // await UserService.instance.follow(TestConfig.b.ref);
  // user = await UserService.instance.getPublicData();
  // assert(user!.followings.length == 1, 'Followings must have 1 item');

  await UserService.instance.clearFollowings();
}
