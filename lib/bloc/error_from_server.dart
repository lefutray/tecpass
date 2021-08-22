class AuthError {
  AuthError({
    this.msg,
    this.param,
    this.location,
  });

  final String? msg;
  final String? param;
  final String? location;

  factory AuthError.fromJson(Map<String, dynamic> json) {
    return AuthError(
      msg: json["msg"],
      param: json["param"],
      location: json["location"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "msg": msg,
      "param": param,
      "location": location,
    };
  }
}
