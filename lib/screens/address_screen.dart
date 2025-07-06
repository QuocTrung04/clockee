import 'package:clockee/data/data.dart';
import 'package:clockee/models/address.dart';
import 'package:clockee/screens/add_adress_screen.dart';
import 'package:clockee/screens/edit_adress_screen.dart';
import 'package:clockee/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int? _selectedAddressId;
  @override
  void initState() {
    super.initState();
    final userId =
        Provider.of<AppData>(context, listen: false).user?.userId ?? 0;
    Provider.of<AppData>(context, listen: false).fetchAddressList(userId);
  }

  @override
  Widget build(BuildContext context) {
    final addressList = Provider.of<AppData>(context).addresses;
    if (addressList.isNotEmpty && !addressList.any((a) => a.isDefault)) {
      // Nếu không có địa chỉ nào là mặc định, set địa chỉ đầu tiên ở UI thành mặc định
      addressList[0] = addressList[0].copyWith(isDefault: true);
    }
    return SafeArea(
      child: Material(
        color: Color(0xFFF3F3F3),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: IconifyIcon(
                      icon: 'material-symbols-light:arrow-back',
                    ),
                  ),
                  SizedBox(width: 30),
                  Text(
                    'Địa Chỉ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            addressList.isEmpty
                ? Expanded(
                    child: const Center(
                      child: Text(
                        'Chưa có địa chỉ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF662D91),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'ĐỊA CHỈ KHÁC',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            Expanded(
              child: ListView.separated(
                itemCount: addressList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = addressList[index];
                  return ListTile(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditAdressScreen(address: addressList[index]),
                        ),
                      );
                      if (result == true) {
                        setState(() {});
                      }
                    },
                    title: Row(
                      children: [
                        Text(item.name),
                        SizedBox(width: 5),
                        Text(
                          '|',
                          style: TextStyle(color: Colors.grey.shade400),
                        ),
                        SizedBox(width: 5),
                        Text(
                          item.phone,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        if (item.isDefault)
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF662D91),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Mặc định',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    subtitle: item.addressDetail.isEmpty
                        ? Text(
                            '${item.street},\n${item.commune}, ${item.district}, ${item.province}',
                          )
                        : Text(
                            '${item.addressDetail}, ${item.street},\n${item.commune}, ${item.district}, ${item.province}',
                          ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAdressScreen()),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("THÊM ĐỊA CHỈ"),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  foregroundColor: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
