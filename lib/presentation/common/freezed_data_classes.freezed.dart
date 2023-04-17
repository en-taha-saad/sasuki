// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginObject {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;
  String get captchaText => throw _privateConstructorUsedError;
  String get sessionId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call(
      {String username,
      String password,
      String language,
      String otp,
      String captchaText,
      String sessionId});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? language = null,
    Object? otp = null,
    Object? captchaText = null,
    Object? sessionId = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      captchaText: null == captchaText
          ? _value.captchaText
          : captchaText // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$_LoginObjectCopyWith(
          _$_LoginObject value, $Res Function(_$_LoginObject) then) =
      __$$_LoginObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String username,
      String password,
      String language,
      String otp,
      String captchaText,
      String sessionId});
}

/// @nodoc
class __$$_LoginObjectCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$_LoginObject>
    implements _$$_LoginObjectCopyWith<$Res> {
  __$$_LoginObjectCopyWithImpl(
      _$_LoginObject _value, $Res Function(_$_LoginObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
    Object? language = null,
    Object? otp = null,
    Object? captchaText = null,
    Object? sessionId = null,
  }) {
    return _then(_$_LoginObject(
      null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      null == captchaText
          ? _value.captchaText
          : captchaText // ignore: cast_nullable_to_non_nullable
              as String,
      null == sessionId
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  _$_LoginObject(this.username, this.password, this.language, this.otp,
      this.captchaText, this.sessionId);

  @override
  final String username;
  @override
  final String password;
  @override
  final String language;
  @override
  final String otp;
  @override
  final String captchaText;
  @override
  final String sessionId;

  @override
  String toString() {
    return 'LoginObject(username: $username, password: $password, language: $language, otp: $otp, captchaText: $captchaText, sessionId: $sessionId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginObject &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.captchaText, captchaText) ||
                other.captchaText == captchaText) &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, username, password, language, otp, captchaText, sessionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      __$$_LoginObjectCopyWithImpl<_$_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(
      final String username,
      final String password,
      final String language,
      final String otp,
      final String captchaText,
      final String sessionId) = _$_LoginObject;

  @override
  String get username;
  @override
  String get password;
  @override
  String get language;
  @override
  String get otp;
  @override
  String get captchaText;
  @override
  String get sessionId;
  @override
  @JsonKey(ignore: true)
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserRequestObject {
  int get page => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get sortBy => throw _privateConstructorUsedError;
  String get direction => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;
  List<String> get columns => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  int get connection => throw _privateConstructorUsedError;
  int get profileId => throw _privateConstructorUsedError;
  int get parentId => throw _privateConstructorUsedError;
  int get groupId => throw _privateConstructorUsedError;
  int get siteId => throw _privateConstructorUsedError;
  int get subUsers => throw _privateConstructorUsedError;
  String get mac => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserRequestObjectCopyWith<UserRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRequestObjectCopyWith<$Res> {
  factory $UserRequestObjectCopyWith(
          UserRequestObject value, $Res Function(UserRequestObject) then) =
      _$UserRequestObjectCopyWithImpl<$Res, UserRequestObject>;
  @useResult
  $Res call(
      {int page,
      int count,
      String sortBy,
      String direction,
      String search,
      List<String> columns,
      int status,
      int connection,
      int profileId,
      int parentId,
      int groupId,
      int siteId,
      int subUsers,
      String mac});
}

/// @nodoc
class _$UserRequestObjectCopyWithImpl<$Res, $Val extends UserRequestObject>
    implements $UserRequestObjectCopyWith<$Res> {
  _$UserRequestObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? count = null,
    Object? sortBy = null,
    Object? direction = null,
    Object? search = null,
    Object? columns = null,
    Object? status = null,
    Object? connection = null,
    Object? profileId = null,
    Object? parentId = null,
    Object? groupId = null,
    Object? siteId = null,
    Object? subUsers = null,
    Object? mac = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      columns: null == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      connection: null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as int,
      profileId: null == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      siteId: null == siteId
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int,
      subUsers: null == subUsers
          ? _value.subUsers
          : subUsers // ignore: cast_nullable_to_non_nullable
              as int,
      mac: null == mac
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserRequestObjectCopyWith<$Res>
    implements $UserRequestObjectCopyWith<$Res> {
  factory _$$_UserRequestObjectCopyWith(_$_UserRequestObject value,
          $Res Function(_$_UserRequestObject) then) =
      __$$_UserRequestObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      int count,
      String sortBy,
      String direction,
      String search,
      List<String> columns,
      int status,
      int connection,
      int profileId,
      int parentId,
      int groupId,
      int siteId,
      int subUsers,
      String mac});
}

/// @nodoc
class __$$_UserRequestObjectCopyWithImpl<$Res>
    extends _$UserRequestObjectCopyWithImpl<$Res, _$_UserRequestObject>
    implements _$$_UserRequestObjectCopyWith<$Res> {
  __$$_UserRequestObjectCopyWithImpl(
      _$_UserRequestObject _value, $Res Function(_$_UserRequestObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? count = null,
    Object? sortBy = null,
    Object? direction = null,
    Object? search = null,
    Object? columns = null,
    Object? status = null,
    Object? connection = null,
    Object? profileId = null,
    Object? parentId = null,
    Object? groupId = null,
    Object? siteId = null,
    Object? subUsers = null,
    Object? mac = null,
  }) {
    return _then(_$_UserRequestObject(
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      null == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as int,
      null == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as int,
      null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
      null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      null == siteId
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int,
      null == subUsers
          ? _value.subUsers
          : subUsers // ignore: cast_nullable_to_non_nullable
              as int,
      null == mac
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_UserRequestObject implements _UserRequestObject {
  _$_UserRequestObject(
      this.page,
      this.count,
      this.sortBy,
      this.direction,
      this.search,
      final List<String> columns,
      this.status,
      this.connection,
      this.profileId,
      this.parentId,
      this.groupId,
      this.siteId,
      this.subUsers,
      this.mac)
      : _columns = columns;

  @override
  final int page;
  @override
  final int count;
  @override
  final String sortBy;
  @override
  final String direction;
  @override
  final String search;
  final List<String> _columns;
  @override
  List<String> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  @override
  final int status;
  @override
  final int connection;
  @override
  final int profileId;
  @override
  final int parentId;
  @override
  final int groupId;
  @override
  final int siteId;
  @override
  final int subUsers;
  @override
  final String mac;

  @override
  String toString() {
    return 'UserRequestObject(page: $page, count: $count, sortBy: $sortBy, direction: $direction, search: $search, columns: $columns, status: $status, connection: $connection, profileId: $profileId, parentId: $parentId, groupId: $groupId, siteId: $siteId, subUsers: $subUsers, mac: $mac)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserRequestObject &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.search, search) || other.search == search) &&
            const DeepCollectionEquality().equals(other._columns, _columns) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.connection, connection) ||
                other.connection == connection) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.subUsers, subUsers) ||
                other.subUsers == subUsers) &&
            (identical(other.mac, mac) || other.mac == mac));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      count,
      sortBy,
      direction,
      search,
      const DeepCollectionEquality().hash(_columns),
      status,
      connection,
      profileId,
      parentId,
      groupId,
      siteId,
      subUsers,
      mac);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserRequestObjectCopyWith<_$_UserRequestObject> get copyWith =>
      __$$_UserRequestObjectCopyWithImpl<_$_UserRequestObject>(
          this, _$identity);
}

abstract class _UserRequestObject implements UserRequestObject {
  factory _UserRequestObject(
      final int page,
      final int count,
      final String sortBy,
      final String direction,
      final String search,
      final List<String> columns,
      final int status,
      final int connection,
      final int profileId,
      final int parentId,
      final int groupId,
      final int siteId,
      final int subUsers,
      final String mac) = _$_UserRequestObject;

  @override
  int get page;
  @override
  int get count;
  @override
  String get sortBy;
  @override
  String get direction;
  @override
  String get search;
  @override
  List<String> get columns;
  @override
  int get status;
  @override
  int get connection;
  @override
  int get profileId;
  @override
  int get parentId;
  @override
  int get groupId;
  @override
  int get siteId;
  @override
  int get subUsers;
  @override
  String get mac;
  @override
  @JsonKey(ignore: true)
  _$$_UserRequestObjectCopyWith<_$_UserRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActivationRequestObject {
  String? get method => throw _privateConstructorUsedError;
  String? get pin => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  int? get moneyCollected => throw _privateConstructorUsedError;
  String? get comments => throw _privateConstructorUsedError;
  int? get userPrice => throw _privateConstructorUsedError;
  bool? get issueInvoice => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  int? get activationUnits => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActivationRequestObjectCopyWith<ActivationRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivationRequestObjectCopyWith<$Res> {
  factory $ActivationRequestObjectCopyWith(ActivationRequestObject value,
          $Res Function(ActivationRequestObject) then) =
      _$ActivationRequestObjectCopyWithImpl<$Res, ActivationRequestObject>;
  @useResult
  $Res call(
      {String? method,
      String? pin,
      String? userId,
      int? moneyCollected,
      String? comments,
      int? userPrice,
      bool? issueInvoice,
      String? transactionId,
      int? activationUnits});
}

/// @nodoc
class _$ActivationRequestObjectCopyWithImpl<$Res,
        $Val extends ActivationRequestObject>
    implements $ActivationRequestObjectCopyWith<$Res> {
  _$ActivationRequestObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = freezed,
    Object? pin = freezed,
    Object? userId = freezed,
    Object? moneyCollected = freezed,
    Object? comments = freezed,
    Object? userPrice = freezed,
    Object? issueInvoice = freezed,
    Object? transactionId = freezed,
    Object? activationUnits = freezed,
  }) {
    return _then(_value.copyWith(
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      pin: freezed == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      moneyCollected: freezed == moneyCollected
          ? _value.moneyCollected
          : moneyCollected // ignore: cast_nullable_to_non_nullable
              as int?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
      userPrice: freezed == userPrice
          ? _value.userPrice
          : userPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      issueInvoice: freezed == issueInvoice
          ? _value.issueInvoice
          : issueInvoice // ignore: cast_nullable_to_non_nullable
              as bool?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      activationUnits: freezed == activationUnits
          ? _value.activationUnits
          : activationUnits // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ActivationRequestObjectCopyWith<$Res>
    implements $ActivationRequestObjectCopyWith<$Res> {
  factory _$$_ActivationRequestObjectCopyWith(_$_ActivationRequestObject value,
          $Res Function(_$_ActivationRequestObject) then) =
      __$$_ActivationRequestObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? method,
      String? pin,
      String? userId,
      int? moneyCollected,
      String? comments,
      int? userPrice,
      bool? issueInvoice,
      String? transactionId,
      int? activationUnits});
}

/// @nodoc
class __$$_ActivationRequestObjectCopyWithImpl<$Res>
    extends _$ActivationRequestObjectCopyWithImpl<$Res,
        _$_ActivationRequestObject>
    implements _$$_ActivationRequestObjectCopyWith<$Res> {
  __$$_ActivationRequestObjectCopyWithImpl(_$_ActivationRequestObject _value,
      $Res Function(_$_ActivationRequestObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = freezed,
    Object? pin = freezed,
    Object? userId = freezed,
    Object? moneyCollected = freezed,
    Object? comments = freezed,
    Object? userPrice = freezed,
    Object? issueInvoice = freezed,
    Object? transactionId = freezed,
    Object? activationUnits = freezed,
  }) {
    return _then(_$_ActivationRequestObject(
      freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == pin
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == moneyCollected
          ? _value.moneyCollected
          : moneyCollected // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == userPrice
          ? _value.userPrice
          : userPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == issueInvoice
          ? _value.issueInvoice
          : issueInvoice // ignore: cast_nullable_to_non_nullable
              as bool?,
      freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == activationUnits
          ? _value.activationUnits
          : activationUnits // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_ActivationRequestObject implements _ActivationRequestObject {
  _$_ActivationRequestObject(
      this.method,
      this.pin,
      this.userId,
      this.moneyCollected,
      this.comments,
      this.userPrice,
      this.issueInvoice,
      this.transactionId,
      this.activationUnits);

  @override
  final String? method;
  @override
  final String? pin;
  @override
  final String? userId;
  @override
  final int? moneyCollected;
  @override
  final String? comments;
  @override
  final int? userPrice;
  @override
  final bool? issueInvoice;
  @override
  final String? transactionId;
  @override
  final int? activationUnits;

  @override
  String toString() {
    return 'ActivationRequestObject(method: $method, pin: $pin, userId: $userId, moneyCollected: $moneyCollected, comments: $comments, userPrice: $userPrice, issueInvoice: $issueInvoice, transactionId: $transactionId, activationUnits: $activationUnits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActivationRequestObject &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.pin, pin) || other.pin == pin) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.moneyCollected, moneyCollected) ||
                other.moneyCollected == moneyCollected) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.userPrice, userPrice) ||
                other.userPrice == userPrice) &&
            (identical(other.issueInvoice, issueInvoice) ||
                other.issueInvoice == issueInvoice) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.activationUnits, activationUnits) ||
                other.activationUnits == activationUnits));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      method,
      pin,
      userId,
      moneyCollected,
      comments,
      userPrice,
      issueInvoice,
      transactionId,
      activationUnits);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActivationRequestObjectCopyWith<_$_ActivationRequestObject>
      get copyWith =>
          __$$_ActivationRequestObjectCopyWithImpl<_$_ActivationRequestObject>(
              this, _$identity);
}

abstract class _ActivationRequestObject implements ActivationRequestObject {
  factory _ActivationRequestObject(
      final String? method,
      final String? pin,
      final String? userId,
      final int? moneyCollected,
      final String? comments,
      final int? userPrice,
      final bool? issueInvoice,
      final String? transactionId,
      final int? activationUnits) = _$_ActivationRequestObject;

  @override
  String? get method;
  @override
  String? get pin;
  @override
  String? get userId;
  @override
  int? get moneyCollected;
  @override
  String? get comments;
  @override
  int? get userPrice;
  @override
  bool? get issueInvoice;
  @override
  String? get transactionId;
  @override
  int? get activationUnits;
  @override
  @JsonKey(ignore: true)
  _$$_ActivationRequestObjectCopyWith<_$_ActivationRequestObject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddUserRequestObject {
  String? get username => throw _privateConstructorUsedError;
  int? get enabled => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get confirmPassword => throw _privateConstructorUsedError;
  int? get profileId => throw _privateConstructorUsedError;
  int? get parentId => throw _privateConstructorUsedError;
  int? get siteId => throw _privateConstructorUsedError;
  int? get macAuth => throw _privateConstructorUsedError;
  int? get allowedMacs => throw _privateConstructorUsedError;
  int? get useSeparatePortalPassword => throw _privateConstructorUsedError;
  String? get portalPassword => throw _privateConstructorUsedError;
  int? get groupId => throw _privateConstructorUsedError;
  String? get firstname => throw _privateConstructorUsedError;
  String? get lastname => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get apartment => throw _privateConstructorUsedError;
  String? get street => throw _privateConstructorUsedError;
  int? get contractId => throw _privateConstructorUsedError;
  int? get nationalId => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  int? get autoRenew => throw _privateConstructorUsedError;
  String? get expiration => throw _privateConstructorUsedError;
  int? get simultaneousSessions => throw _privateConstructorUsedError;
  int? get staticIp => throw _privateConstructorUsedError;
  String? get userType => throw _privateConstructorUsedError;
  int? get restricted => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddUserRequestObjectCopyWith<AddUserRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddUserRequestObjectCopyWith<$Res> {
  factory $AddUserRequestObjectCopyWith(AddUserRequestObject value,
          $Res Function(AddUserRequestObject) then) =
      _$AddUserRequestObjectCopyWithImpl<$Res, AddUserRequestObject>;
  @useResult
  $Res call(
      {String? username,
      int? enabled,
      String? password,
      String? confirmPassword,
      int? profileId,
      int? parentId,
      int? siteId,
      int? macAuth,
      int? allowedMacs,
      int? useSeparatePortalPassword,
      String? portalPassword,
      int? groupId,
      String? firstname,
      String? lastname,
      String? company,
      String? email,
      String? phone,
      String? city,
      String? address,
      String? apartment,
      String? street,
      int? contractId,
      int? nationalId,
      String? notes,
      int? autoRenew,
      String? expiration,
      int? simultaneousSessions,
      int? staticIp,
      String? userType,
      int? restricted});
}

/// @nodoc
class _$AddUserRequestObjectCopyWithImpl<$Res,
        $Val extends AddUserRequestObject>
    implements $AddUserRequestObjectCopyWith<$Res> {
  _$AddUserRequestObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? enabled = freezed,
    Object? password = freezed,
    Object? confirmPassword = freezed,
    Object? profileId = freezed,
    Object? parentId = freezed,
    Object? siteId = freezed,
    Object? macAuth = freezed,
    Object? allowedMacs = freezed,
    Object? useSeparatePortalPassword = freezed,
    Object? portalPassword = freezed,
    Object? groupId = freezed,
    Object? firstname = freezed,
    Object? lastname = freezed,
    Object? company = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? city = freezed,
    Object? address = freezed,
    Object? apartment = freezed,
    Object? street = freezed,
    Object? contractId = freezed,
    Object? nationalId = freezed,
    Object? notes = freezed,
    Object? autoRenew = freezed,
    Object? expiration = freezed,
    Object? simultaneousSessions = freezed,
    Object? staticIp = freezed,
    Object? userType = freezed,
    Object? restricted = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as int?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword: freezed == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      profileId: freezed == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      siteId: freezed == siteId
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int?,
      macAuth: freezed == macAuth
          ? _value.macAuth
          : macAuth // ignore: cast_nullable_to_non_nullable
              as int?,
      allowedMacs: freezed == allowedMacs
          ? _value.allowedMacs
          : allowedMacs // ignore: cast_nullable_to_non_nullable
              as int?,
      useSeparatePortalPassword: freezed == useSeparatePortalPassword
          ? _value.useSeparatePortalPassword
          : useSeparatePortalPassword // ignore: cast_nullable_to_non_nullable
              as int?,
      portalPassword: freezed == portalPassword
          ? _value.portalPassword
          : portalPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstname: freezed == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname: freezed == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      street: freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      contractId: freezed == contractId
          ? _value.contractId
          : contractId // ignore: cast_nullable_to_non_nullable
              as int?,
      nationalId: freezed == nationalId
          ? _value.nationalId
          : nationalId // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      autoRenew: freezed == autoRenew
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as int?,
      expiration: freezed == expiration
          ? _value.expiration
          : expiration // ignore: cast_nullable_to_non_nullable
              as String?,
      simultaneousSessions: freezed == simultaneousSessions
          ? _value.simultaneousSessions
          : simultaneousSessions // ignore: cast_nullable_to_non_nullable
              as int?,
      staticIp: freezed == staticIp
          ? _value.staticIp
          : staticIp // ignore: cast_nullable_to_non_nullable
              as int?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      restricted: freezed == restricted
          ? _value.restricted
          : restricted // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddUserRequestObjectCopyWith<$Res>
    implements $AddUserRequestObjectCopyWith<$Res> {
  factory _$$_AddUserRequestObjectCopyWith(_$_AddUserRequestObject value,
          $Res Function(_$_AddUserRequestObject) then) =
      __$$_AddUserRequestObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? username,
      int? enabled,
      String? password,
      String? confirmPassword,
      int? profileId,
      int? parentId,
      int? siteId,
      int? macAuth,
      int? allowedMacs,
      int? useSeparatePortalPassword,
      String? portalPassword,
      int? groupId,
      String? firstname,
      String? lastname,
      String? company,
      String? email,
      String? phone,
      String? city,
      String? address,
      String? apartment,
      String? street,
      int? contractId,
      int? nationalId,
      String? notes,
      int? autoRenew,
      String? expiration,
      int? simultaneousSessions,
      int? staticIp,
      String? userType,
      int? restricted});
}

/// @nodoc
class __$$_AddUserRequestObjectCopyWithImpl<$Res>
    extends _$AddUserRequestObjectCopyWithImpl<$Res, _$_AddUserRequestObject>
    implements _$$_AddUserRequestObjectCopyWith<$Res> {
  __$$_AddUserRequestObjectCopyWithImpl(_$_AddUserRequestObject _value,
      $Res Function(_$_AddUserRequestObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? enabled = freezed,
    Object? password = freezed,
    Object? confirmPassword = freezed,
    Object? profileId = freezed,
    Object? parentId = freezed,
    Object? siteId = freezed,
    Object? macAuth = freezed,
    Object? allowedMacs = freezed,
    Object? useSeparatePortalPassword = freezed,
    Object? portalPassword = freezed,
    Object? groupId = freezed,
    Object? firstname = freezed,
    Object? lastname = freezed,
    Object? company = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? city = freezed,
    Object? address = freezed,
    Object? apartment = freezed,
    Object? street = freezed,
    Object? contractId = freezed,
    Object? nationalId = freezed,
    Object? notes = freezed,
    Object? autoRenew = freezed,
    Object? expiration = freezed,
    Object? simultaneousSessions = freezed,
    Object? staticIp = freezed,
    Object? userType = freezed,
    Object? restricted = freezed,
  }) {
    return _then(_$_AddUserRequestObject(
      freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == siteId
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == macAuth
          ? _value.macAuth
          : macAuth // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == allowedMacs
          ? _value.allowedMacs
          : allowedMacs // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == useSeparatePortalPassword
          ? _value.useSeparatePortalPassword
          : useSeparatePortalPassword // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == portalPassword
          ? _value.portalPassword
          : portalPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == apartment
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == contractId
          ? _value.contractId
          : contractId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == nationalId
          ? _value.nationalId
          : nationalId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == autoRenew
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == expiration
          ? _value.expiration
          : expiration // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == simultaneousSessions
          ? _value.simultaneousSessions
          : simultaneousSessions // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == staticIp
          ? _value.staticIp
          : staticIp // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == restricted
          ? _value.restricted
          : restricted // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_AddUserRequestObject implements _AddUserRequestObject {
  _$_AddUserRequestObject(
      this.username,
      this.enabled,
      this.password,
      this.confirmPassword,
      this.profileId,
      this.parentId,
      this.siteId,
      this.macAuth,
      this.allowedMacs,
      this.useSeparatePortalPassword,
      this.portalPassword,
      this.groupId,
      this.firstname,
      this.lastname,
      this.company,
      this.email,
      this.phone,
      this.city,
      this.address,
      this.apartment,
      this.street,
      this.contractId,
      this.nationalId,
      this.notes,
      this.autoRenew,
      this.expiration,
      this.simultaneousSessions,
      this.staticIp,
      this.userType,
      this.restricted);

  @override
  final String? username;
  @override
  final int? enabled;
  @override
  final String? password;
  @override
  final String? confirmPassword;
  @override
  final int? profileId;
  @override
  final int? parentId;
  @override
  final int? siteId;
  @override
  final int? macAuth;
  @override
  final int? allowedMacs;
  @override
  final int? useSeparatePortalPassword;
  @override
  final String? portalPassword;
  @override
  final int? groupId;
  @override
  final String? firstname;
  @override
  final String? lastname;
  @override
  final String? company;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? city;
  @override
  final String? address;
  @override
  final String? apartment;
  @override
  final String? street;
  @override
  final int? contractId;
  @override
  final int? nationalId;
  @override
  final String? notes;
  @override
  final int? autoRenew;
  @override
  final String? expiration;
  @override
  final int? simultaneousSessions;
  @override
  final int? staticIp;
  @override
  final String? userType;
  @override
  final int? restricted;

  @override
  String toString() {
    return 'AddUserRequestObject(username: $username, enabled: $enabled, password: $password, confirmPassword: $confirmPassword, profileId: $profileId, parentId: $parentId, siteId: $siteId, macAuth: $macAuth, allowedMacs: $allowedMacs, useSeparatePortalPassword: $useSeparatePortalPassword, portalPassword: $portalPassword, groupId: $groupId, firstname: $firstname, lastname: $lastname, company: $company, email: $email, phone: $phone, city: $city, address: $address, apartment: $apartment, street: $street, contractId: $contractId, nationalId: $nationalId, notes: $notes, autoRenew: $autoRenew, expiration: $expiration, simultaneousSessions: $simultaneousSessions, staticIp: $staticIp, userType: $userType, restricted: $restricted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddUserRequestObject &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.macAuth, macAuth) || other.macAuth == macAuth) &&
            (identical(other.allowedMacs, allowedMacs) ||
                other.allowedMacs == allowedMacs) &&
            (identical(other.useSeparatePortalPassword,
                    useSeparatePortalPassword) ||
                other.useSeparatePortalPassword == useSeparatePortalPassword) &&
            (identical(other.portalPassword, portalPassword) ||
                other.portalPassword == portalPassword) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.apartment, apartment) ||
                other.apartment == apartment) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.contractId, contractId) ||
                other.contractId == contractId) &&
            (identical(other.nationalId, nationalId) ||
                other.nationalId == nationalId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.autoRenew, autoRenew) ||
                other.autoRenew == autoRenew) &&
            (identical(other.expiration, expiration) ||
                other.expiration == expiration) &&
            (identical(other.simultaneousSessions, simultaneousSessions) ||
                other.simultaneousSessions == simultaneousSessions) &&
            (identical(other.staticIp, staticIp) ||
                other.staticIp == staticIp) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.restricted, restricted) ||
                other.restricted == restricted));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        username,
        enabled,
        password,
        confirmPassword,
        profileId,
        parentId,
        siteId,
        macAuth,
        allowedMacs,
        useSeparatePortalPassword,
        portalPassword,
        groupId,
        firstname,
        lastname,
        company,
        email,
        phone,
        city,
        address,
        apartment,
        street,
        contractId,
        nationalId,
        notes,
        autoRenew,
        expiration,
        simultaneousSessions,
        staticIp,
        userType,
        restricted
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddUserRequestObjectCopyWith<_$_AddUserRequestObject> get copyWith =>
      __$$_AddUserRequestObjectCopyWithImpl<_$_AddUserRequestObject>(
          this, _$identity);
}

abstract class _AddUserRequestObject implements AddUserRequestObject {
  factory _AddUserRequestObject(
      final String? username,
      final int? enabled,
      final String? password,
      final String? confirmPassword,
      final int? profileId,
      final int? parentId,
      final int? siteId,
      final int? macAuth,
      final int? allowedMacs,
      final int? useSeparatePortalPassword,
      final String? portalPassword,
      final int? groupId,
      final String? firstname,
      final String? lastname,
      final String? company,
      final String? email,
      final String? phone,
      final String? city,
      final String? address,
      final String? apartment,
      final String? street,
      final int? contractId,
      final int? nationalId,
      final String? notes,
      final int? autoRenew,
      final String? expiration,
      final int? simultaneousSessions,
      final int? staticIp,
      final String? userType,
      final int? restricted) = _$_AddUserRequestObject;

  @override
  String? get username;
  @override
  int? get enabled;
  @override
  String? get password;
  @override
  String? get confirmPassword;
  @override
  int? get profileId;
  @override
  int? get parentId;
  @override
  int? get siteId;
  @override
  int? get macAuth;
  @override
  int? get allowedMacs;
  @override
  int? get useSeparatePortalPassword;
  @override
  String? get portalPassword;
  @override
  int? get groupId;
  @override
  String? get firstname;
  @override
  String? get lastname;
  @override
  String? get company;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get city;
  @override
  String? get address;
  @override
  String? get apartment;
  @override
  String? get street;
  @override
  int? get contractId;
  @override
  int? get nationalId;
  @override
  String? get notes;
  @override
  int? get autoRenew;
  @override
  String? get expiration;
  @override
  int? get simultaneousSessions;
  @override
  int? get staticIp;
  @override
  String? get userType;
  @override
  int? get restricted;
  @override
  @JsonKey(ignore: true)
  _$$_AddUserRequestObjectCopyWith<_$_AddUserRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ExtendUserRequestObject {
  String? get userId => throw _privateConstructorUsedError;
  String? get profileId => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExtendUserRequestObjectCopyWith<ExtendUserRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtendUserRequestObjectCopyWith<$Res> {
  factory $ExtendUserRequestObjectCopyWith(ExtendUserRequestObject value,
          $Res Function(ExtendUserRequestObject) then) =
      _$ExtendUserRequestObjectCopyWithImpl<$Res, ExtendUserRequestObject>;
  @useResult
  $Res call(
      {String? userId,
      String? profileId,
      String? method,
      String? transactionId});
}

/// @nodoc
class _$ExtendUserRequestObjectCopyWithImpl<$Res,
        $Val extends ExtendUserRequestObject>
    implements $ExtendUserRequestObjectCopyWith<$Res> {
  _$ExtendUserRequestObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? profileId = freezed,
    Object? method = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      profileId: freezed == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExtendUserRequestObjectCopyWith<$Res>
    implements $ExtendUserRequestObjectCopyWith<$Res> {
  factory _$$_ExtendUserRequestObjectCopyWith(_$_ExtendUserRequestObject value,
          $Res Function(_$_ExtendUserRequestObject) then) =
      __$$_ExtendUserRequestObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId,
      String? profileId,
      String? method,
      String? transactionId});
}

/// @nodoc
class __$$_ExtendUserRequestObjectCopyWithImpl<$Res>
    extends _$ExtendUserRequestObjectCopyWithImpl<$Res,
        _$_ExtendUserRequestObject>
    implements _$$_ExtendUserRequestObjectCopyWith<$Res> {
  __$$_ExtendUserRequestObjectCopyWithImpl(_$_ExtendUserRequestObject _value,
      $Res Function(_$_ExtendUserRequestObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? profileId = freezed,
    Object? method = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_$_ExtendUserRequestObject(
      freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ExtendUserRequestObject implements _ExtendUserRequestObject {
  _$_ExtendUserRequestObject(
      this.userId, this.profileId, this.method, this.transactionId);

  @override
  final String? userId;
  @override
  final String? profileId;
  @override
  final String? method;
  @override
  final String? transactionId;

  @override
  String toString() {
    return 'ExtendUserRequestObject(userId: $userId, profileId: $profileId, method: $method, transactionId: $transactionId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExtendUserRequestObject &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, profileId, method, transactionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExtendUserRequestObjectCopyWith<_$_ExtendUserRequestObject>
      get copyWith =>
          __$$_ExtendUserRequestObjectCopyWithImpl<_$_ExtendUserRequestObject>(
              this, _$identity);
}

abstract class _ExtendUserRequestObject implements ExtendUserRequestObject {
  factory _ExtendUserRequestObject(
      final String? userId,
      final String? profileId,
      final String? method,
      final String? transactionId) = _$_ExtendUserRequestObject;

  @override
  String? get userId;
  @override
  String? get profileId;
  @override
  String? get method;
  @override
  String? get transactionId;
  @override
  @JsonKey(ignore: true)
  _$$_ExtendUserRequestObjectCopyWith<_$_ExtendUserRequestObject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DepositWithdrawUserRequestObject {
  String? get userId => throw _privateConstructorUsedError;
  String? get userUsername => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DepositWithdrawUserRequestObjectCopyWith<DepositWithdrawUserRequestObject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepositWithdrawUserRequestObjectCopyWith<$Res> {
  factory $DepositWithdrawUserRequestObjectCopyWith(
          DepositWithdrawUserRequestObject value,
          $Res Function(DepositWithdrawUserRequestObject) then) =
      _$DepositWithdrawUserRequestObjectCopyWithImpl<$Res,
          DepositWithdrawUserRequestObject>;
  @useResult
  $Res call(
      {String? userId,
      String? userUsername,
      int? amount,
      String? comment,
      String? transactionId});
}

/// @nodoc
class _$DepositWithdrawUserRequestObjectCopyWithImpl<$Res,
        $Val extends DepositWithdrawUserRequestObject>
    implements $DepositWithdrawUserRequestObjectCopyWith<$Res> {
  _$DepositWithdrawUserRequestObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? userUsername = freezed,
    Object? amount = freezed,
    Object? comment = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userUsername: freezed == userUsername
          ? _value.userUsername
          : userUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DepositWithdrawUserRequestObjectCopyWith<$Res>
    implements $DepositWithdrawUserRequestObjectCopyWith<$Res> {
  factory _$$_DepositWithdrawUserRequestObjectCopyWith(
          _$_DepositWithdrawUserRequestObject value,
          $Res Function(_$_DepositWithdrawUserRequestObject) then) =
      __$$_DepositWithdrawUserRequestObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? userId,
      String? userUsername,
      int? amount,
      String? comment,
      String? transactionId});
}

/// @nodoc
class __$$_DepositWithdrawUserRequestObjectCopyWithImpl<$Res>
    extends _$DepositWithdrawUserRequestObjectCopyWithImpl<$Res,
        _$_DepositWithdrawUserRequestObject>
    implements _$$_DepositWithdrawUserRequestObjectCopyWith<$Res> {
  __$$_DepositWithdrawUserRequestObjectCopyWithImpl(
      _$_DepositWithdrawUserRequestObject _value,
      $Res Function(_$_DepositWithdrawUserRequestObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? userUsername = freezed,
    Object? amount = freezed,
    Object? comment = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_$_DepositWithdrawUserRequestObject(
      freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == userUsername
          ? _value.userUsername
          : userUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_DepositWithdrawUserRequestObject
    implements _DepositWithdrawUserRequestObject {
  _$_DepositWithdrawUserRequestObject(this.userId, this.userUsername,
      this.amount, this.comment, this.transactionId);

  @override
  final String? userId;
  @override
  final String? userUsername;
  @override
  final int? amount;
  @override
  final String? comment;
  @override
  final String? transactionId;

  @override
  String toString() {
    return 'DepositWithdrawUserRequestObject(userId: $userId, userUsername: $userUsername, amount: $amount, comment: $comment, transactionId: $transactionId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DepositWithdrawUserRequestObject &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userUsername, userUsername) ||
                other.userUsername == userUsername) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userId, userUsername, amount, comment, transactionId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DepositWithdrawUserRequestObjectCopyWith<
          _$_DepositWithdrawUserRequestObject>
      get copyWith => __$$_DepositWithdrawUserRequestObjectCopyWithImpl<
          _$_DepositWithdrawUserRequestObject>(this, _$identity);
}

abstract class _DepositWithdrawUserRequestObject
    implements DepositWithdrawUserRequestObject {
  factory _DepositWithdrawUserRequestObject(
      final String? userId,
      final String? userUsername,
      final int? amount,
      final String? comment,
      final String? transactionId) = _$_DepositWithdrawUserRequestObject;

  @override
  String? get userId;
  @override
  String? get userUsername;
  @override
  int? get amount;
  @override
  String? get comment;
  @override
  String? get transactionId;
  @override
  @JsonKey(ignore: true)
  _$$_DepositWithdrawUserRequestObjectCopyWith<
          _$_DepositWithdrawUserRequestObject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PayDebtRequestObject {
  int? get userId => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  int? get transactionId => throw _privateConstructorUsedError;
  bool? get isLoan => throw _privateConstructorUsedError;
  int? get debtForMe => throw _privateConstructorUsedError;
  int? get debt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PayDebtRequestObjectCopyWith<PayDebtRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayDebtRequestObjectCopyWith<$Res> {
  factory $PayDebtRequestObjectCopyWith(PayDebtRequestObject value,
          $Res Function(PayDebtRequestObject) then) =
      _$PayDebtRequestObjectCopyWithImpl<$Res, PayDebtRequestObject>;
  @useResult
  $Res call(
      {int? userId,
      String? username,
      int? amount,
      String? comment,
      int? transactionId,
      bool? isLoan,
      int? debtForMe,
      int? debt});
}

/// @nodoc
class _$PayDebtRequestObjectCopyWithImpl<$Res,
        $Val extends PayDebtRequestObject>
    implements $PayDebtRequestObjectCopyWith<$Res> {
  _$PayDebtRequestObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? username = freezed,
    Object? amount = freezed,
    Object? comment = freezed,
    Object? transactionId = freezed,
    Object? isLoan = freezed,
    Object? debtForMe = freezed,
    Object? debt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
      isLoan: freezed == isLoan
          ? _value.isLoan
          : isLoan // ignore: cast_nullable_to_non_nullable
              as bool?,
      debtForMe: freezed == debtForMe
          ? _value.debtForMe
          : debtForMe // ignore: cast_nullable_to_non_nullable
              as int?,
      debt: freezed == debt
          ? _value.debt
          : debt // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PayDebtRequestObjectCopyWith<$Res>
    implements $PayDebtRequestObjectCopyWith<$Res> {
  factory _$$_PayDebtRequestObjectCopyWith(_$_PayDebtRequestObject value,
          $Res Function(_$_PayDebtRequestObject) then) =
      __$$_PayDebtRequestObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? userId,
      String? username,
      int? amount,
      String? comment,
      int? transactionId,
      bool? isLoan,
      int? debtForMe,
      int? debt});
}

/// @nodoc
class __$$_PayDebtRequestObjectCopyWithImpl<$Res>
    extends _$PayDebtRequestObjectCopyWithImpl<$Res, _$_PayDebtRequestObject>
    implements _$$_PayDebtRequestObjectCopyWith<$Res> {
  __$$_PayDebtRequestObjectCopyWithImpl(_$_PayDebtRequestObject _value,
      $Res Function(_$_PayDebtRequestObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? username = freezed,
    Object? amount = freezed,
    Object? comment = freezed,
    Object? transactionId = freezed,
    Object? isLoan = freezed,
    Object? debtForMe = freezed,
    Object? debt = freezed,
  }) {
    return _then(_$_PayDebtRequestObject(
      freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == isLoan
          ? _value.isLoan
          : isLoan // ignore: cast_nullable_to_non_nullable
              as bool?,
      freezed == debtForMe
          ? _value.debtForMe
          : debtForMe // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == debt
          ? _value.debt
          : debt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_PayDebtRequestObject implements _PayDebtRequestObject {
  _$_PayDebtRequestObject(this.userId, this.username, this.amount, this.comment,
      this.transactionId, this.isLoan, this.debtForMe, this.debt);

  @override
  final int? userId;
  @override
  final String? username;
  @override
  final int? amount;
  @override
  final String? comment;
  @override
  final int? transactionId;
  @override
  final bool? isLoan;
  @override
  final int? debtForMe;
  @override
  final int? debt;

  @override
  String toString() {
    return 'PayDebtRequestObject(userId: $userId, username: $username, amount: $amount, comment: $comment, transactionId: $transactionId, isLoan: $isLoan, debtForMe: $debtForMe, debt: $debt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PayDebtRequestObject &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.isLoan, isLoan) || other.isLoan == isLoan) &&
            (identical(other.debtForMe, debtForMe) ||
                other.debtForMe == debtForMe) &&
            (identical(other.debt, debt) || other.debt == debt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, username, amount,
      comment, transactionId, isLoan, debtForMe, debt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PayDebtRequestObjectCopyWith<_$_PayDebtRequestObject> get copyWith =>
      __$$_PayDebtRequestObjectCopyWithImpl<_$_PayDebtRequestObject>(
          this, _$identity);
}

abstract class _PayDebtRequestObject implements PayDebtRequestObject {
  factory _PayDebtRequestObject(
      final int? userId,
      final String? username,
      final int? amount,
      final String? comment,
      final int? transactionId,
      final bool? isLoan,
      final int? debtForMe,
      final int? debt) = _$_PayDebtRequestObject;

  @override
  int? get userId;
  @override
  String? get username;
  @override
  int? get amount;
  @override
  String? get comment;
  @override
  int? get transactionId;
  @override
  bool? get isLoan;
  @override
  int? get debtForMe;
  @override
  int? get debt;
  @override
  @JsonKey(ignore: true)
  _$$_PayDebtRequestObjectCopyWith<_$_PayDebtRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DepositWithdrawPayDebtManagerRequestObject {
  int? get managerId => throw _privateConstructorUsedError;
  String? get managerUsername => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  bool? get isLoan => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DepositWithdrawPayDebtManagerRequestObjectCopyWith<
          DepositWithdrawPayDebtManagerRequestObject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DepositWithdrawPayDebtManagerRequestObjectCopyWith<$Res> {
  factory $DepositWithdrawPayDebtManagerRequestObjectCopyWith(
          DepositWithdrawPayDebtManagerRequestObject value,
          $Res Function(DepositWithdrawPayDebtManagerRequestObject) then) =
      _$DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl<$Res,
          DepositWithdrawPayDebtManagerRequestObject>;
  @useResult
  $Res call(
      {int? managerId,
      String? managerUsername,
      int? amount,
      String? comment,
      String? transactionId,
      bool? isLoan});
}

/// @nodoc
class _$DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl<$Res,
        $Val extends DepositWithdrawPayDebtManagerRequestObject>
    implements $DepositWithdrawPayDebtManagerRequestObjectCopyWith<$Res> {
  _$DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl(
      this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? managerId = freezed,
    Object? managerUsername = freezed,
    Object? amount = freezed,
    Object? comment = freezed,
    Object? transactionId = freezed,
    Object? isLoan = freezed,
  }) {
    return _then(_value.copyWith(
      managerId: freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as int?,
      managerUsername: freezed == managerUsername
          ? _value.managerUsername
          : managerUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoan: freezed == isLoan
          ? _value.isLoan
          : isLoan // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DepositWithdrawPayDebtManagerRequestObjectCopyWith<$Res>
    implements $DepositWithdrawPayDebtManagerRequestObjectCopyWith<$Res> {
  factory _$$_DepositWithdrawPayDebtManagerRequestObjectCopyWith(
          _$_DepositWithdrawPayDebtManagerRequestObject value,
          $Res Function(_$_DepositWithdrawPayDebtManagerRequestObject) then) =
      __$$_DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? managerId,
      String? managerUsername,
      int? amount,
      String? comment,
      String? transactionId,
      bool? isLoan});
}

/// @nodoc
class __$$_DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl<$Res>
    extends _$DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl<$Res,
        _$_DepositWithdrawPayDebtManagerRequestObject>
    implements _$$_DepositWithdrawPayDebtManagerRequestObjectCopyWith<$Res> {
  __$$_DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl(
      _$_DepositWithdrawPayDebtManagerRequestObject _value,
      $Res Function(_$_DepositWithdrawPayDebtManagerRequestObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? managerId = freezed,
    Object? managerUsername = freezed,
    Object? amount = freezed,
    Object? comment = freezed,
    Object? transactionId = freezed,
    Object? isLoan = freezed,
  }) {
    return _then(_$_DepositWithdrawPayDebtManagerRequestObject(
      freezed == managerId
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == managerUsername
          ? _value.managerUsername
          : managerUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == isLoan
          ? _value.isLoan
          : isLoan // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_DepositWithdrawPayDebtManagerRequestObject
    implements _DepositWithdrawPayDebtManagerRequestObject {
  _$_DepositWithdrawPayDebtManagerRequestObject(
      this.managerId,
      this.managerUsername,
      this.amount,
      this.comment,
      this.transactionId,
      this.isLoan);

  @override
  final int? managerId;
  @override
  final String? managerUsername;
  @override
  final int? amount;
  @override
  final String? comment;
  @override
  final String? transactionId;
  @override
  final bool? isLoan;

  @override
  String toString() {
    return 'DepositWithdrawPayDebtManagerRequestObject(managerId: $managerId, managerUsername: $managerUsername, amount: $amount, comment: $comment, transactionId: $transactionId, isLoan: $isLoan)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DepositWithdrawPayDebtManagerRequestObject &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            (identical(other.managerUsername, managerUsername) ||
                other.managerUsername == managerUsername) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.isLoan, isLoan) || other.isLoan == isLoan));
  }

  @override
  int get hashCode => Object.hash(runtimeType, managerId, managerUsername,
      amount, comment, transactionId, isLoan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DepositWithdrawPayDebtManagerRequestObjectCopyWith<
          _$_DepositWithdrawPayDebtManagerRequestObject>
      get copyWith =>
          __$$_DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl<
              _$_DepositWithdrawPayDebtManagerRequestObject>(this, _$identity);
}

abstract class _DepositWithdrawPayDebtManagerRequestObject
    implements DepositWithdrawPayDebtManagerRequestObject {
  factory _DepositWithdrawPayDebtManagerRequestObject(
      final int? managerId,
      final String? managerUsername,
      final int? amount,
      final String? comment,
      final String? transactionId,
      final bool? isLoan) = _$_DepositWithdrawPayDebtManagerRequestObject;

  @override
  int? get managerId;
  @override
  String? get managerUsername;
  @override
  int? get amount;
  @override
  String? get comment;
  @override
  String? get transactionId;
  @override
  bool? get isLoan;
  @override
  @JsonKey(ignore: true)
  _$$_DepositWithdrawPayDebtManagerRequestObjectCopyWith<
          _$_DepositWithdrawPayDebtManagerRequestObject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddEditManagerRequestObject {
  String? get username => throw _privateConstructorUsedError;
  int? get enabled => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  String? get confirmPassword => throw _privateConstructorUsedError;
  int? get aclGroupId => throw _privateConstructorUsedError;
  int? get parentId => throw _privateConstructorUsedError;
  String? get firstname => throw _privateConstructorUsedError;
  String? get lastname => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddEditManagerRequestObjectCopyWith<AddEditManagerRequestObject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddEditManagerRequestObjectCopyWith<$Res> {
  factory $AddEditManagerRequestObjectCopyWith(
          AddEditManagerRequestObject value,
          $Res Function(AddEditManagerRequestObject) then) =
      _$AddEditManagerRequestObjectCopyWithImpl<$Res,
          AddEditManagerRequestObject>;
  @useResult
  $Res call(
      {String? username,
      int? enabled,
      String? password,
      String? confirmPassword,
      int? aclGroupId,
      int? parentId,
      String? firstname,
      String? lastname,
      String? company,
      String? email,
      String? phone,
      String? city,
      String? address,
      String? notes});
}

/// @nodoc
class _$AddEditManagerRequestObjectCopyWithImpl<$Res,
        $Val extends AddEditManagerRequestObject>
    implements $AddEditManagerRequestObjectCopyWith<$Res> {
  _$AddEditManagerRequestObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? enabled = freezed,
    Object? password = freezed,
    Object? confirmPassword = freezed,
    Object? aclGroupId = freezed,
    Object? parentId = freezed,
    Object? firstname = freezed,
    Object? lastname = freezed,
    Object? company = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? city = freezed,
    Object? address = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      enabled: freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as int?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword: freezed == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      aclGroupId: freezed == aclGroupId
          ? _value.aclGroupId
          : aclGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstname: freezed == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname: freezed == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddEditManagerRequestObjectCopyWith<$Res>
    implements $AddEditManagerRequestObjectCopyWith<$Res> {
  factory _$$_AddEditManagerRequestObjectCopyWith(
          _$_AddEditManagerRequestObject value,
          $Res Function(_$_AddEditManagerRequestObject) then) =
      __$$_AddEditManagerRequestObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? username,
      int? enabled,
      String? password,
      String? confirmPassword,
      int? aclGroupId,
      int? parentId,
      String? firstname,
      String? lastname,
      String? company,
      String? email,
      String? phone,
      String? city,
      String? address,
      String? notes});
}

/// @nodoc
class __$$_AddEditManagerRequestObjectCopyWithImpl<$Res>
    extends _$AddEditManagerRequestObjectCopyWithImpl<$Res,
        _$_AddEditManagerRequestObject>
    implements _$$_AddEditManagerRequestObjectCopyWith<$Res> {
  __$$_AddEditManagerRequestObjectCopyWithImpl(
      _$_AddEditManagerRequestObject _value,
      $Res Function(_$_AddEditManagerRequestObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? enabled = freezed,
    Object? password = freezed,
    Object? confirmPassword = freezed,
    Object? aclGroupId = freezed,
    Object? parentId = freezed,
    Object? firstname = freezed,
    Object? lastname = freezed,
    Object? company = freezed,
    Object? email = freezed,
    Object? phone = freezed,
    Object? city = freezed,
    Object? address = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$_AddEditManagerRequestObject(
      freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == confirmPassword
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == aclGroupId
          ? _value.aclGroupId
          : aclGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      freezed == firstname
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == lastname
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AddEditManagerRequestObject implements _AddEditManagerRequestObject {
  _$_AddEditManagerRequestObject(
      this.username,
      this.enabled,
      this.password,
      this.confirmPassword,
      this.aclGroupId,
      this.parentId,
      this.firstname,
      this.lastname,
      this.company,
      this.email,
      this.phone,
      this.city,
      this.address,
      this.notes);

  @override
  final String? username;
  @override
  final int? enabled;
  @override
  final String? password;
  @override
  final String? confirmPassword;
  @override
  final int? aclGroupId;
  @override
  final int? parentId;
  @override
  final String? firstname;
  @override
  final String? lastname;
  @override
  final String? company;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? city;
  @override
  final String? address;
  @override
  final String? notes;

  @override
  String toString() {
    return 'AddEditManagerRequestObject(username: $username, enabled: $enabled, password: $password, confirmPassword: $confirmPassword, aclGroupId: $aclGroupId, parentId: $parentId, firstname: $firstname, lastname: $lastname, company: $company, email: $email, phone: $phone, city: $city, address: $address, notes: $notes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddEditManagerRequestObject &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.confirmPassword, confirmPassword) ||
                other.confirmPassword == confirmPassword) &&
            (identical(other.aclGroupId, aclGroupId) ||
                other.aclGroupId == aclGroupId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.firstname, firstname) ||
                other.firstname == firstname) &&
            (identical(other.lastname, lastname) ||
                other.lastname == lastname) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      username,
      enabled,
      password,
      confirmPassword,
      aclGroupId,
      parentId,
      firstname,
      lastname,
      company,
      email,
      phone,
      city,
      address,
      notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddEditManagerRequestObjectCopyWith<_$_AddEditManagerRequestObject>
      get copyWith => __$$_AddEditManagerRequestObjectCopyWithImpl<
          _$_AddEditManagerRequestObject>(this, _$identity);
}

abstract class _AddEditManagerRequestObject
    implements AddEditManagerRequestObject {
  factory _AddEditManagerRequestObject(
      final String? username,
      final int? enabled,
      final String? password,
      final String? confirmPassword,
      final int? aclGroupId,
      final int? parentId,
      final String? firstname,
      final String? lastname,
      final String? company,
      final String? email,
      final String? phone,
      final String? city,
      final String? address,
      final String? notes) = _$_AddEditManagerRequestObject;

  @override
  String? get username;
  @override
  int? get enabled;
  @override
  String? get password;
  @override
  String? get confirmPassword;
  @override
  int? get aclGroupId;
  @override
  int? get parentId;
  @override
  String? get firstname;
  @override
  String? get lastname;
  @override
  String? get company;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get city;
  @override
  String? get address;
  @override
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$_AddEditManagerRequestObjectCopyWith<_$_AddEditManagerRequestObject>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ManagerRequestObject {
  int get page => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;
  String get sortBy => throw _privateConstructorUsedError;
  String get direction => throw _privateConstructorUsedError;
  String get search => throw _privateConstructorUsedError;
  List<String> get columns => throw _privateConstructorUsedError;
  int get parentId => throw _privateConstructorUsedError;
  int get subManagers => throw _privateConstructorUsedError;
  int get siteId => throw _privateConstructorUsedError;
  int get aclGroupId => throw _privateConstructorUsedError;
  int get groupId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ManagerRequestObjectCopyWith<ManagerRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagerRequestObjectCopyWith<$Res> {
  factory $ManagerRequestObjectCopyWith(ManagerRequestObject value,
          $Res Function(ManagerRequestObject) then) =
      _$ManagerRequestObjectCopyWithImpl<$Res, ManagerRequestObject>;
  @useResult
  $Res call(
      {int page,
      int count,
      String sortBy,
      String direction,
      String search,
      List<String> columns,
      int parentId,
      int subManagers,
      int siteId,
      int aclGroupId,
      int groupId});
}

/// @nodoc
class _$ManagerRequestObjectCopyWithImpl<$Res,
        $Val extends ManagerRequestObject>
    implements $ManagerRequestObjectCopyWith<$Res> {
  _$ManagerRequestObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? count = null,
    Object? sortBy = null,
    Object? direction = null,
    Object? search = null,
    Object? columns = null,
    Object? parentId = null,
    Object? subManagers = null,
    Object? siteId = null,
    Object? aclGroupId = null,
    Object? groupId = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      columns: null == columns
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      parentId: null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
      subManagers: null == subManagers
          ? _value.subManagers
          : subManagers // ignore: cast_nullable_to_non_nullable
              as int,
      siteId: null == siteId
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int,
      aclGroupId: null == aclGroupId
          ? _value.aclGroupId
          : aclGroupId // ignore: cast_nullable_to_non_nullable
              as int,
      groupId: null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ManagerRequestObjectCopyWith<$Res>
    implements $ManagerRequestObjectCopyWith<$Res> {
  factory _$$_ManagerRequestObjectCopyWith(_$_ManagerRequestObject value,
          $Res Function(_$_ManagerRequestObject) then) =
      __$$_ManagerRequestObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      int count,
      String sortBy,
      String direction,
      String search,
      List<String> columns,
      int parentId,
      int subManagers,
      int siteId,
      int aclGroupId,
      int groupId});
}

/// @nodoc
class __$$_ManagerRequestObjectCopyWithImpl<$Res>
    extends _$ManagerRequestObjectCopyWithImpl<$Res, _$_ManagerRequestObject>
    implements _$$_ManagerRequestObjectCopyWith<$Res> {
  __$$_ManagerRequestObjectCopyWithImpl(_$_ManagerRequestObject _value,
      $Res Function(_$_ManagerRequestObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? count = null,
    Object? sortBy = null,
    Object? direction = null,
    Object? search = null,
    Object? columns = null,
    Object? parentId = null,
    Object? subManagers = null,
    Object? siteId = null,
    Object? aclGroupId = null,
    Object? groupId = null,
  }) {
    return _then(_$_ManagerRequestObject(
      null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      null == columns
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      null == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
      null == subManagers
          ? _value.subManagers
          : subManagers // ignore: cast_nullable_to_non_nullable
              as int,
      null == siteId
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int,
      null == aclGroupId
          ? _value.aclGroupId
          : aclGroupId // ignore: cast_nullable_to_non_nullable
              as int,
      null == groupId
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ManagerRequestObject implements _ManagerRequestObject {
  _$_ManagerRequestObject(
      this.page,
      this.count,
      this.sortBy,
      this.direction,
      this.search,
      final List<String> columns,
      this.parentId,
      this.subManagers,
      this.siteId,
      this.aclGroupId,
      this.groupId)
      : _columns = columns;

  @override
  final int page;
  @override
  final int count;
  @override
  final String sortBy;
  @override
  final String direction;
  @override
  final String search;
  final List<String> _columns;
  @override
  List<String> get columns {
    if (_columns is EqualUnmodifiableListView) return _columns;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_columns);
  }

  @override
  final int parentId;
  @override
  final int subManagers;
  @override
  final int siteId;
  @override
  final int aclGroupId;
  @override
  final int groupId;

  @override
  String toString() {
    return 'ManagerRequestObject(page: $page, count: $count, sortBy: $sortBy, direction: $direction, search: $search, columns: $columns, parentId: $parentId, subManagers: $subManagers, siteId: $siteId, aclGroupId: $aclGroupId, groupId: $groupId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ManagerRequestObject &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.search, search) || other.search == search) &&
            const DeepCollectionEquality().equals(other._columns, _columns) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.subManagers, subManagers) ||
                other.subManagers == subManagers) &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.aclGroupId, aclGroupId) ||
                other.aclGroupId == aclGroupId) &&
            (identical(other.groupId, groupId) || other.groupId == groupId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      page,
      count,
      sortBy,
      direction,
      search,
      const DeepCollectionEquality().hash(_columns),
      parentId,
      subManagers,
      siteId,
      aclGroupId,
      groupId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ManagerRequestObjectCopyWith<_$_ManagerRequestObject> get copyWith =>
      __$$_ManagerRequestObjectCopyWithImpl<_$_ManagerRequestObject>(
          this, _$identity);
}

abstract class _ManagerRequestObject implements ManagerRequestObject {
  factory _ManagerRequestObject(
      final int page,
      final int count,
      final String sortBy,
      final String direction,
      final String search,
      final List<String> columns,
      final int parentId,
      final int subManagers,
      final int siteId,
      final int aclGroupId,
      final int groupId) = _$_ManagerRequestObject;

  @override
  int get page;
  @override
  int get count;
  @override
  String get sortBy;
  @override
  String get direction;
  @override
  String get search;
  @override
  List<String> get columns;
  @override
  int get parentId;
  @override
  int get subManagers;
  @override
  int get siteId;
  @override
  int get aclGroupId;
  @override
  int get groupId;
  @override
  @JsonKey(ignore: true)
  _$$_ManagerRequestObjectCopyWith<_$_ManagerRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}
