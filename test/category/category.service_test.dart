import 'package:flutter_test/flutter_test.dart';

import 'package:fireflow/fireflow.dart';

void main() async {
  test('Category Model', () {
    final category = CategoryModel(
      category: 'id',
      title: 'name',
      noOfPosts: 0,
      noOfComments: 0,
      enablePushNotificationSubscription: false,
      emphasizePremiumUserPost: false,
      waitMinutesForNextPost: 0,
      waitMinutesForPremiumUserNextPost: 0,
      ref: CategoryService.instance.doc('id'),
    );
    expect(category.category, 'id');
  });
}
