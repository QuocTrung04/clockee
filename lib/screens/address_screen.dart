import 'package:clockee/data/data.dart';
import 'package:clockee/models/address.dart';
import 'package:clockee/screens/add_adress_screen.dart';
import 'package:clockee/screens/edit_adress_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
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
                  Text('Địa Chỉ', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'ĐỊA CHỈ KHÁC',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: address.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final item = address[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditAdressScreen(address: address[index]),
                        ),
                      );
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
                      ],
                    ),
                    subtitle: Text(
                      '${item.street},\n ${item.wards}, ${item.district}, ${item.province}',
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
