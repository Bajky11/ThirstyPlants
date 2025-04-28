
class Account {
  final int id;
  final String email;
  final String? token;

  Account({
    required this.id,
    required this.email,
    required this.token,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'token': token,
      };
}
