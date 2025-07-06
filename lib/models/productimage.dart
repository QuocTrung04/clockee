class ProductImage {
  final int imageId;
  final int productId;
  final String imageUrl;

  ProductImage({
    required this.imageId,
    required this.productId,
    required this.imageUrl,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      imageId: json['Image_id'],
      productId: json['Product_id'],
      imageUrl: json['Image_url'],
    );
  }
}