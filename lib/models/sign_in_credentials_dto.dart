/// email : "string"
/// password : "string"

class SignInCredentialsDto {
  SignInCredentialsDto({
    String? email,
    String? password,
  }) {
    _email = email;
    _password = password;
  }

  SignInCredentialsDto.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
  }

  String? _email;
  String? _password;

  SignInCredentialsDto copyWith({
    String? email,
    String? password,
  }) =>
      SignInCredentialsDto(
        email: email ?? _email,
        password: password ?? _password,
      );

  String? get email => _email;

  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    return map;
  }
}
