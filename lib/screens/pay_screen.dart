import 'package:clockee/data/data.dart';
import 'package:clockee/models/address.dart';
import 'package:clockee/models/cart.dart';
import 'package:clockee/models/order.dart';
import 'package:clockee/screens/qr_pay_screen.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

final formatter = NumberFormat('#,##0', 'vi_VN'); // định dạng kiểu Việt Nam

class PayScreen extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<PayScreen> {
  int _selectedPaymentMethod = 0;
  Address? selectedAddress;

  final paymentMethods = [
    {'icon': Icons.credit_card, 'label': 'Tài khoản ngân hàng'},
    {'icon': Icons.money, 'label': 'Thanh toán khi nhận hàng'},
  ];

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<AppData>(context).cartItems;
    final userData = Provider.of<AppData>(context).user;
    Provider.of<AppData>(context).fetchAddressList(userData!.userId);
    final listAddress = Provider.of<AppData>(context).addresses;

    selectedAddress = listAddress.isNotEmpty ? listAddress[3] : null;

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('Thanh Toán'),
        centerTitle: true,
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Địa chỉ
            DropdownButton<Address>(
              isExpanded: true,

              value: selectedAddress,
              items: listAddress.map((address) {
                return DropdownMenuItem<Address>(
                  value: address,
                  child: Text(
                    address.addressDetail.isEmpty
                        ? '${address.street}, ${address.commune}, ${address.district}, ${address.province}'
                        : '${address.addressDetail}, ${address.street}, ${address.commune}, ${address.district}, ${address.province}',
                  ),
                );
              }).toList(),
              onChanged: (Address? newValue) {
                setState(() {
                  selectedAddress = newValue;
                });
              },
            ),

            Divider(height: 32, thickness: 1),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartItem.length,
              itemBuilder: (context, index) {
                final product = cartItem[index];
                return buildProductCard(product);
              },
            ),
            SizedBox(height: 24),

            // Tổng tiền
            Column(
              children: [
                _buildPriceRow(
                  'Tạm Tính',
                  '${formatter.format(TotalPrice(cartItem)).replaceAll(',', '.')}',
                ),
                SizedBox(height: 4),
                _buildPriceRow(
                  'Phí Vận Chuyển',
                  '${formatter.format(ShippingCost(cartItem)).replaceAll(',', '.')}',
                ),
                Divider(thickness: 1),
                _buildPriceRow(
                  'Tổng',
                  '${formatter.format(TotalPrice(cartItem) + ShippingCost(cartItem)).replaceAll(',', '.')}',
                  bold: true,
                ),
              ],
            ),

            SizedBox(height: 32),

            // Phương thức thanh toán
            Text(
              'Phương Thức Thanh Toán',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            ...List.generate(paymentMethods.length, (index) {
              final method = paymentMethods[index];
              return RadioListTile(
                title: Text(method['label'] as String),
                value: index,
                groupValue: _selectedPaymentMethod,
                onChanged: (value) {
                  setState(() => _selectedPaymentMethod = value!);
                },
                secondary: Icon(
                  method['icon'] as IconData,
                  color: Colors.black,
                ),
              );
            }),

            SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,

          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                ReturnOrder? returnorder = await ApiService.createOrder(
                    userData.userId,
                    selectedAddress!.receiveid!,
                    _selectedPaymentMethod,
                  );
                Provider.of<AppData>(context).setReturnOrder(returnorder!);
                if (_selectedPaymentMethod == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRPayScreen(
                        amount: TotalPrice(cartItem) + ShippingCost(cartItem),
                      ),
                    ),
                  );
                }
                // ScaffoldMessenger.of(context)
                //   ..hideCurrentSnackBar()
                //   ..showSnackBar(SnackBar(content: Text('Đã thanh toán!')));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Mua ngay',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool bold = false}) {
    final style = TextStyle(
      fontSize: 15,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(amount, style: style),
      ],
    );
  }

  double TotalPrice(List<CartItem> products) {
    double total = 0;
    for (var product in products) {
      total += product.quantity * product.price;
    }
    return total;
  }

  Widget buildProductCard(CartItem product) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 6, 10, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(product.imageUrl, width: 60, height: 60),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: TextStyle(fontSize: 17)),
                      Row(
                        children: [
                          Text(
                            product.model,
                            style: TextStyle(color: Colors.grey),
                          ),
                          Spacer(),
                          Text(
                            'x${product.quantity}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'đ${formatter.format(product.actualPrice).replaceAll(',', '.')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            'đ${formatter.format(product.price).replaceAll(',', '.')}',
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Tổng số tiền (${product.quantity} sản phẩm): đ${formatter.format(product.price * product.quantity).replaceAll(',', '.')}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int ShippingCost(List<CartItem> products) {
    if (products.isEmpty) return 0;

    int totalQuantity = 0;
    for (var product in products) {
      totalQuantity += product.quantity;
    }

    if (totalQuantity == 0) return 0;

    int cost = 15000;

    if (totalQuantity > 1) {
      cost += (totalQuantity - 1) * 5000;
    }

    return cost;
  }
}
