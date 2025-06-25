class Product {
  final int productId;
  final String imageUrl;
  final String name;
  final int brandId;
  final int typeId;
  final int supplierId;
  final String description;
  final int actualPrice;
  final int sellPrice;
  final int stock;
  final String faceSize;
  final String thickness;
  final String wireSize;
  final String energy;
  final String productLine;
  final String faceShape;
  final String faceColor;
  final String wireType;
  final String wireColor;
  final String shellColor;
  final String shellStyle;
  final String madeIn;
  final int isActive;
  final int visible;
  final int isDeleted;
  final int purchasecount;
  final int sex;
  final String watchModel;
  final String typeName;
  final int favorite;

  Product({
    required this.productId,
    required this.imageUrl,
    required this.name,
    required this.brandId,
    required this.typeId,
    required this.supplierId,
    required this.description,
    required this.actualPrice,
    required this.sellPrice,
    required this.stock,
    required this.faceSize,
    required this.thickness,
    required this.wireSize,
    required this.energy,
    required this.productLine,
    required this.faceShape,
    required this.faceColor,
    required this.wireType,
    required this.wireColor,
    required this.shellColor,
    required this.shellStyle,
    required this.madeIn,
    required this.isActive,
    required this.visible,
    required this.isDeleted,
    required this.purchasecount,
    required this.sex,
    required this.watchModel,
    required this.typeName,
    required this.favorite,
  });

  // JSON => Dart
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['Product_id'],
      imageUrl: json['Image_url'],
      name: json['Name'],
      brandId: json['Brand_id'],
      typeId: json['Type_id'],
      supplierId: json['Supplier_id'],
      description: json['Description'],
      actualPrice: json['Actual_price'],
      sellPrice: json['Sell_price'],
      stock: json['Stock'],
      faceSize: json['Face_size'],
      thickness: json['Thickness'],
      wireSize: json['Wire_size'],
      energy: json['Energy'],
      productLine: json['Product_line'],
      faceShape: json['Face_shape'],
      faceColor: json['Face_color'],
      wireType: json['Wire_type'],
      wireColor: json['Wire_color'],
      shellColor: json['Shell_color'],
      shellStyle: json['Shell_style'],
      madeIn: json['Made_in'],
      isActive: json['Is_active'],
      visible: json['Visible'],
      isDeleted: json['Is_deleted'],
      purchasecount: json['Purchase_count'],
      sex: json['Sex'],
      watchModel: json['Watch_model'],
      typeName: json['Type_name'],
      favorite: json['favorite'] ?? 0,
    );
  }

  // Dart => JSON
  Map<String, dynamic> toJson() {
    return {
      'Product_id': productId,
      'Name': name,
      'Brand_id': brandId,
      'Type_id': typeId,
      'Supplier_id': supplierId,
      'Description': description,
      'Actual_price': actualPrice,
      'Sell_price': sellPrice,
      'Stock': stock,
      'Face_size': faceSize,
      'Thickness': thickness,
      'Wire_size': wireSize,
      'Energy': energy,
      'Product_line': productLine,
      'Face_shape': faceShape,
      'Face_color': faceColor,
      'Wire_type': wireType,
      'Wire_color': wireColor,
      'Shell_color': shellColor,
      'Shell_style': shellStyle,
      'Made_in': madeIn,
      'Is_active': isActive,
      'Visible': visible,
      'Is_deleted': isDeleted,
      'Purchase_count': purchasecount,
      'sex': sex,
      'Watch_model': watchModel,
      'Type_name': typeName,
      'favorite': favorite,
    };
  }
}
