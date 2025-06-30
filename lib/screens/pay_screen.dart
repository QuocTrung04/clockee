import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<PayScreen> {
  int _selectedPaymentMethod = 0;

  final paymentMethods = [
    {'icon': Icons.credit_card, 'label': 'Tài khoản ngân hàng'},
    {'icon': Icons.money, 'label': 'Tiền mặt'},
  ];

  @override
  Widget build(BuildContext context) {
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
            Text(
              'Địa Chỉ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Text('Nguyễn Văn A', style: TextStyle(fontSize: 15)),
                Text('\t| 0345678910', style: TextStyle(color: Colors.grey)),
              ],
            ),
            Text(
              '123 Đường ABC, Quận 1, TP. HCM',
              style: TextStyle(fontSize: 15),
            ),
            Divider(height: 32, thickness: 1),

            // Sản phẩm
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://i.ibb.co/gF74k85k/ra-as0105s30b-1730956069.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giày Thể Thao',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('Màu Be, Size 42'),
                          SizedBox(height: 4),
                          Text(
                            'đ200.000',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text('x1', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // Tổng tiền
            Column(
              children: [
                _buildPriceRow('Tạm Tính', 'đ200.000'),
                SizedBox(height: 4),
                _buildPriceRow('Phí Vận Chuyển', 'đ15.000'),
                Divider(thickness: 1),
                _buildPriceRow('Tổng', 'đ215.000', bold: true),
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

            // Nút thanh toán
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
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Đã thanh toán!')));
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
}
