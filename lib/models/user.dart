// class User {
//   final int userId;
//   final String email;
//   final String name;
//   final String phone;
//   final String password;
//   final String userName;
//   final int isAdmin;
//   final DateTime birthday;

//   User({
//     required this.userId,
//     required this.email,
//     required this.name,
//     required this.phone,
//     required this.password,
//     required this.userName,
//     required this.isAdmin,
//     required this.birthday,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       userId: json['User_id'],
//       email: json['Email'],
//       name: json['Name'],
//       phone: json['Phone'],
//       password: json['Password'],
//       userName: json['Username'],
//       isAdmin: json['Is_admin'],
//       birthday: json['Birthday'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'User_id': userId,
//       'Email': email,
//       'Name': name,
//       'Phone': phone,
//       'Password': password,
//       'Username': userName,
//       'Is_admin': isAdmin,
//       'Birthday': birthday,
//     };
//   }
// }

class User {
  final int userId;
  final String? email;
  final String? name;
  final String? phone;
  final String password;
  final String userName;
  final String? isAdmin;
  final DateTime? birthday;
  final int? sex;
  final int? isDelete;

  User({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
    required this.userName,
    required this.isAdmin,
    required this.birthday,
    required this.sex,
    required this.isDelete,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['User_id'] as int,
      email: json['Email'] as String?,
      name: json['Name'] as String?,
      phone: json['Phone'] as String?,
      password: json['Password'] as String,
      userName: json['Username'] as String,
      isAdmin: json['Is_admin'] as String,
      birthday: json['Birthday'] != null
          ? DateTime.tryParse(json['Birthday'].toString())
          : null,
      sex: json['Sex'] != null ? int.tryParse(json['Sex'].toString()) : null,
      isDelete: json['Is_deleted'],
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
      'Birthday': birthday!.toIso8601String(),
      'Sex': sex,
      'Is_deleted': isDelete,
    };
  }

  User copyWith({
    String? isAdmin,
    String? password,
    String? name,
    int? id,
    String? userName,
    String? email,
    String? phone,
    DateTime? birthday,
    int? sex,
    int? isDelete,
  }) {
    return User(
      isAdmin: isAdmin ?? this.isAdmin,
      name: name ?? this.name,
      password: password ?? this.password,
      userId: id ?? userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      sex: sex ?? this.sex,
      isDelete: isDelete ?? this.isDelete,
    );
  }
}
