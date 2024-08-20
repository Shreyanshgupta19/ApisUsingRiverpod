
class getUi2Model {
  int page;
  int perPage;
  int total;
  int totalPages;
  List<Data> data;
  Support support;

  getUi2Model({required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
    required this.support});

  factory getUi2Model.fromJson(Map<String, dynamic> json) {
    var list1 = json['data'] as List;
    List<Data> dataList = list1.map((i) => Data.fromJson(i)).toList();

    return getUi2Model(
      page: json['page'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 0,
      data: dataList,
      support: Support.fromJson(json['support']),
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
    text : json['text'] as String? ?? ''
    );
  }
}
