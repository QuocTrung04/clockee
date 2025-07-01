import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vietqr_flutter/vietqr_flutter.dart';



class QRPayScreen extends StatelessWidget {
  final double amount;

  QRPayScreen({super.key, required this.amount});

  final formatter = NumberFormat('#,##0', 'vi_VN');

  @override
  Widget build(BuildContext context) {
    final bankInfo = ApiService.fetchBankInfo();
    final String dataToEncode;
    String qrCode = VietQRGenerator.generate(
    accountNumber: '19745371',
    bankCode: 'ACB',
  );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            'Thanh toán bằng QR',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 1,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Vui lòng quét mã QR bên dưới để thanh toán:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),

              /// QR Code hiển thị ở đây
              Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade400, width: 2),
                ),
                child: Center(
                  child: generatorQR(
                    vietQr: qrCode,
                    image: const AssetImage('assets/images/bank.png'),
                    sizeQr: 300,
                    sizeEmbeddingImage: 50
                  )
                ),
              ),

              const SizedBox(height: 30),

              /// Thông tin số tiền
              const Text(
                'Số tiền cần thanh toán:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '${formatter.format(amount).replaceAll(',', '.')} đ',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),

        /// Nút xác nhận
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.check_circle_outline, color: Colors.white),
            label: const Text(
              'Xác nhận đã thanh toán',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Xác nhận thanh toán thành công!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context, true);
            },
          ),
        ),
      ),
    );
  }
}
