class Address {
  final int? receiveid;
  final int? userId;
  final String name;
  final String phone;
  final String province;
  final String district;
  final String commune;
  final String street;
  final String addressDetail;
  final bool isDefault;
  Address({
    required this.receiveid,
    required this.userId,
    required this.name,
    required this.phone,
    required this.province,
    required this.commune,
    required this.district,
    required this.street,
    required this.addressDetail,
    this.isDefault = false,
  });
  factory Address.fromJson(Map<String, dynamic> json) => Address(
    receiveid: json['Receive_id'],
    userId: json['User_id'],
    name: json['Receive_name'] ?? '',
    phone: json['Receive_phone'] ?? '',
    province: json['Province'] ?? '',
    district: json['District'] ?? '',
    commune: json['Commune'] ?? '',
    street: json['Street'] ?? '',
    addressDetail: json['Address_detail'] ?? '',
    isDefault: (json['Is_default'] ?? 0) == 1,
  );
  Map<String, dynamic> toJson() => {
    "User_id": userId,
    "Receive_name": name,
    "Receive_phone": phone,
    "Province": province,
    "District": district,
    "Commune": commune,
    "Address_detail": addressDetail,
    "Street": street,
    "Is_default": isDefault ? 1 : 0,
  };
  Address copyWith({
    int? receiveid,
    int? userId,
    String? name,
    String? phone,
    String? province,
    String? district,
    String? commune,
    String? street,
    String? addressDetail,
    bool? isDefault,
  }) {
    return Address(
      receiveid: receiveid ?? this.receiveid,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      province: province ?? this.province,
      district: district ?? this.district,
      commune: commune ?? this.commune,
      street: street ?? this.street,
      addressDetail: addressDetail ?? this.addressDetail,
      isDefault: isDefault ?? this.isDefault,
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address && other.receiveid == receiveid;
  }

  @override
  int get hashCode => receiveid.hashCode;
}
