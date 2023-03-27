import 'package:flutter_test/flutter_test.dart';

import 'package:fireflow/fireflow.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() async {
  test('Category Model', () {
    CategoryService.instance.firestore = FakeFirebaseFirestore();
    final category = CategoryModel(
      reference: CategoryService.instance.doc('id'),
      id: 'id',
      categoryId: 'id',
      title: 'name',
      noOfPosts: 0,
      noOfComments: 0,
      enablePushNotificationSubscription: false,
      emphasizePremiumUserPost: false,
      waitMinutesForNextPost: 0,
      waitMinutesForPremiumUserNextPost: 0,
      displayCategoryInForm: false,
      readOnly: false,
    );
    expect(category.categoryId, 'id');
  });
}
