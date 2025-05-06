import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/app_router/app_router.dart';
import 'package:fsd/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'component/component.dart';

export 'component/tuychinhmadai.dart';

class CaiDatView extends ConsumerWidget {
  const CaiDatView({super.key});

  void deleteTinNhan() {
    final btn = CustomAlert().warning('Tất cả tin sẽ bị xóa');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(titleSpacing: 0, title: Text('Cài đặt')),
      body: ListView(
        // spacing: 10,
        children: [
          _buildCard('Tùy chọn', onTap: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return TuyChon();
              },
            );
          }, leading: Icon(PhosphorIcons.toggleRight())),
          _buildCard('Sao lưu', onTap: () {}, leading: Icon(PhosphorIcons.cloudArrowUp())),
          _buildCard('Khôi phục', onTap: () {}, leading: Icon(PhosphorIcons.cloudArrowDown())),
          _buildCard(
            'Đổi tài khoản',
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return ThayDoiTaiKhoan();
                },
              );
            },
            leading: Icon(PhosphorIcons.userSwitch()),
          ),
          _buildCard(
            'Tùy chỉnh mã đài',
            onTap: () {
              context.push(RouterPath.tuyChinhMaDai);
            },
            leading: Icon(PhosphorIcons.slidersHorizontal()),
          ),
          _buildCard('Xóa tin nhắn', onTap: deleteTinNhan, leading: Icon(PhosphorIcons.broom(), color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildCard(String title, {void Function()? onTap, Widget? leading}) {
    return Card(
      child: ListTile(
        leading: leading,
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
        onTap: onTap,
      ),
    );
  }
}



