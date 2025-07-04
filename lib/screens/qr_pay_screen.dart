import 'package:clockee/data/data.dart';
import 'package:clockee/models/bankinfomation.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class QRPayScreen extends StatefulWidget {
  final double amount;

  QRPayScreen({super.key, required this.amount});

  @override
  State<QRPayScreen> createState() => _QRPayScreenState();
}

class _QRPayScreenState extends State<QRPayScreen> {
  final formatter = NumberFormat('#,##0', 'vi_VN');
  BankInfomation? bankinfo = null;
  String? qrCodeUrl;
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadBankInfo();
  }

  Future<void> loadBankInfo() async {
    bankinfo = await ApiService.fetchBankInfo();
  }

  @override
  Widget build(BuildContext context) {  
    final appdata = Provider.of<AppData>(context, listen: false);
    // final userData = appdata.user;
    final returnOrder = appdata.returnOrder;
    final bankId = bankinfo?.bankCode;
    final accountNo = bankinfo?.bankNumber;
    final template = 'compact';
    final amount = returnOrder?.totalPrice;
    final addInfo = Uri.encodeComponent('THANH TOAN #${returnOrder?.orderCode ?? ''}');
    final accountName = Uri.encodeComponent(bankinfo?.bankName ?? '');


    // final qrUrl = 'https://img.vietqr.io/image/$bankId-$accountNo-compact.png'
    // '?amount=$amount&addInfo=$addInfo';
    final qrUrl = 'https://img.vietqr.io/image/970416-19745371-compact.png?amount=10000&addInfo=thanhtoan';
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
          child: loading
              ? CircularProgressIndicator()
              : error != null
                  ? Text('Lỗi tải QR: $error')
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Vui lòng quét mã QR bên dưới để thanh toán:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade400, width: 2),
                          ),
                          child: Center(
                            child: qrUrl.isNotEmpty
                                ? Image.network(
                                    qrUrl,
                                    width: 180,
                                    height: 180,
                                    fit: BoxFit.contain,
                                  )
                                : const Text('Không có mã QR'),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Số tiền cần thanh toán:',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${formatter.format(widget.amount).replaceAll(',', '.')} đ',
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
