class Address {
  final String name;
  final String phone;
  final String province;
  final String district;
  final String wards;
  final String street;
  Address({
    required this.name,
    required this.phone,
    required this.province,
    required this.wards,
    required this.district,
    required this.street,
  });
  factory Address.fromJson(Map<String, dynamic> json) => Address(
    name: json['name'],
    phone: json['phone'],
    province: json['province'],
    wards: json['wards'],
    district: json['district'],
    street: json['street'],
  );
}
