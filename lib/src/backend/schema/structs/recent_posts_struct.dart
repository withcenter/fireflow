import '../serializers.dart';
import 'package:built_value/built_value.dart';

part 'recent_posts_struct.g.dart';

abstract class RecentPostsStruct
    implements Built<RecentPostsStruct, RecentPostsStructBuilder> {
  static Serializer<RecentPostsStruct> get serializer =>
      _$recentPostsStructSerializer;

  DocumentReference? get postDocumentReference;

  DateTime? get createdAt;

  String? get title;

  String? get content;

  String? get photoUrl;

  /// Utility class for Firestore updates
  FirestoreUtilData get firestoreUtilData;

  static void _initializeBuilder(RecentPostsStructBuilder builder) => builder
    ..title = ''
    ..content = ''
    ..photoUrl = ''
    ..firestoreUtilData = const FirestoreUtilData();

  RecentPostsStruct._();
  factory RecentPostsStruct([void Function(RecentPostsStructBuilder) updates]) =
      _$RecentPostsStruct;
}

RecentPostsStruct createRecentPostsStruct({
  DocumentReference? postDocumentReference,
  DateTime? createdAt,
  String? title,
  String? content,
  String? photoUrl,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    RecentPostsStruct(
      (r) => r
        ..postDocumentReference = postDocumentReference
        ..createdAt = createdAt
        ..title = title
        ..content = content
        ..photoUrl = photoUrl
        ..firestoreUtilData = FirestoreUtilData(
          clearUnsetFields: clearUnsetFields,
          create: create,
          delete: delete,
          fieldValues: fieldValues,
        ),
    );

RecentPostsStruct? updateRecentPostsStruct(
  RecentPostsStruct? recentPosts, {
  bool clearUnsetFields = true,
}) =>
    recentPosts != null
        ? (recentPosts.toBuilder()
              ..firestoreUtilData =
                  FirestoreUtilData(clearUnsetFields: clearUnsetFields))
            .build()
        : null;

void addRecentPostsStructData(
  Map<String, dynamic> firestoreData,
  RecentPostsStruct? recentPosts,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (recentPosts == null) {
    return;
  }
  if (recentPosts.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && recentPosts.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final recentPostsData =
      getRecentPostsFirestoreData(recentPosts, forFieldValue);
  final nestedData =
      recentPostsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = recentPosts.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);

  return;
}

Map<String, dynamic> getRecentPostsFirestoreData(
  RecentPostsStruct? recentPosts, [
  bool forFieldValue = false,
]) {
  if (recentPosts == null) {
    return {};
  }
  final firestoreData =
      serializers.toFirestore(RecentPostsStruct.serializer, recentPosts);

  // Add any Firestore field values
  recentPosts.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getRecentPostsListFirestoreData(
  List<RecentPostsStruct>? recentPostss,
) =>
    recentPostss?.map((r) => getRecentPostsFirestoreData(r, true)).toList() ??
    [];
