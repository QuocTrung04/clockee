class User {
  final int userId;
  final String email;
  final String name;
  final String phone;
  final String password;
  final String userName;
  final int isAdmin;
  final DateTime birthday;

  User({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
    required this.userName,
    required this.isAdmin,
    required this.birthday,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['User_id'],
      email: json['Email'],
      name: json['Name'],
      phone: json['Phone'],
      password: json['Password'],
      userName: json['Username'],
      isAdmin: json['Is_admin'],
      birthday: json['Birthday'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'User_id': userId,
      'Email': email,
      'Name': name,
      'Phone': phone,
      'Password': password,
      'Username': userName,
      'Is_admin': isAdmin,
      'Birthday': birthday,
    };
  }
}
