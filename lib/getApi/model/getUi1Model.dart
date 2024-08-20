
class getUi1Model {
  int postId;
  int id;
  String name;
  String email;
  String body;

  getUi1Model({required this.postId, required this.id, required this.name, required this.email, required this.body});

  factory getUi1Model.fromJson(Map<String, dynamic> json) {
    return getUi1Model(
      postId: json['postId'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

}
