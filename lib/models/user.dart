class User {
  final int userId;
  final String? email;
  final String? name;
  final String? phone;
  final String userName;
  final int? isAdmin;
  final DateTime? birthday;
  final int? sex;
  final int? isDelete;

  User({
    required this.userId,
    required this.email,
    required this.name,
    required this.phone,
    required this.userName,
    required this.isAdmin,
    required this.birthday,
    required this.sex,
    required this.isDelete,
  });

  factory User.empty() {
    return User(
      userId: 0,
      email: null,
      name: null,
      phone: null,
      userName: '',
      isAdmin: null,
      birthday: null,
      sex: null,
      isDelete: null,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: int.tryParse(json['User_id'].toString()) ?? 0,
      email: json['Email'] as String?,
      name: json['Name'] as String?,
      phone: json['Phone'] as String?,
      userName: json['Username']?.toString() ?? '',
      isAdmin: json['Isadmin'],
      birthday: json['Birthday'] != null
          ? DateTime.tryParse(json['Birthday'].toString())
          : null,
      sex: json['Sex'] != null ? int.tryParse(json['Sex'].toString()) : null,
      isDelete: json['Isdeleted'] != null
          ? int.tryParse(json['Isdeleted'].toString())
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'User_id': userId,
      'Email': email,
      'Name': name,
      'Phone': phone,
      'Username': userName,
      'IsAdmin': isAdmin,
      'Birthday': birthday?.toIso8601String(),
      'Sex': sex,
      'IsDelete': isDelete,
    };
  }

  User copyWith({
    int? isAdmin,
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
