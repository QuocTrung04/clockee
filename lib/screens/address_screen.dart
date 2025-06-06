import 'package:clockee/data/data.dart';
import 'package:clockee/models/address.dart';
import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';

class AddressScreen extends StatefulWidget {
  final VoidCallback onClose;
  const AddressScreen({super.key, required this.onClose});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controler;
  late Animation<Offset> _slideAnimation;
  late final List<Address> addressItem;

  @override
  void initState() {
    super.initState();
    _controler = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controler, curve: Curves.easeInOut));
    _controler.forward();
    addressItem = address;
  }

  void closeSlide() async {
    await _controler.reverse();
    widget.onClose();
  }

  @override
  void dispose() {
    _controler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Color(0xFFF3F3F3),
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: closeSlide,
                      icon: IconifyIcon(
                        icon: 'material-symbols-light:arrow-back',
                      ),
                    ),
                    SizedBox(width: 30),
                    Text('Địa chỉ', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(25),
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
                        print('day la dia chi');
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
                  onPressed: () {},
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
      ),
    );
  }
}
