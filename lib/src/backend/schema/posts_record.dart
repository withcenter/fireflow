import 'dart:async';

import 'package:fireflow/fireflow.dart';

import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'posts_record.g.dart';

abstract class PostsRecord implements Built<PostsRecord, PostsRecordBuilder> {
  static Serializer<PostsRecord> get serializer => _$postsRecordSerializer;

  String get category;

  String get postId;

  DocumentReference get userDocumentReference;

  DateTime get createdAt;

  DateTime get updatedAt;

  String get title;

  String get content;

  bool get hasPhoto;

  int get noOfComments;

  bool get hasComment;

  bool get deleted;

  BuiltList<DocumentReference> get likes;

  int get noOfLikes;

  bool get hasLike;

  bool get wasPremiumUser;

  bool get emphasizePremiumUser;

  BuiltList<String> get files;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(PostsRecordBuilder builder) => builder
    ..category = ''
    ..postId = ''
    ..title = ''
    ..content = ''
    ..hasPhoto = false
    ..noOfComments = 0
    ..hasComment = false
    ..deleted = false
    ..likes = ListBuilder()
    ..noOfLikes = 0
    ..hasLike = false
    ..wasPremiumUser = false
    ..emphasizePremiumUser = false
    ..files = ListBuilder()
    ..createdAt = DateTime(1973, 1, 1)
    ..updatedAt = DateTime(1973, 1, 1);

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<PostsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  PostsRecord._();
  factory PostsRecord([void Function(PostsRecordBuilder) updates]) =
      _$PostsRecord;

  static PostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createPostsRecordData({
  String? category,
  String? postId,
  DocumentReference? userDocumentReference,
  DateTime? createdAt,
  DateTime? updatedAt,
  String? title,
  String? content,
  bool? hasPhoto,
  int? noOfComments,
  bool? hasComment,
  bool? deleted,
  int? noOfLikes,
  bool? hasLike,
  bool? wasPremiumUser,
  bool? emphasizePremiumUser,
}) {
  final firestoreData = serializers.toFirestore(
    PostsRecord.serializer,
    PostsRecord(
      (p) => p
        ..category = category
        ..postId = postId
        ..userDocumentReference = userDocumentReference
        ..createdAt = createdAt
        ..updatedAt = updatedAt
        ..title = title
        ..content = content
        ..hasPhoto = hasPhoto
        ..noOfComments = noOfComments
        ..hasComment = hasComment
        ..deleted = deleted
        ..likes = null
        ..noOfLikes = noOfLikes
        ..hasLike = hasLike
        ..wasPremiumUser = wasPremiumUser
        ..emphasizePremiumUser = emphasizePremiumUser
        ..files = null,
    ),
  );

  return firestoreData;
}
