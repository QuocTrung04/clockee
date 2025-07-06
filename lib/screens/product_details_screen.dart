import 'package:clockee/data/favorite_notifier.dart';
import 'package:clockee/models/sanpham.dart';
import 'package:clockee/screens/pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:clockee/services/api_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  final int userId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    required this.userId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = ApiService.fetchProductDetail(
      widget.productId,
      widget.userId,
    );
  }

  void _reloadProduct() {
    setState(() {
      _productFuture = ApiService.fetchProductDetail(
        widget.productId,
        widget.userId,
      );
    });
  }

  Future<void> _toggleFavorite(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userid');
    if (!mounted) return;

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đăng nhập để yêu thích')),
      );
      return;
    }

    bool success = false;

    if (product.favorite == 1) {
      // Xóa yêu thích
      success = await ApiService.removeFavoriteProduct(
        userId: userId,
        productId: product.productId,
      );
      if (success) {
        setState(() {
          product.favorite = 0;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã xóa khỏi yêu thích')));
        favoriteChangedNotifier.value++;
      }
    } else {
      // Thêm yêu thích
      success = await ApiService.addFavoriteProduct(
        userId: userId,
        productId: product.productId,
      );
      if (success) {
        setState(() {
          product.favorite = 1;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã thêm vào yêu thích')));
        favoriteChangedNotifier.value++;
      }
    }

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không thể cập nhật yêu thích')),
      );
      favoriteChangedNotifier.value++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<Product>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Không tìm thấy sản phẩm'));
            }

            final product = snapshot.data!;
            final specs = buildSpecs(product);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Ảnh sản phẩm
                      Image.network(
                        product.imageUrl!,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                      // Nút quay lại
                      Positioned(
                        top: 16,
                        left: 16,
                        child: CircleAvatar(
                          backgroundColor: Colors.white70,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      // Nút yêu thích
                      Positioned(
                        top: 16,
                        right: 60,
                        child: GestureDetector(
                          onTap: () => _toggleFavorite(product),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: product.favorite == 1
                                  ? [
                                      BoxShadow(
                                        color: Colors.purple.shade100,
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: IconifyIcon(
                                key: ValueKey(product.favorite),
                                icon: product.favorite == 1
                                    ? 'iconoir:heart-solid'
                                    : 'iconoir:heart',
                                color: const Color(0xFF662D91),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Nút giỏ hàng
                      Positioned(
                        top: 16,
                        right: 16,
                        child: CircleAvatar(
                          backgroundColor: Colors.white70,
                          child: IconButton(
                            icon: IconifyIcon(
                              icon: 'solar:cart-bold',
                              color: Color(0xFF662D91),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Nội dung chi tiết
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            product.name ?? "fd",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        product.sellPrice == null
                            ? Text(
                                '${_formatCurrency(product.actualPrice!)}₫',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    '${_formatCurrency(product.actualPrice!)}đ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey,
                                      color: Color(0xFFCFCFCF),
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '${_formatCurrency(product.sellPrice!)}đ',
                                    style: const TextStyle(
                                      color: Color(0xFF662D91),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(height: 8),

                        const SizedBox(height: 16),
                        const Divider(),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xFF662D91),
                                    width: 2,
                                  ),
                                ),
                              ),
                              child: Text(
                                'Thông số kĩ thuật',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        const Divider(),
                        InfoTable(rows: specs),
                        SizedBox(height: 10),
                        const Divider(),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF662D91),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Text(
                            'MÔ TẢ SẢN PHẨM',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        if (product.description != null &&
                            product.description!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              product.description!,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Thêm vào giỏ',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  String _formatCurrency(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
  }
}

// =========== TABLE VÀ BUILD SPECS ===========
List<List<String>> buildSpecs(Product product) {
  String gioiTinhText(int? sex) {
    if (sex == 1) return 'Nam';
    if (sex == 0) return 'Nữ';
    return '';
  }

  return [
    ['Thương Hiệu', product.brandName ?? ''],
    ['Xuất Xứ', product.madeIn ?? ''],
    ['Giới Tính', gioiTinhText(product.sex)],
    ['Loại Đồng Hồ', product.typeName ?? ''],
    ['Kiểu Dáng Mặt', product.faceShape ?? ''],
    ['Năng Lượng', product.energy ?? ''],
    ['Dòng Sản Phẩm', product.productLine ?? ''],
    ['Màu Mặt', product.faceColor ?? ''],
    ['Loại Dây', product.wireType ?? ''],
    ['Màu dây', product.wireColor ?? ''],
    ['Màu vỏ', product.shellColor ?? ''],
    ['Loại Vỏ', product.shellStyle ?? ''],
    ['Kích Thước Mặt', product.faceSize ?? ''],
    ['Kích Thước Dây', product.wireSize ?? ''],
    ['Độ Dày', product.thickness ?? ''],
    ['Xuất xứ', product.madeIn ?? ''],
  ].where((row) => row[1].isNotEmpty).toList();
}

class InfoTable extends StatelessWidget {
  final List<List<String>> rows;
  const InfoTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
      border: TableBorder.symmetric(
        inside: BorderSide(color: Colors.grey.shade300, width: 0.5),
      ),
      children: [
        for (int i = 0; i < rows.length; i++)
          TableRow(
            decoration: BoxDecoration(
              color: i.isEven ? Colors.grey.shade100 : Colors.white,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 6,
                ),
                child: Text(
                  rows[i][0],
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 6,
                ),
                child: Text(
                  rows[i][1],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
