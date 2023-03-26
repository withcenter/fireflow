import 'dart:async';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'categories_record.g.dart';

abstract class CategoriesRecord
    implements Built<CategoriesRecord, CategoriesRecordBuilder> {
  static Serializer<CategoriesRecord> get serializer =>
      _$categoriesRecordSerializer;

  String get categoryId;

  String get title;

  int get noOfPosts;

  int get noOfComments;

  bool get enablePushNotificationSubscription;

  bool get emphasizePremiumUserPost;

  int get waitMinutesForNextPost;

  int get waitMinutesForPremiumUserNextPost;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(CategoriesRecordBuilder builder) => builder
    ..categoryId = ''
    ..title = ''
    ..noOfPosts = 0
    ..noOfComments = 0
    ..enablePushNotificationSubscription = false
    ..emphasizePremiumUserPost = false
    ..waitMinutesForNextPost = 0
    ..waitMinutesForPremiumUserNextPost = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('categories');

  static Stream<CategoriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<CategoriesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  CategoriesRecord._();
  factory CategoriesRecord([void Function(CategoriesRecordBuilder) updates]) =
      _$CategoriesRecord;

  static CategoriesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createCategoriesRecordData({
  String? categoryId,
  String? title,
  int? noOfPosts,
  int? noOfComments,
  bool? enablePushNotificationSubscription,
  bool? emphasizePremiumUserPost,
  int? waitMinutesForNextPost,
  int? waitMinutesForPremiumUserNextPost,
}) {
  final firestoreData = serializers.toFirestore(
    CategoriesRecord.serializer,
    CategoriesRecord(
      (c) => c
        ..categoryId = categoryId
        ..title = title
        ..noOfPosts = noOfPosts
        ..noOfComments = noOfComments
        ..enablePushNotificationSubscription =
            enablePushNotificationSubscription
        ..emphasizePremiumUserPost = emphasizePremiumUserPost
        ..waitMinutesForNextPost = waitMinutesForNextPost
        ..waitMinutesForPremiumUserNextPost = waitMinutesForPremiumUserNextPost,
    ),
  );

  return firestoreData;
}
