
class getUi3Model {
  Data data;
  Support support;

  getUi3Model({required this.data, required this.support});

  factory getUi3Model.fromJson(Map<String, dynamic> json) {
    return getUi3Model(
    data : Data.fromJson(json['data']),
    support : Support.fromJson(json['support']),
    );
  }

}

class Data {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Data({required this.id, required this.email, required this.firstName, required this.lastName, required this.avatar});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
    id : json['id'] as int? ?? 0,
    email : json['email'] as String? ?? '',
    firstName : json['first_name'] as String? ?? '',
    lastName : json['last_name'] as String? ?? '',
    avatar : json['avatar'] as String? ?? '',
    );
  }

}

class Support {
  String url;
  String text;

  Support({required this.url,required this.text});

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
    url : json['url'] as String? ?? '',
    text : json['text'] as String? ?? '',
    );
  }

}
