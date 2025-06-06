import 'package:flutter/material.dart';
import 'package:iconify_design/iconify_design.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback onClose;

  const SearchScreen({super.key, required this.onClose});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controler;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controler = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controler, curve: Curves.easeInOut));
    _controler.forward();
  }

  void _closeSlideSearch() async {
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF662D91)),
                    ),
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: _closeSlideSearch,
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: IconifyIcon(
                          icon: 'material-symbols-light:close-rounded',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'TÌM KIẾM GẦN ĐÂY',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 70),
                Text(
                  'TÌM KIẾM PHỔ BIẾN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
