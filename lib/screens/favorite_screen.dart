import 'package:clockee/data/favorite_notifier.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:clockee/models/sanpham.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('userid');
    if (mounted) {
      setState(() {
        userId = id;
      });
    }
  }

  Future<List<Product>> fetchFavoriteProducts() async {
    if (userId == null) return [];
    final list = await ApiService.fetchFavoriteProducts(userId!);
    print('Danh sách nhận được: ${list.map((e) => e.productId).toList()}');
    return list;
  }

  @override
  Widget build(BuildContext context) {
    // Chưa lấy được userId thì show loading
    if (userId == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ValueListenableBuilder(
      valueListenable: favoriteChangedNotifier,
      builder: (context, value, child) {
        return FutureBuilder<List<Product>>(
          future: fetchFavoriteProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Lỗi: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Không có sản phẩm yêu thích',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF662D91),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return SanPhamWidget(
                  sanPham:
                      snapshot.data![index], // <-- LUÔN lấy từ snapshot.data!
                  userId: userId!,
                );
              },
            );
          },
        );
      },
    );
  }
}

class SanPhamWidget extends StatefulWidget {
  final Product sanPham;
  final int userId;

  const SanPhamWidget({super.key, required this.sanPham, required this.userId});

  @override
  State<SanPhamWidget> createState() => _SanPhamWidgetState();
}

class _SanPhamWidgetState extends State<SanPhamWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    widget.sanPham.imageUrl!,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getInt('userid');
                      if (!mounted) return;
                      if (userId == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Vui lòng đăng nhập để yêu thích'),
                          ),
                        );
                        return;
                      }

                      final success = await ApiService.removeFavoriteProduct(
                        userId: userId,
                        productId: widget.sanPham.productId,
                      );
                      if (!mounted) return;
                      if (success) {
                        setState(() {
                          widget.sanPham.favorite = 0;
                        });
                        favoriteChangedNotifier.value++;
                        print(
                          'notifier hashCode: ${favoriteChangedNotifier.hashCode}',
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã xóa khỏi yêu thích'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Không thể xóa khỏi yêu thích'),
                          ),
                        );
                      }
                    },

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.shade100,
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
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
                          icon: 'iconoir:heart-solid',
                          color: const Color(0xFF662D91),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.sanPham.name!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Text(
            widget.sanPham.watchModel!,
            style: const TextStyle(
              color: Color(0xFF662D91),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${widget.sanPham.faceSize} | ${widget.sanPham.typeName}',
            style: const TextStyle(fontSize: 12, color: Color(0xFF662D91)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Giá ${_formatCurrency(widget.sanPham.sellPrice ?? 0)}đ',
            style: const TextStyle(
              color: Color(0xFF662D91),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                // TODO: xử lý thêm vào giỏ
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF662D91),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Thêm Vào Giỏ'),
            ),
          ),
        ],
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
