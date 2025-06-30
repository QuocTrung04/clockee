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
  int favorite;

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
