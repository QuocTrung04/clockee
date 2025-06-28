// class Product {
//   final int productId;
//   final String? imageUrl;
//   final String? name;
//   final int? brandId;
//   final int? typeId;
//   final int? supplierId;
//   final String? description;
//   final int? actualPrice;
//   final int? sellPrice;
//   final int? stock;
//   final String? faceSize;
//   final String? thickness;
//   final String? wireSize;
//   final String? energy;
//   final String? productLine;
//   final String? faceShape;
//   final String? faceColor;
//   final String? wireType;
//   final String? wireColor;
//   final String? shellColor;
//   final String? shellStyle;
//   final String? madeIn;
//   final int? isActive;
//   final int? visible;
//   final int? isDeleted;
//   final int? purchasecount;
//   final int? sex;
//   final String watchModel;
//   final String? typeName;
//   int favorite;

//   Product({
//     required this.productId,
//     required this.imageUrl,
//     required this.name,
//     this.brandId,
//     this.typeId,
//     this.supplierId,
//     this.description,
//     this.actualPrice,
//     this.sellPrice,
//     this.stock,
//     this.faceSize,
//     this.thickness,
//     this.wireSize,
//     this.energy,
//     this.productLine,
//     this.faceShape,
//     this.faceColor,
//     this.wireType,
//     this.wireColor,
//     this.shellColor,
//     this.shellStyle,
//     this.madeIn,
//     this.isActive,
//     this.visible,
//     this.isDeleted,
//     this.purchasecount,
//     this.sex,
//     required this.watchModel,
//     this.typeName,
//     required this.favorite,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       productId: json['Product_id'],
//       imageUrl: json['Image_url'],
//       name: json['Name'],
//       brandId: json['Brand_id'],
//       typeId: json['Type_id'],
//       supplierId: json['Supplier_id'],
//       description: json['Description'],
//       actualPrice: json['Actual_price'],
//       sellPrice: json['Sell_price'],
//       stock: json['Stock'],
//       faceSize: json['Face_size'],
//       thickness: json['Thickness'],
//       wireSize: json['Wire_size'],
//       energy: json['Energy'],
//       productLine: json['Product_line'],
//       faceShape: json['Face_shape'],
//       faceColor: json['Face_color'],
//       wireType: json['Wire_type'],
//       wireColor: json['Wire_color'],
//       shellColor: json['Shell_color'],
//       shellStyle: json['Shell_style'],
//       madeIn: json['Made_in'],
//       isActive: json['Is_active'],
//       visible: json['Visible'],
//       isDeleted: json['Is_deleted'],
//       purchasecount: json['Purchase_count'],
//       sex: json['Sex'],
//       watchModel: json['Watch_model'],
//       typeName: json['Type_name'],
//       favorite: json['favorite'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'Product_id': productId,
//       'Image_url': imageUrl,
//       'Name': name,
//       'Brand_id': brandId,
//       'Type_id': typeId,
//       'Supplier_id': supplierId,
//       'Description': description,
//       'Actual_price': actualPrice,
//       'Sell_price': sellPrice,
//       'Stock': stock,
//       'Face_size': faceSize,
//       'Thickness': thickness,
//       'Wire_size': wireSize,
//       'Energy': energy,
//       'Product_line': productLine,
//       'Face_shape': faceShape,
//       'Face_color': faceColor,
//       'Wire_type': wireType,
//       'Wire_color': wireColor,
//       'Shell_color': shellColor,
//       'Shell_style': shellStyle,
//       'Made_in': madeIn,
//       'Is_active': isActive,
//       'Visible': visible,
//       'Is_deleted': isDeleted,
//       'Purchase_count': purchasecount,
//       'Sex': sex,
//       'Watch_model': watchModel,
//       'Type_name': typeName,
//       'favorite': favorite,
//     };
//   }

//   Product copyWith({int? favorite}) {
//     return Product(
//       productId: productId,
//       imageUrl: imageUrl,
//       name: name,
//       brandId: brandId,
//       typeId: typeId,
//       supplierId: supplierId,
//       description: description,
//       actualPrice: actualPrice,
//       sellPrice: sellPrice,
//       stock: stock,
//       faceSize: faceSize,
//       thickness: thickness,
//       wireSize: wireSize,
//       energy: energy,
//       productLine: productLine,
//       faceShape: faceShape,
//       faceColor: faceColor,
//       wireType: wireType,
//       wireColor: wireColor,
//       shellColor: shellColor,
//       shellStyle: shellStyle,
//       madeIn: madeIn,
//       isActive: isActive,
//       visible: visible,
//       isDeleted: isDeleted,
//       purchasecount: purchasecount,
//       sex: sex,
//       watchModel: watchModel,
//       typeName: typeName,
//       favorite: favorite ?? this.favorite,
//     );
//   }
// }

class Product {
  final int productId;
  final String? name; // <-- tên trường trong code là name
  final String? brandName;
  final String? typeName;
  final String? supplierName;
  final String? description;
  final int? actualPrice;
  final int? sellPrice;
  final int? stock;
  final String? faceSize;
  final String? thickness;
  final String? wireSize;
  final String? energy;
  final String? productLine;
  final String? faceShape;
  final String? faceColor;
  final String? wireType;
  final String? wireColor;
  final String? shellColor;
  final String? shellStyle;
  final String? madeIn;
  final String? imageUrl;
  final int? purchaseCount;
  final int? sex;
  final String? watchModel;
  final int favorite;

  Product({
    required this.productId,
    required this.name,
    this.brandName,
    this.typeName,
    this.supplierName,
    this.description,
    this.actualPrice,
    this.sellPrice,
    this.stock,
    this.faceSize,
    this.thickness,
    this.wireSize,
    this.energy,
    this.productLine,
    this.faceShape,
    this.faceColor,
    this.wireType,
    this.wireColor,
    this.shellColor,
    this.shellStyle,
    this.madeIn,
    this.imageUrl,
    this.purchaseCount,
    this.sex,
    this.watchModel,
    required this.favorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['Product_id'],
      name: json['Name'], // <-- LẤY TỪ ProductName
      brandName: json['BrandName'],
      typeName: json['Type_name'],
      supplierName: json['SupplierName'],
      description: json['Description'],
      actualPrice: json['Actual_price'],
      sellPrice: json['Sell_price'],
      stock: json['stock'],
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
      imageUrl: json['Image_url'],
      purchaseCount: json['Purchase_count'],
      sex: json['Sex'],
      watchModel: json['Watch_model'],
      favorite: json['favorite'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Product_id': productId,
      'ProductName': name, // <-- GHI LẠI LÀ ProductName
      'BrandName': brandName,
      'Type_name': typeName,
      'SupplierName': supplierName,
      'Description': description,
      'Actual_price': actualPrice,
      'Sell_price': sellPrice,
      'stock': stock,
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
      'Image_url': imageUrl,
      'Purchase_count': purchaseCount,
      'Sex': sex,
      'Watch_model': watchModel,
      'favorite': favorite,
    };
  }
}
