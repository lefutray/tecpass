class LoginResult {
  LoginResult({
    this.errors,
  });

  final List<Error>? errors;

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      errors: json["errors"] ?? List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "errors": errors ?? List<dynamic>.from(errors!.map((x) => x.toJson())),
    };
  }
}

class Error {
  Error({
    this.msg,
    this.param,
    this.location,
  });

  final String? msg;
  final String? param;
  final String? location;

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
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
