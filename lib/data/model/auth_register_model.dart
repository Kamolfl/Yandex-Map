class AuthRegisterModel {
  String? message;
  String? accessToken;

  AuthRegisterModel({this.message, this.accessToken});

  AuthRegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['accessToken'] = accessToken;
    return data;
  }
}
