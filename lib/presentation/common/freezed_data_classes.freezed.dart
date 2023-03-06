// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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
      _$LoginObjectCopyWithImpl<$Res>;
  $Res call(
      {String username,
      String password,
      String language,
      String otp,
      String captchaText,
      String sessionId});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res> implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  final LoginObject _value;
  // ignore: unused_field
  final $Res Function(LoginObject) _then;

  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
    Object? language = freezed,
    Object? otp = freezed,
    Object? captchaText = freezed,
    Object? sessionId = freezed,
  }) {
    return _then(_value.copyWith(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      language: language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      otp: otp == freezed
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      captchaText: captchaText == freezed
          ? _value.captchaText
          : captchaText // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId: sessionId == freezed
          ? _value.sessionId
          : sessionId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$_LoginObjectCopyWith(
          _$_LoginObject value, $Res Function(_$_LoginObject) then) =
      __$$_LoginObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String username,
      String password,
      String language,
      String otp,
      String captchaText,
      String sessionId});
}

/// @nodoc
class __$$_LoginObjectCopyWithImpl<$Res> extends _$LoginObjectCopyWithImpl<$Res>
    implements _$$_LoginObjectCopyWith<$Res> {
  __$$_LoginObjectCopyWithImpl(
      _$_LoginObject _value, $Res Function(_$_LoginObject) _then)
      : super(_value, (v) => _then(v as _$_LoginObject));

  @override
  _$_LoginObject get _value => super._value as _$_LoginObject;

  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
    Object? language = freezed,
    Object? otp = freezed,
    Object? captchaText = freezed,
    Object? sessionId = freezed,
  }) {
    return _then(_$_LoginObject(
      username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      language == freezed
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      otp == freezed
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      captchaText == freezed
          ? _value.captchaText
          : captchaText // ignore: cast_nullable_to_non_nullable
              as String,
      sessionId == freezed
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
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality().equals(other.language, language) &&
            const DeepCollectionEquality().equals(other.otp, otp) &&
            const DeepCollectionEquality()
                .equals(other.captchaText, captchaText) &&
            const DeepCollectionEquality().equals(other.sessionId, sessionId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(language),
      const DeepCollectionEquality().hash(otp),
      const DeepCollectionEquality().hash(captchaText),
      const DeepCollectionEquality().hash(sessionId));

  @JsonKey(ignore: true)
  @override
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
      _$UserRequestObjectCopyWithImpl<$Res>;
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
class _$UserRequestObjectCopyWithImpl<$Res>
    implements $UserRequestObjectCopyWith<$Res> {
  _$UserRequestObjectCopyWithImpl(this._value, this._then);

  final UserRequestObject _value;
  // ignore: unused_field
  final $Res Function(UserRequestObject) _then;

  @override
  $Res call({
    Object? page = freezed,
    Object? count = freezed,
    Object? sortBy = freezed,
    Object? direction = freezed,
    Object? search = freezed,
    Object? columns = freezed,
    Object? status = freezed,
    Object? connection = freezed,
    Object? profileId = freezed,
    Object? parentId = freezed,
    Object? groupId = freezed,
    Object? siteId = freezed,
    Object? subUsers = freezed,
    Object? mac = freezed,
  }) {
    return _then(_value.copyWith(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      sortBy: sortBy == freezed
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      search: search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      columns: columns == freezed
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      connection: connection == freezed
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as int,
      profileId: profileId == freezed
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: parentId == freezed
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
      groupId: groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      siteId: siteId == freezed
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int,
      subUsers: subUsers == freezed
          ? _value.subUsers
          : subUsers // ignore: cast_nullable_to_non_nullable
              as int,
      mac: mac == freezed
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_UserRequestObjectCopyWith<$Res>
    implements $UserRequestObjectCopyWith<$Res> {
  factory _$$_UserRequestObjectCopyWith(_$_UserRequestObject value,
          $Res Function(_$_UserRequestObject) then) =
      __$$_UserRequestObjectCopyWithImpl<$Res>;
  @override
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
    extends _$UserRequestObjectCopyWithImpl<$Res>
    implements _$$_UserRequestObjectCopyWith<$Res> {
  __$$_UserRequestObjectCopyWithImpl(
      _$_UserRequestObject _value, $Res Function(_$_UserRequestObject) _then)
      : super(_value, (v) => _then(v as _$_UserRequestObject));

  @override
  _$_UserRequestObject get _value => super._value as _$_UserRequestObject;

  @override
  $Res call({
    Object? page = freezed,
    Object? count = freezed,
    Object? sortBy = freezed,
    Object? direction = freezed,
    Object? search = freezed,
    Object? columns = freezed,
    Object? status = freezed,
    Object? connection = freezed,
    Object? profileId = freezed,
    Object? parentId = freezed,
    Object? groupId = freezed,
    Object? siteId = freezed,
    Object? subUsers = freezed,
    Object? mac = freezed,
  }) {
    return _then(_$_UserRequestObject(
      page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      sortBy == freezed
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String,
      direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String,
      search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
      columns == freezed
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      connection == freezed
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as int,
      profileId == freezed
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as int,
      parentId == freezed
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int,
      groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int,
      siteId == freezed
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int,
      subUsers == freezed
          ? _value.subUsers
          : subUsers // ignore: cast_nullable_to_non_nullable
              as int,
      mac == freezed
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
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality().equals(other.sortBy, sortBy) &&
            const DeepCollectionEquality().equals(other.direction, direction) &&
            const DeepCollectionEquality().equals(other.search, search) &&
            const DeepCollectionEquality().equals(other._columns, _columns) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.connection, connection) &&
            const DeepCollectionEquality().equals(other.profileId, profileId) &&
            const DeepCollectionEquality().equals(other.parentId, parentId) &&
            const DeepCollectionEquality().equals(other.groupId, groupId) &&
            const DeepCollectionEquality().equals(other.siteId, siteId) &&
            const DeepCollectionEquality().equals(other.subUsers, subUsers) &&
            const DeepCollectionEquality().equals(other.mac, mac));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(sortBy),
      const DeepCollectionEquality().hash(direction),
      const DeepCollectionEquality().hash(search),
      const DeepCollectionEquality().hash(_columns),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(connection),
      const DeepCollectionEquality().hash(profileId),
      const DeepCollectionEquality().hash(parentId),
      const DeepCollectionEquality().hash(groupId),
      const DeepCollectionEquality().hash(siteId),
      const DeepCollectionEquality().hash(subUsers),
      const DeepCollectionEquality().hash(mac));

  @JsonKey(ignore: true)
  @override
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
      _$ActivationRequestObjectCopyWithImpl<$Res>;
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
class _$ActivationRequestObjectCopyWithImpl<$Res>
    implements $ActivationRequestObjectCopyWith<$Res> {
  _$ActivationRequestObjectCopyWithImpl(this._value, this._then);

  final ActivationRequestObject _value;
  // ignore: unused_field
  final $Res Function(ActivationRequestObject) _then;

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
      method: method == freezed
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      pin: pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      moneyCollected: moneyCollected == freezed
          ? _value.moneyCollected
          : moneyCollected // ignore: cast_nullable_to_non_nullable
              as int?,
      comments: comments == freezed
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
      userPrice: userPrice == freezed
          ? _value.userPrice
          : userPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      issueInvoice: issueInvoice == freezed
          ? _value.issueInvoice
          : issueInvoice // ignore: cast_nullable_to_non_nullable
              as bool?,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      activationUnits: activationUnits == freezed
          ? _value.activationUnits
          : activationUnits // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_ActivationRequestObjectCopyWith<$Res>
    implements $ActivationRequestObjectCopyWith<$Res> {
  factory _$$_ActivationRequestObjectCopyWith(_$_ActivationRequestObject value,
          $Res Function(_$_ActivationRequestObject) then) =
      __$$_ActivationRequestObjectCopyWithImpl<$Res>;
  @override
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
    extends _$ActivationRequestObjectCopyWithImpl<$Res>
    implements _$$_ActivationRequestObjectCopyWith<$Res> {
  __$$_ActivationRequestObjectCopyWithImpl(_$_ActivationRequestObject _value,
      $Res Function(_$_ActivationRequestObject) _then)
      : super(_value, (v) => _then(v as _$_ActivationRequestObject));

  @override
  _$_ActivationRequestObject get _value =>
      super._value as _$_ActivationRequestObject;

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
      method == freezed
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      pin == freezed
          ? _value.pin
          : pin // ignore: cast_nullable_to_non_nullable
              as String?,
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      moneyCollected == freezed
          ? _value.moneyCollected
          : moneyCollected // ignore: cast_nullable_to_non_nullable
              as int?,
      comments == freezed
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as String?,
      userPrice == freezed
          ? _value.userPrice
          : userPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      issueInvoice == freezed
          ? _value.issueInvoice
          : issueInvoice // ignore: cast_nullable_to_non_nullable
              as bool?,
      transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      activationUnits == freezed
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
            const DeepCollectionEquality().equals(other.method, method) &&
            const DeepCollectionEquality().equals(other.pin, pin) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.moneyCollected, moneyCollected) &&
            const DeepCollectionEquality().equals(other.comments, comments) &&
            const DeepCollectionEquality().equals(other.userPrice, userPrice) &&
            const DeepCollectionEquality()
                .equals(other.issueInvoice, issueInvoice) &&
            const DeepCollectionEquality()
                .equals(other.transactionId, transactionId) &&
            const DeepCollectionEquality()
                .equals(other.activationUnits, activationUnits));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(method),
      const DeepCollectionEquality().hash(pin),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(moneyCollected),
      const DeepCollectionEquality().hash(comments),
      const DeepCollectionEquality().hash(userPrice),
      const DeepCollectionEquality().hash(issueInvoice),
      const DeepCollectionEquality().hash(transactionId),
      const DeepCollectionEquality().hash(activationUnits));

  @JsonKey(ignore: true)
  @override
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
      _$AddUserRequestObjectCopyWithImpl<$Res>;
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
class _$AddUserRequestObjectCopyWithImpl<$Res>
    implements $AddUserRequestObjectCopyWith<$Res> {
  _$AddUserRequestObjectCopyWithImpl(this._value, this._then);

  final AddUserRequestObject _value;
  // ignore: unused_field
  final $Res Function(AddUserRequestObject) _then;

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
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as int?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      profileId: profileId == freezed
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId: parentId == freezed
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      siteId: siteId == freezed
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int?,
      macAuth: macAuth == freezed
          ? _value.macAuth
          : macAuth // ignore: cast_nullable_to_non_nullable
              as int?,
      allowedMacs: allowedMacs == freezed
          ? _value.allowedMacs
          : allowedMacs // ignore: cast_nullable_to_non_nullable
              as int?,
      useSeparatePortalPassword: useSeparatePortalPassword == freezed
          ? _value.useSeparatePortalPassword
          : useSeparatePortalPassword // ignore: cast_nullable_to_non_nullable
              as int?,
      portalPassword: portalPassword == freezed
          ? _value.portalPassword
          : portalPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId: groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstname: firstname == freezed
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname: lastname == freezed
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      company: company == freezed
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment: apartment == freezed
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      street: street == freezed
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      contractId: contractId == freezed
          ? _value.contractId
          : contractId // ignore: cast_nullable_to_non_nullable
              as int?,
      nationalId: nationalId == freezed
          ? _value.nationalId
          : nationalId // ignore: cast_nullable_to_non_nullable
              as int?,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      autoRenew: autoRenew == freezed
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as int?,
      expiration: expiration == freezed
          ? _value.expiration
          : expiration // ignore: cast_nullable_to_non_nullable
              as String?,
      simultaneousSessions: simultaneousSessions == freezed
          ? _value.simultaneousSessions
          : simultaneousSessions // ignore: cast_nullable_to_non_nullable
              as int?,
      staticIp: staticIp == freezed
          ? _value.staticIp
          : staticIp // ignore: cast_nullable_to_non_nullable
              as int?,
      userType: userType == freezed
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      restricted: restricted == freezed
          ? _value.restricted
          : restricted // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_AddUserRequestObjectCopyWith<$Res>
    implements $AddUserRequestObjectCopyWith<$Res> {
  factory _$$_AddUserRequestObjectCopyWith(_$_AddUserRequestObject value,
          $Res Function(_$_AddUserRequestObject) then) =
      __$$_AddUserRequestObjectCopyWithImpl<$Res>;
  @override
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
    extends _$AddUserRequestObjectCopyWithImpl<$Res>
    implements _$$_AddUserRequestObjectCopyWith<$Res> {
  __$$_AddUserRequestObjectCopyWithImpl(_$_AddUserRequestObject _value,
      $Res Function(_$_AddUserRequestObject) _then)
      : super(_value, (v) => _then(v as _$_AddUserRequestObject));

  @override
  _$_AddUserRequestObject get _value => super._value as _$_AddUserRequestObject;

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
      username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as int?,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      profileId == freezed
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId == freezed
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      siteId == freezed
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int?,
      macAuth == freezed
          ? _value.macAuth
          : macAuth // ignore: cast_nullable_to_non_nullable
              as int?,
      allowedMacs == freezed
          ? _value.allowedMacs
          : allowedMacs // ignore: cast_nullable_to_non_nullable
              as int?,
      useSeparatePortalPassword == freezed
          ? _value.useSeparatePortalPassword
          : useSeparatePortalPassword // ignore: cast_nullable_to_non_nullable
              as int?,
      portalPassword == freezed
          ? _value.portalPassword
          : portalPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstname == freezed
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname == freezed
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      company == freezed
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      apartment == freezed
          ? _value.apartment
          : apartment // ignore: cast_nullable_to_non_nullable
              as String?,
      street == freezed
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String?,
      contractId == freezed
          ? _value.contractId
          : contractId // ignore: cast_nullable_to_non_nullable
              as int?,
      nationalId == freezed
          ? _value.nationalId
          : nationalId // ignore: cast_nullable_to_non_nullable
              as int?,
      notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      autoRenew == freezed
          ? _value.autoRenew
          : autoRenew // ignore: cast_nullable_to_non_nullable
              as int?,
      expiration == freezed
          ? _value.expiration
          : expiration // ignore: cast_nullable_to_non_nullable
              as String?,
      simultaneousSessions == freezed
          ? _value.simultaneousSessions
          : simultaneousSessions // ignore: cast_nullable_to_non_nullable
              as int?,
      staticIp == freezed
          ? _value.staticIp
          : staticIp // ignore: cast_nullable_to_non_nullable
              as int?,
      userType == freezed
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      restricted == freezed
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
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality()
                .equals(other.confirmPassword, confirmPassword) &&
            const DeepCollectionEquality().equals(other.profileId, profileId) &&
            const DeepCollectionEquality().equals(other.parentId, parentId) &&
            const DeepCollectionEquality().equals(other.siteId, siteId) &&
            const DeepCollectionEquality().equals(other.macAuth, macAuth) &&
            const DeepCollectionEquality()
                .equals(other.allowedMacs, allowedMacs) &&
            const DeepCollectionEquality().equals(
                other.useSeparatePortalPassword, useSeparatePortalPassword) &&
            const DeepCollectionEquality()
                .equals(other.portalPassword, portalPassword) &&
            const DeepCollectionEquality().equals(other.groupId, groupId) &&
            const DeepCollectionEquality().equals(other.firstname, firstname) &&
            const DeepCollectionEquality().equals(other.lastname, lastname) &&
            const DeepCollectionEquality().equals(other.company, company) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.apartment, apartment) &&
            const DeepCollectionEquality().equals(other.street, street) &&
            const DeepCollectionEquality()
                .equals(other.contractId, contractId) &&
            const DeepCollectionEquality()
                .equals(other.nationalId, nationalId) &&
            const DeepCollectionEquality().equals(other.notes, notes) &&
            const DeepCollectionEquality().equals(other.autoRenew, autoRenew) &&
            const DeepCollectionEquality()
                .equals(other.expiration, expiration) &&
            const DeepCollectionEquality()
                .equals(other.simultaneousSessions, simultaneousSessions) &&
            const DeepCollectionEquality().equals(other.staticIp, staticIp) &&
            const DeepCollectionEquality().equals(other.userType, userType) &&
            const DeepCollectionEquality()
                .equals(other.restricted, restricted));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(username),
        const DeepCollectionEquality().hash(enabled),
        const DeepCollectionEquality().hash(password),
        const DeepCollectionEquality().hash(confirmPassword),
        const DeepCollectionEquality().hash(profileId),
        const DeepCollectionEquality().hash(parentId),
        const DeepCollectionEquality().hash(siteId),
        const DeepCollectionEquality().hash(macAuth),
        const DeepCollectionEquality().hash(allowedMacs),
        const DeepCollectionEquality().hash(useSeparatePortalPassword),
        const DeepCollectionEquality().hash(portalPassword),
        const DeepCollectionEquality().hash(groupId),
        const DeepCollectionEquality().hash(firstname),
        const DeepCollectionEquality().hash(lastname),
        const DeepCollectionEquality().hash(company),
        const DeepCollectionEquality().hash(email),
        const DeepCollectionEquality().hash(phone),
        const DeepCollectionEquality().hash(city),
        const DeepCollectionEquality().hash(address),
        const DeepCollectionEquality().hash(apartment),
        const DeepCollectionEquality().hash(street),
        const DeepCollectionEquality().hash(contractId),
        const DeepCollectionEquality().hash(nationalId),
        const DeepCollectionEquality().hash(notes),
        const DeepCollectionEquality().hash(autoRenew),
        const DeepCollectionEquality().hash(expiration),
        const DeepCollectionEquality().hash(simultaneousSessions),
        const DeepCollectionEquality().hash(staticIp),
        const DeepCollectionEquality().hash(userType),
        const DeepCollectionEquality().hash(restricted)
      ]);

  @JsonKey(ignore: true)
  @override
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
      _$ExtendUserRequestObjectCopyWithImpl<$Res>;
  $Res call(
      {String? userId,
      String? profileId,
      String? method,
      String? transactionId});
}

/// @nodoc
class _$ExtendUserRequestObjectCopyWithImpl<$Res>
    implements $ExtendUserRequestObjectCopyWith<$Res> {
  _$ExtendUserRequestObjectCopyWithImpl(this._value, this._then);

  final ExtendUserRequestObject _value;
  // ignore: unused_field
  final $Res Function(ExtendUserRequestObject) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? profileId = freezed,
    Object? method = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      profileId: profileId == freezed
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String?,
      method: method == freezed
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_ExtendUserRequestObjectCopyWith<$Res>
    implements $ExtendUserRequestObjectCopyWith<$Res> {
  factory _$$_ExtendUserRequestObjectCopyWith(_$_ExtendUserRequestObject value,
          $Res Function(_$_ExtendUserRequestObject) then) =
      __$$_ExtendUserRequestObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? userId,
      String? profileId,
      String? method,
      String? transactionId});
}

/// @nodoc
class __$$_ExtendUserRequestObjectCopyWithImpl<$Res>
    extends _$ExtendUserRequestObjectCopyWithImpl<$Res>
    implements _$$_ExtendUserRequestObjectCopyWith<$Res> {
  __$$_ExtendUserRequestObjectCopyWithImpl(_$_ExtendUserRequestObject _value,
      $Res Function(_$_ExtendUserRequestObject) _then)
      : super(_value, (v) => _then(v as _$_ExtendUserRequestObject));

  @override
  _$_ExtendUserRequestObject get _value =>
      super._value as _$_ExtendUserRequestObject;

  @override
  $Res call({
    Object? userId = freezed,
    Object? profileId = freezed,
    Object? method = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_$_ExtendUserRequestObject(
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      profileId == freezed
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String?,
      method == freezed
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId == freezed
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
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.profileId, profileId) &&
            const DeepCollectionEquality().equals(other.method, method) &&
            const DeepCollectionEquality()
                .equals(other.transactionId, transactionId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(profileId),
      const DeepCollectionEquality().hash(method),
      const DeepCollectionEquality().hash(transactionId));

  @JsonKey(ignore: true)
  @override
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
      _$DepositWithdrawUserRequestObjectCopyWithImpl<$Res>;
  $Res call(
      {String? userId,
      String? userUsername,
      int? amount,
      String? comment,
      String? transactionId});
}

/// @nodoc
class _$DepositWithdrawUserRequestObjectCopyWithImpl<$Res>
    implements $DepositWithdrawUserRequestObjectCopyWith<$Res> {
  _$DepositWithdrawUserRequestObjectCopyWithImpl(this._value, this._then);

  final DepositWithdrawUserRequestObject _value;
  // ignore: unused_field
  final $Res Function(DepositWithdrawUserRequestObject) _then;

  @override
  $Res call({
    Object? userId = freezed,
    Object? userUsername = freezed,
    Object? amount = freezed,
    Object? comment = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_value.copyWith(
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userUsername: userUsername == freezed
          ? _value.userUsername
          : userUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
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
  $Res call(
      {String? userId,
      String? userUsername,
      int? amount,
      String? comment,
      String? transactionId});
}

/// @nodoc
class __$$_DepositWithdrawUserRequestObjectCopyWithImpl<$Res>
    extends _$DepositWithdrawUserRequestObjectCopyWithImpl<$Res>
    implements _$$_DepositWithdrawUserRequestObjectCopyWith<$Res> {
  __$$_DepositWithdrawUserRequestObjectCopyWithImpl(
      _$_DepositWithdrawUserRequestObject _value,
      $Res Function(_$_DepositWithdrawUserRequestObject) _then)
      : super(_value, (v) => _then(v as _$_DepositWithdrawUserRequestObject));

  @override
  _$_DepositWithdrawUserRequestObject get _value =>
      super._value as _$_DepositWithdrawUserRequestObject;

  @override
  $Res call({
    Object? userId = freezed,
    Object? userUsername = freezed,
    Object? amount = freezed,
    Object? comment = freezed,
    Object? transactionId = freezed,
  }) {
    return _then(_$_DepositWithdrawUserRequestObject(
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      userUsername == freezed
          ? _value.userUsername
          : userUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId == freezed
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
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.userUsername, userUsername) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.comment, comment) &&
            const DeepCollectionEquality()
                .equals(other.transactionId, transactionId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(userUsername),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(comment),
      const DeepCollectionEquality().hash(transactionId));

  @JsonKey(ignore: true)
  @override
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
      _$PayDebtRequestObjectCopyWithImpl<$Res>;
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
class _$PayDebtRequestObjectCopyWithImpl<$Res>
    implements $PayDebtRequestObjectCopyWith<$Res> {
  _$PayDebtRequestObjectCopyWithImpl(this._value, this._then);

  final PayDebtRequestObject _value;
  // ignore: unused_field
  final $Res Function(PayDebtRequestObject) _then;

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
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
      isLoan: isLoan == freezed
          ? _value.isLoan
          : isLoan // ignore: cast_nullable_to_non_nullable
              as bool?,
      debtForMe: debtForMe == freezed
          ? _value.debtForMe
          : debtForMe // ignore: cast_nullable_to_non_nullable
              as int?,
      debt: debt == freezed
          ? _value.debt
          : debt // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_PayDebtRequestObjectCopyWith<$Res>
    implements $PayDebtRequestObjectCopyWith<$Res> {
  factory _$$_PayDebtRequestObjectCopyWith(_$_PayDebtRequestObject value,
          $Res Function(_$_PayDebtRequestObject) then) =
      __$$_PayDebtRequestObjectCopyWithImpl<$Res>;
  @override
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
    extends _$PayDebtRequestObjectCopyWithImpl<$Res>
    implements _$$_PayDebtRequestObjectCopyWith<$Res> {
  __$$_PayDebtRequestObjectCopyWithImpl(_$_PayDebtRequestObject _value,
      $Res Function(_$_PayDebtRequestObject) _then)
      : super(_value, (v) => _then(v as _$_PayDebtRequestObject));

  @override
  _$_PayDebtRequestObject get _value => super._value as _$_PayDebtRequestObject;

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
      userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as int?,
      isLoan == freezed
          ? _value.isLoan
          : isLoan // ignore: cast_nullable_to_non_nullable
              as bool?,
      debtForMe == freezed
          ? _value.debtForMe
          : debtForMe // ignore: cast_nullable_to_non_nullable
              as int?,
      debt == freezed
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
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.comment, comment) &&
            const DeepCollectionEquality()
                .equals(other.transactionId, transactionId) &&
            const DeepCollectionEquality().equals(other.isLoan, isLoan) &&
            const DeepCollectionEquality().equals(other.debtForMe, debtForMe) &&
            const DeepCollectionEquality().equals(other.debt, debt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(comment),
      const DeepCollectionEquality().hash(transactionId),
      const DeepCollectionEquality().hash(isLoan),
      const DeepCollectionEquality().hash(debtForMe),
      const DeepCollectionEquality().hash(debt));

  @JsonKey(ignore: true)
  @override
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
mixin _$ManagersListRequestObject {
  int? get page => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;
  String? get sortBy => throw _privateConstructorUsedError;
  String? get direction => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;
  List<String>? get columns => throw _privateConstructorUsedError;
  int? get parentId => throw _privateConstructorUsedError;
  int? get subManagers => throw _privateConstructorUsedError;
  int? get siteId => throw _privateConstructorUsedError;
  int? get aclGroupId => throw _privateConstructorUsedError;
  int? get groupId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ManagersListRequestObjectCopyWith<ManagersListRequestObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManagersListRequestObjectCopyWith<$Res> {
  factory $ManagersListRequestObjectCopyWith(ManagersListRequestObject value,
          $Res Function(ManagersListRequestObject) then) =
      _$ManagersListRequestObjectCopyWithImpl<$Res>;
  $Res call(
      {int? page,
      int? count,
      String? sortBy,
      String? direction,
      String? search,
      List<String>? columns,
      int? parentId,
      int? subManagers,
      int? siteId,
      int? aclGroupId,
      int? groupId});
}

/// @nodoc
class _$ManagersListRequestObjectCopyWithImpl<$Res>
    implements $ManagersListRequestObjectCopyWith<$Res> {
  _$ManagersListRequestObjectCopyWithImpl(this._value, this._then);

  final ManagersListRequestObject _value;
  // ignore: unused_field
  final $Res Function(ManagersListRequestObject) _then;

  @override
  $Res call({
    Object? page = freezed,
    Object? count = freezed,
    Object? sortBy = freezed,
    Object? direction = freezed,
    Object? search = freezed,
    Object? columns = freezed,
    Object? parentId = freezed,
    Object? subManagers = freezed,
    Object? siteId = freezed,
    Object? aclGroupId = freezed,
    Object? groupId = freezed,
  }) {
    return _then(_value.copyWith(
      page: page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      sortBy: sortBy == freezed
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
      search: search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      columns: columns == freezed
          ? _value.columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      parentId: parentId == freezed
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      subManagers: subManagers == freezed
          ? _value.subManagers
          : subManagers // ignore: cast_nullable_to_non_nullable
              as int?,
      siteId: siteId == freezed
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int?,
      aclGroupId: aclGroupId == freezed
          ? _value.aclGroupId
          : aclGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupId: groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_ManagersListRequestObjectCopyWith<$Res>
    implements $ManagersListRequestObjectCopyWith<$Res> {
  factory _$$_ManagersListRequestObjectCopyWith(
          _$_ManagersListRequestObject value,
          $Res Function(_$_ManagersListRequestObject) then) =
      __$$_ManagersListRequestObjectCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? page,
      int? count,
      String? sortBy,
      String? direction,
      String? search,
      List<String>? columns,
      int? parentId,
      int? subManagers,
      int? siteId,
      int? aclGroupId,
      int? groupId});
}

/// @nodoc
class __$$_ManagersListRequestObjectCopyWithImpl<$Res>
    extends _$ManagersListRequestObjectCopyWithImpl<$Res>
    implements _$$_ManagersListRequestObjectCopyWith<$Res> {
  __$$_ManagersListRequestObjectCopyWithImpl(
      _$_ManagersListRequestObject _value,
      $Res Function(_$_ManagersListRequestObject) _then)
      : super(_value, (v) => _then(v as _$_ManagersListRequestObject));

  @override
  _$_ManagersListRequestObject get _value =>
      super._value as _$_ManagersListRequestObject;

  @override
  $Res call({
    Object? page = freezed,
    Object? count = freezed,
    Object? sortBy = freezed,
    Object? direction = freezed,
    Object? search = freezed,
    Object? columns = freezed,
    Object? parentId = freezed,
    Object? subManagers = freezed,
    Object? siteId = freezed,
    Object? aclGroupId = freezed,
    Object? groupId = freezed,
  }) {
    return _then(_$_ManagersListRequestObject(
      page == freezed
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int?,
      count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      sortBy == freezed
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
      search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      columns == freezed
          ? _value._columns
          : columns // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      parentId == freezed
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      subManagers == freezed
          ? _value.subManagers
          : subManagers // ignore: cast_nullable_to_non_nullable
              as int?,
      siteId == freezed
          ? _value.siteId
          : siteId // ignore: cast_nullable_to_non_nullable
              as int?,
      aclGroupId == freezed
          ? _value.aclGroupId
          : aclGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      groupId == freezed
          ? _value.groupId
          : groupId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_ManagersListRequestObject implements _ManagersListRequestObject {
  _$_ManagersListRequestObject(
      this.page,
      this.count,
      this.sortBy,
      this.direction,
      this.search,
      final List<String>? columns,
      this.parentId,
      this.subManagers,
      this.siteId,
      this.aclGroupId,
      this.groupId)
      : _columns = columns;

  @override
  final int? page;
  @override
  final int? count;
  @override
  final String? sortBy;
  @override
  final String? direction;
  @override
  final String? search;
  final List<String>? _columns;
  @override
  List<String>? get columns {
    final value = _columns;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? parentId;
  @override
  final int? subManagers;
  @override
  final int? siteId;
  @override
  final int? aclGroupId;
  @override
  final int? groupId;

  @override
  String toString() {
    return 'ManagersListRequestObject(page: $page, count: $count, sortBy: $sortBy, direction: $direction, search: $search, columns: $columns, parentId: $parentId, subManagers: $subManagers, siteId: $siteId, aclGroupId: $aclGroupId, groupId: $groupId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ManagersListRequestObject &&
            const DeepCollectionEquality().equals(other.page, page) &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality().equals(other.sortBy, sortBy) &&
            const DeepCollectionEquality().equals(other.direction, direction) &&
            const DeepCollectionEquality().equals(other.search, search) &&
            const DeepCollectionEquality().equals(other._columns, _columns) &&
            const DeepCollectionEquality().equals(other.parentId, parentId) &&
            const DeepCollectionEquality()
                .equals(other.subManagers, subManagers) &&
            const DeepCollectionEquality().equals(other.siteId, siteId) &&
            const DeepCollectionEquality()
                .equals(other.aclGroupId, aclGroupId) &&
            const DeepCollectionEquality().equals(other.groupId, groupId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(page),
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(sortBy),
      const DeepCollectionEquality().hash(direction),
      const DeepCollectionEquality().hash(search),
      const DeepCollectionEquality().hash(_columns),
      const DeepCollectionEquality().hash(parentId),
      const DeepCollectionEquality().hash(subManagers),
      const DeepCollectionEquality().hash(siteId),
      const DeepCollectionEquality().hash(aclGroupId),
      const DeepCollectionEquality().hash(groupId));

  @JsonKey(ignore: true)
  @override
  _$$_ManagersListRequestObjectCopyWith<_$_ManagersListRequestObject>
      get copyWith => __$$_ManagersListRequestObjectCopyWithImpl<
          _$_ManagersListRequestObject>(this, _$identity);
}

abstract class _ManagersListRequestObject implements ManagersListRequestObject {
  factory _ManagersListRequestObject(
      final int? page,
      final int? count,
      final String? sortBy,
      final String? direction,
      final String? search,
      final List<String>? columns,
      final int? parentId,
      final int? subManagers,
      final int? siteId,
      final int? aclGroupId,
      final int? groupId) = _$_ManagersListRequestObject;

  @override
  int? get page;
  @override
  int? get count;
  @override
  String? get sortBy;
  @override
  String? get direction;
  @override
  String? get search;
  @override
  List<String>? get columns;
  @override
  int? get parentId;
  @override
  int? get subManagers;
  @override
  int? get siteId;
  @override
  int? get aclGroupId;
  @override
  int? get groupId;
  @override
  @JsonKey(ignore: true)
  _$$_ManagersListRequestObjectCopyWith<_$_ManagersListRequestObject>
      get copyWith => throw _privateConstructorUsedError;
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
      _$DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl<$Res>;
  $Res call(
      {int? managerId,
      String? managerUsername,
      int? amount,
      String? comment,
      String? transactionId,
      bool? isLoan});
}

/// @nodoc
class _$DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl<$Res>
    implements $DepositWithdrawPayDebtManagerRequestObjectCopyWith<$Res> {
  _$DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl(
      this._value, this._then);

  final DepositWithdrawPayDebtManagerRequestObject _value;
  // ignore: unused_field
  final $Res Function(DepositWithdrawPayDebtManagerRequestObject) _then;

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
      managerId: managerId == freezed
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as int?,
      managerUsername: managerUsername == freezed
          ? _value.managerUsername
          : managerUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      comment: comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoan: isLoan == freezed
          ? _value.isLoan
          : isLoan // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
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
    extends _$DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl<$Res>
    implements _$$_DepositWithdrawPayDebtManagerRequestObjectCopyWith<$Res> {
  __$$_DepositWithdrawPayDebtManagerRequestObjectCopyWithImpl(
      _$_DepositWithdrawPayDebtManagerRequestObject _value,
      $Res Function(_$_DepositWithdrawPayDebtManagerRequestObject) _then)
      : super(_value,
            (v) => _then(v as _$_DepositWithdrawPayDebtManagerRequestObject));

  @override
  _$_DepositWithdrawPayDebtManagerRequestObject get _value =>
      super._value as _$_DepositWithdrawPayDebtManagerRequestObject;

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
      managerId == freezed
          ? _value.managerId
          : managerId // ignore: cast_nullable_to_non_nullable
              as int?,
      managerUsername == freezed
          ? _value.managerUsername
          : managerUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      amount == freezed
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      comment == freezed
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId == freezed
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      isLoan == freezed
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
            const DeepCollectionEquality().equals(other.managerId, managerId) &&
            const DeepCollectionEquality()
                .equals(other.managerUsername, managerUsername) &&
            const DeepCollectionEquality().equals(other.amount, amount) &&
            const DeepCollectionEquality().equals(other.comment, comment) &&
            const DeepCollectionEquality()
                .equals(other.transactionId, transactionId) &&
            const DeepCollectionEquality().equals(other.isLoan, isLoan));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(managerId),
      const DeepCollectionEquality().hash(managerUsername),
      const DeepCollectionEquality().hash(amount),
      const DeepCollectionEquality().hash(comment),
      const DeepCollectionEquality().hash(transactionId),
      const DeepCollectionEquality().hash(isLoan));

  @JsonKey(ignore: true)
  @override
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
      _$AddEditManagerRequestObjectCopyWithImpl<$Res>;
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
class _$AddEditManagerRequestObjectCopyWithImpl<$Res>
    implements $AddEditManagerRequestObjectCopyWith<$Res> {
  _$AddEditManagerRequestObjectCopyWithImpl(this._value, this._then);

  final AddEditManagerRequestObject _value;
  // ignore: unused_field
  final $Res Function(AddEditManagerRequestObject) _then;

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
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      enabled: enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as int?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword: confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      aclGroupId: aclGroupId == freezed
          ? _value.aclGroupId
          : aclGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId: parentId == freezed
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstname: firstname == freezed
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname: lastname == freezed
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      company: company == freezed
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      city: city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
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
    extends _$AddEditManagerRequestObjectCopyWithImpl<$Res>
    implements _$$_AddEditManagerRequestObjectCopyWith<$Res> {
  __$$_AddEditManagerRequestObjectCopyWithImpl(
      _$_AddEditManagerRequestObject _value,
      $Res Function(_$_AddEditManagerRequestObject) _then)
      : super(_value, (v) => _then(v as _$_AddEditManagerRequestObject));

  @override
  _$_AddEditManagerRequestObject get _value =>
      super._value as _$_AddEditManagerRequestObject;

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
      username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      enabled == freezed
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as int?,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      confirmPassword == freezed
          ? _value.confirmPassword
          : confirmPassword // ignore: cast_nullable_to_non_nullable
              as String?,
      aclGroupId == freezed
          ? _value.aclGroupId
          : aclGroupId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentId == freezed
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      firstname == freezed
          ? _value.firstname
          : firstname // ignore: cast_nullable_to_non_nullable
              as String?,
      lastname == freezed
          ? _value.lastname
          : lastname // ignore: cast_nullable_to_non_nullable
              as String?,
      company == freezed
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      city == freezed
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      notes == freezed
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
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.enabled, enabled) &&
            const DeepCollectionEquality().equals(other.password, password) &&
            const DeepCollectionEquality()
                .equals(other.confirmPassword, confirmPassword) &&
            const DeepCollectionEquality()
                .equals(other.aclGroupId, aclGroupId) &&
            const DeepCollectionEquality().equals(other.parentId, parentId) &&
            const DeepCollectionEquality().equals(other.firstname, firstname) &&
            const DeepCollectionEquality().equals(other.lastname, lastname) &&
            const DeepCollectionEquality().equals(other.company, company) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.phone, phone) &&
            const DeepCollectionEquality().equals(other.city, city) &&
            const DeepCollectionEquality().equals(other.address, address) &&
            const DeepCollectionEquality().equals(other.notes, notes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(password),
      const DeepCollectionEquality().hash(confirmPassword),
      const DeepCollectionEquality().hash(aclGroupId),
      const DeepCollectionEquality().hash(parentId),
      const DeepCollectionEquality().hash(firstname),
      const DeepCollectionEquality().hash(lastname),
      const DeepCollectionEquality().hash(company),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(phone),
      const DeepCollectionEquality().hash(city),
      const DeepCollectionEquality().hash(address),
      const DeepCollectionEquality().hash(notes));

  @JsonKey(ignore: true)
  @override
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
