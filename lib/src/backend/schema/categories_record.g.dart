// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CategoriesRecord> _$categoriesRecordSerializer =
    new _$CategoriesRecordSerializer();

class _$CategoriesRecordSerializer
    implements StructuredSerializer<CategoriesRecord> {
  @override
  final Iterable<Type> types = const [CategoriesRecord, _$CategoriesRecord];
  @override
  final String wireName = 'CategoriesRecord';

  @override
  Iterable<Object?> serialize(Serializers serializers, CategoriesRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'categoryId',
      serializers.serialize(object.categoryId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'noOfPosts',
      serializers.serialize(object.noOfPosts,
          specifiedType: const FullType(int)),
      'noOfComments',
      serializers.serialize(object.noOfComments,
          specifiedType: const FullType(int)),
      'enablePushNotificationSubscription',
      serializers.serialize(object.enablePushNotificationSubscription,
          specifiedType: const FullType(bool)),
      'emphasizePremiumUserPost',
      serializers.serialize(object.emphasizePremiumUserPost,
          specifiedType: const FullType(bool)),
      'waitMinutesForNextPost',
      serializers.serialize(object.waitMinutesForNextPost,
          specifiedType: const FullType(int)),
      'waitMinutesForPremiumUserNextPost',
      serializers.serialize(object.waitMinutesForPremiumUserNextPost,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.ffRef;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType.nullable(Object)])));
    }
    return result;
  }

  @override
  CategoriesRecord deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CategoriesRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'categoryId':
          result.categoryId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'noOfPosts':
          result.noOfPosts = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'noOfComments':
          result.noOfComments = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'enablePushNotificationSubscription':
          result.enablePushNotificationSubscription = serializers
              .deserialize(value, specifiedType: const FullType(bool))! as bool;
          break;
        case 'emphasizePremiumUserPost':
          result.emphasizePremiumUserPost = serializers.deserialize(value,
              specifiedType: const FullType(bool))! as bool;
          break;
        case 'waitMinutesForNextPost':
          result.waitMinutesForNextPost = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
        case 'waitMinutesForPremiumUserNextPost':
          result.waitMinutesForPremiumUserNextPost = serializers
              .deserialize(value, specifiedType: const FullType(int))! as int;
          break;
        case 'Document__Reference__Field':
          result.ffRef = serializers.deserialize(value,
              specifiedType: const FullType(DocumentReference, const [
                const FullType.nullable(Object)
              ])) as DocumentReference<Object?>?;
          break;
      }
    }

    return result.build();
  }
}

class _$CategoriesRecord extends CategoriesRecord {
  @override
  final String categoryId;
  @override
  final String title;
  @override
  final int noOfPosts;
  @override
  final int noOfComments;
  @override
  final bool enablePushNotificationSubscription;
  @override
  final bool emphasizePremiumUserPost;
  @override
  final int waitMinutesForNextPost;
  @override
  final int waitMinutesForPremiumUserNextPost;
  @override
  final DocumentReference<Object?>? ffRef;

  factory _$CategoriesRecord(
          [void Function(CategoriesRecordBuilder)? updates]) =>
      (new CategoriesRecordBuilder()..update(updates))._build();

  _$CategoriesRecord._(
      {required this.categoryId,
      required this.title,
      required this.noOfPosts,
      required this.noOfComments,
      required this.enablePushNotificationSubscription,
      required this.emphasizePremiumUserPost,
      required this.waitMinutesForNextPost,
      required this.waitMinutesForPremiumUserNextPost,
      this.ffRef})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        categoryId, r'CategoriesRecord', 'categoryId');
    BuiltValueNullFieldError.checkNotNull(title, r'CategoriesRecord', 'title');
    BuiltValueNullFieldError.checkNotNull(
        noOfPosts, r'CategoriesRecord', 'noOfPosts');
    BuiltValueNullFieldError.checkNotNull(
        noOfComments, r'CategoriesRecord', 'noOfComments');
    BuiltValueNullFieldError.checkNotNull(enablePushNotificationSubscription,
        r'CategoriesRecord', 'enablePushNotificationSubscription');
    BuiltValueNullFieldError.checkNotNull(emphasizePremiumUserPost,
        r'CategoriesRecord', 'emphasizePremiumUserPost');
    BuiltValueNullFieldError.checkNotNull(
        waitMinutesForNextPost, r'CategoriesRecord', 'waitMinutesForNextPost');
    BuiltValueNullFieldError.checkNotNull(waitMinutesForPremiumUserNextPost,
        r'CategoriesRecord', 'waitMinutesForPremiumUserNextPost');
  }

  @override
  CategoriesRecord rebuild(void Function(CategoriesRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CategoriesRecordBuilder toBuilder() =>
      new CategoriesRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CategoriesRecord &&
        categoryId == other.categoryId &&
        title == other.title &&
        noOfPosts == other.noOfPosts &&
        noOfComments == other.noOfComments &&
        enablePushNotificationSubscription ==
            other.enablePushNotificationSubscription &&
        emphasizePremiumUserPost == other.emphasizePremiumUserPost &&
        waitMinutesForNextPost == other.waitMinutesForNextPost &&
        waitMinutesForPremiumUserNextPost ==
            other.waitMinutesForPremiumUserNextPost &&
        ffRef == other.ffRef;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, categoryId.hashCode),
                                    title.hashCode),
                                noOfPosts.hashCode),
                            noOfComments.hashCode),
                        enablePushNotificationSubscription.hashCode),
                    emphasizePremiumUserPost.hashCode),
                waitMinutesForNextPost.hashCode),
            waitMinutesForPremiumUserNextPost.hashCode),
        ffRef.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CategoriesRecord')
          ..add('categoryId', categoryId)
          ..add('title', title)
          ..add('noOfPosts', noOfPosts)
          ..add('noOfComments', noOfComments)
          ..add('enablePushNotificationSubscription',
              enablePushNotificationSubscription)
          ..add('emphasizePremiumUserPost', emphasizePremiumUserPost)
          ..add('waitMinutesForNextPost', waitMinutesForNextPost)
          ..add('waitMinutesForPremiumUserNextPost',
              waitMinutesForPremiumUserNextPost)
          ..add('ffRef', ffRef))
        .toString();
  }
}

class CategoriesRecordBuilder
    implements Builder<CategoriesRecord, CategoriesRecordBuilder> {
  _$CategoriesRecord? _$v;

  String? _categoryId;
  String? get categoryId => _$this._categoryId;
  set categoryId(String? categoryId) => _$this._categoryId = categoryId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _noOfPosts;
  int? get noOfPosts => _$this._noOfPosts;
  set noOfPosts(int? noOfPosts) => _$this._noOfPosts = noOfPosts;

  int? _noOfComments;
  int? get noOfComments => _$this._noOfComments;
  set noOfComments(int? noOfComments) => _$this._noOfComments = noOfComments;

  bool? _enablePushNotificationSubscription;
  bool? get enablePushNotificationSubscription =>
      _$this._enablePushNotificationSubscription;
  set enablePushNotificationSubscription(
          bool? enablePushNotificationSubscription) =>
      _$this._enablePushNotificationSubscription =
          enablePushNotificationSubscription;

  bool? _emphasizePremiumUserPost;
  bool? get emphasizePremiumUserPost => _$this._emphasizePremiumUserPost;
  set emphasizePremiumUserPost(bool? emphasizePremiumUserPost) =>
      _$this._emphasizePremiumUserPost = emphasizePremiumUserPost;

  int? _waitMinutesForNextPost;
  int? get waitMinutesForNextPost => _$this._waitMinutesForNextPost;
  set waitMinutesForNextPost(int? waitMinutesForNextPost) =>
      _$this._waitMinutesForNextPost = waitMinutesForNextPost;

  int? _waitMinutesForPremiumUserNextPost;
  int? get waitMinutesForPremiumUserNextPost =>
      _$this._waitMinutesForPremiumUserNextPost;
  set waitMinutesForPremiumUserNextPost(
          int? waitMinutesForPremiumUserNextPost) =>
      _$this._waitMinutesForPremiumUserNextPost =
          waitMinutesForPremiumUserNextPost;

  DocumentReference<Object?>? _ffRef;
  DocumentReference<Object?>? get ffRef => _$this._ffRef;
  set ffRef(DocumentReference<Object?>? ffRef) => _$this._ffRef = ffRef;

  CategoriesRecordBuilder() {
    CategoriesRecord._initializeBuilder(this);
  }

  CategoriesRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categoryId = $v.categoryId;
      _title = $v.title;
      _noOfPosts = $v.noOfPosts;
      _noOfComments = $v.noOfComments;
      _enablePushNotificationSubscription =
          $v.enablePushNotificationSubscription;
      _emphasizePremiumUserPost = $v.emphasizePremiumUserPost;
      _waitMinutesForNextPost = $v.waitMinutesForNextPost;
      _waitMinutesForPremiumUserNextPost = $v.waitMinutesForPremiumUserNextPost;
      _ffRef = $v.ffRef;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CategoriesRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CategoriesRecord;
  }

  @override
  void update(void Function(CategoriesRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CategoriesRecord build() => _build();

  _$CategoriesRecord _build() {
    final _$result = _$v ??
        new _$CategoriesRecord._(
            categoryId: BuiltValueNullFieldError.checkNotNull(
                categoryId, r'CategoriesRecord', 'categoryId'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'CategoriesRecord', 'title'),
            noOfPosts: BuiltValueNullFieldError.checkNotNull(
                noOfPosts, r'CategoriesRecord', 'noOfPosts'),
            noOfComments: BuiltValueNullFieldError.checkNotNull(
                noOfComments, r'CategoriesRecord', 'noOfComments'),
            enablePushNotificationSubscription: BuiltValueNullFieldError.checkNotNull(
                enablePushNotificationSubscription, r'CategoriesRecord', 'enablePushNotificationSubscription'),
            emphasizePremiumUserPost: BuiltValueNullFieldError.checkNotNull(
                emphasizePremiumUserPost, r'CategoriesRecord', 'emphasizePremiumUserPost'),
            waitMinutesForNextPost: BuiltValueNullFieldError.checkNotNull(
                waitMinutesForNextPost, r'CategoriesRecord', 'waitMinutesForNextPost'),
            waitMinutesForPremiumUserNextPost: BuiltValueNullFieldError.checkNotNull(
                waitMinutesForPremiumUserNextPost, r'CategoriesRecord', 'waitMinutesForPremiumUserNextPost'),
            ffRef: ffRef);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
