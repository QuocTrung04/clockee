import 'dart:ui';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clockee/models/cart.dart';
import 'package:clockee/data/favorite_notifier.dart';
import 'package:clockee/screens/cart_item_screen.dart';
import 'package:clockee/screens/product_details_screen.dart';
import 'package:clockee/screens/search_screen.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/data.dart';
import '../models/sanpham.dart';
import '../models/user.dart';
import '../screens/banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User user = User(
    userId: 0,
    email: '',
    name: '',
    phone: '',
    userName: '',
    isAdmin: null,
    birthday: null,
    sex: null,
    isDelete: null,
  );
  final ValueNotifier<int> gioitinhNotifier = ValueNotifier<int>(1);
  List<Product> allProducts = [];
  List<CartItem> cartItems = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appData = Provider.of<AppData>(context, listen: false);
      final currentUser = appData.user;

      if (currentUser != null) {
        setState(() {
          user = currentUser;
        });
        _initCart();
        loadProducts();
      }
    });
  }

  void _initCart() async {
    final appData = Provider.of<AppData>(context, listen: false);
    final currentUser = appData.user;

    if (currentUser != null && currentUser.userId != null) {
      try {
        final fetchedItems = await ApiService.fetchCartItem(
          currentUser.userId!,
        );
        setState(() {
          cartItems = fetchedItems;
        });
      } catch (e) {}
    } else {}
  }

  void loadProducts() async {
    final appData = Provider.of<AppData>(context, listen: false);
    var userid = 0;
    if (user != null) {
      userid = user.userId!;
    }
    try {
      final products = await ApiService.fetchProducts(userid);

      setState(() {
        allProducts = products;
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    gioitinhNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: SizedBox(
              width: double.infinity,
              height: 220,
              child: FutureBuilder<List<String>>(
                future: ApiService.fetchBannerImages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Lỗi tải banner'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Image.asset(
                      'assets/images/dongho.png',
                      fit: BoxFit.cover,
                    );
                  }
                  final images = snapshot.data!;
                  return CarouselSlider(
                    items: images.map((url) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 220,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              width: 210,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color(0xFF662D91), width: 2),
                ),
              ),
              child: Text('SẢN PHẨM BÁN CHẠY', style: TextStyle(fontSize: 20)),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: SizedBox(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        //sử lý sự kiện
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/images/RolexVang.png'),
                            SizedBox(height: 20),
                            Text('Đồng Hồ Vàng'),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        //sử lý sự kiện
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Image.asset('assets/images/rolexKC.png'),
                            SizedBox(height: 20),
                            Text('Đồng Hồ Kim Cương'),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GenderStatusButtons(gioitinhNotifier: gioitinhNotifier),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ValueListenableBuilder(
                  valueListenable: favoriteChangedNotifier,
                  builder: (context, _, _) {
                    final userId = user.userId ?? 0;
                    return FutureBuilder<List<Product>>(
                      future: ApiService.fetchProducts(userId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final allProducts = snapshot.data!;
                        return ValueListenableBuilder(
                          valueListenable: gioitinhNotifier,
                          builder: (context, gioiTinh, _) {
                            final sanPhamLoc = allProducts
                                .where((sp) => sp.sex == gioiTinh)
                                .toList();
                            return GridView.builder(
                              itemCount: sanPhamLoc.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 3,
                                    mainAxisSpacing: 5,
                                    childAspectRatio: 0.51,
                                  ),
                              itemBuilder: (context, index) {
                                return SanPhamWidget(
                                  sanPham: sanPhamLoc[index],
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showSlideSearch(BuildContext context) {
  late OverlayEntry overlay;
  overlay = OverlayEntry(
    builder: (context) => SearchScreen(
      onClose: () {
        overlay.remove();
      },
    ),
  );

  Overlay.of(context).insert(overlay);
}

void showSlideCart(BuildContext context) {
  late OverlayEntry overlay;
  overlay = OverlayEntry(
    builder: (context) => CartItemScreen(
      onClose: () {
        overlay.remove();
      },
    ),
  );

  Overlay.of(context).insert(overlay);
}

class GenderStatusButtons extends StatefulWidget {
  final ValueNotifier<int> gioitinhNotifier;
  const GenderStatusButtons({super.key, required this.gioitinhNotifier});
  @override
  GenderStatusButtonsState createState() => GenderStatusButtonsState();
}

class GenderStatusButtonsState extends State<GenderStatusButtons> {
  String selected = 'nam';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Nút Đồng Hồ Nam
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 'nam';
                widget.gioitinhNotifier.value = 1;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: selected == 'nam' ? Color(0xFF662D91) : Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Đồng Hồ Nam',
                style: TextStyle(
                  color: selected == 'nam' ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Nút Đồng Hồ Nữ
          GestureDetector(
            onTap: () {
              setState(() {
                selected = 'nu';
                widget.gioitinhNotifier.value = 0;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: selected == 'nu' ? Color(0xFF662D91) : Colors.grey[300],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'Đồng Hồ Nữ',
                style: TextStyle(
                  color: selected == 'nu' ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SanPhamWidget extends StatefulWidget {
  final Product sanPham;

  const SanPhamWidget({super.key, required this.sanPham});

  @override
  State<SanPhamWidget> createState() => _SanPhamWidgetState();
}

class _SanPhamWidgetState extends State<SanPhamWidget> {
  late int favorite;
  int? userID;

  @override
  void initState() {
    super.initState();
    favorite = widget.sanPham.favorite;
    _loadUserid();
  }

  @override
  void didUpdateWidget(covariant SanPhamWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sanPham.favorite != widget.sanPham.favorite) {
      setState(() {
        favorite = widget.sanPham.favorite;
      });
    }
  }

  Future<void> _loadUserid() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      userID = prefs.getInt('userid');
    });
  }

  @override
  Widget build(BuildContext context) {
    final CartItems = Provider.of<AppData>(context).cartItems;
    final UserData = Provider.of<AppData>(context).user;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productId: widget.sanPham.productId,
            ),
          ),
        );
      },
      child: Card(
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
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.network(
                        widget.sanPham.imageUrl!,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
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

                        bool success = false;

                        if (favorite == 1) {
                          // Xóa yêu thích
                          success = await ApiService.removeFavoriteProduct(
                            userId: userId,
                            productId: widget.sanPham.productId,
                          );
                          if (!mounted) return;
                          if (success) {
                            setState(() {
                              favorite = 0;
                            });
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Đã xóa khỏi yêu thích'),
                                ),
                              );
                            favoriteChangedNotifier.value++;
                          }
                        } else {
                          // Thêm yêu thích
                          success = await ApiService.addFavoriteProduct(
                            userId: userId,
                            productId: widget.sanPham.productId,
                          );
                          if (success) {
                            setState(() {
                              favorite = 1;
                            });
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Đã thêm vào yêu thích'),
                                ),
                              );
                            favoriteChangedNotifier.value++;
                          }
                        }

                        if (!success) {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Không thể cập nhật yêu thích'),
                              ),
                            );
                          favoriteChangedNotifier.value++;
                        }
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,

                          boxShadow: favorite == 1
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
                          child: Image.asset(
                            widget.sanPham.favorite == 1
                                ? 'assets/images/heart.png'
                                : 'assets/images/heartoutline.png',
                            width: 24, // đặt kích thước phù hợp
                            height: 24,
                            color: const Color(
                              0xFF662D91,
                            ), // Nếu bạn muốn đổi màu, hoặc bỏ dòng này nếu ảnh đầy màu
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                widget.sanPham.name ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.sanPham.watchModel!,
              style: const TextStyle(
                color: Color(0xFF662D91),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '${widget.sanPham.faceSize} | ${widget.sanPham.typeName}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF662D91)),
                textAlign: TextAlign.center,
              ),
            ),
            widget.sanPham.sellPrice == null
                ? Text(
                    'Giá: ${_formatCurrency(widget.sanPham.actualPrice!)}đ',
                    style: const TextStyle(
                      color: Color(0xFF662D91),
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        'Giá: ${_formatCurrency(widget.sanPham.actualPrice!)}đ',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.grey,
                          color: Color(0xFFCFCFCF),
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Giá KM: ${_formatCurrency(widget.sanPham.sellPrice!)}đ',
                        style: const TextStyle(
                          color: Color(0xFF662D91),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
            ElevatedButton(
              onPressed: () async {
                ApiService.addToCart(
                  UserData!.userId,
                  widget.sanPham.productId,
                );
                
                final messenger = ScaffoldMessenger.of(context);

                messenger.hideCurrentSnackBar(reason: SnackBarClosedReason.remove);

                messenger.showSnackBar(
                  const SnackBar(content: Text('Đã thêm sản phẩm vào giỏ')),
                );
                favoriteChangedNotifier.value++;
                final cart = CartItem(
                  productId: widget.sanPham.productId,
                  imageUrl: widget.sanPham.imageUrl.toString(),
                  name: widget.sanPham.name.toString(),
                  actualPrice: widget.sanPham.actualPrice!,
                  price: widget.sanPham.sellPrice!,
                  model: widget.sanPham.watchModel.toString(),
                  quantity: 1,
                );
                Provider.of<AppData>(context, listen: false).addToCart(cart);
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
          ],
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
