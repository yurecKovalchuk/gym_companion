class SignInResponse {
  SignInResponse({
    String? token,
    User? user,
  }) {
    _token = token;
    _user = user;
  }

  SignInResponse.fromJson(dynamic json) {
    _token = json['token'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? _token;
  User? _user;

  SignInResponse copyWith({
    String? token,
    User? user,
  }) =>
      SignInResponse(
        token: token ?? _token,
        user: user ?? _user,
      );

  String? get token => _token;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
    String? uid,
    String? email,
    String? displayName,
  }) {
    _uid = uid;
    _email = email;
    _displayName = displayName;
  }

  User.fromJson(dynamic json) {
    _uid = json['uid'];
    _email = json['email'];
    _displayName = json['displayName'];
  }

  String? _uid;
  String? _email;
  String? _displayName;

  User copyWith({
    String? uid,
    String? email,
    String? displayName,
  }) =>
      User(
        uid: uid ?? _uid,
        email: email ?? _email,
        displayName: displayName ?? _displayName,
      );

  String? get uid => _uid;

  String? get email => _email;

  String? get displayName => _displayName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uid'] = _uid;
    map['email'] = _email;
    map['displayName'] = _displayName;
    return map;
  }
}
