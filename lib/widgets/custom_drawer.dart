import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/app_router/app_router.dart';
import 'package:fsd/application/application.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Colors.blue.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 0,
        children: [
          Container(
            color: Colors.blue.shade200,
            padding: EdgeInsets.all(10),
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Mã HĐ: 123', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                Text(
                  'Ngày HH: 31/12/2025',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                ),
                // SizedBox(height: 25),
                Text('Phiên bản: 0.0.15', style: TextStyle(color: Colors.blue.shade700)),
              ],
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: Colors.white,
              child: Material(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: Text('Danh sách khách'),
                      leading: Icon(PhosphorIcons.addressBook()),
                      onTap: () {
                        context.push(RouterPath.khach);
                      },
                    ),
                    ListTile(
                      title: Text('Quản lý tin'),
                      leading: Icon(PhosphorIcons.chatCenteredText()),
                      trailing: Text('1', style: TextStyle(color: Colors.white, backgroundColor: Colors.red)),
                      onTap: () {},
                    ),
                    ListTile(title: Text('Báo cáo chi tiết'), leading: Icon(PhosphorIcons.gridNine()), onTap: () {}),
                    ListTile(title: Text('Báo cáo tổng tiền'), leading: Icon(PhosphorIcons.gridFour()), onTap: () {}),
                    ListTile(title: Text('Kết quả xổ số'), leading: Icon(PhosphorIcons.cableCar()), onTap: () {}),
                    ListTile(title: Text('Từ khóa'), leading: Icon(PhosphorIcons.arrowsClockwise()), onTap: () {}),
                    ListTile(title: Text('Cài đặt'), leading: Icon(PhosphorIcons.gear()), onTap: () {
                      context.push(RouterPath.caiDat);
                    }),
                    ListTile(
                      title: Text('Đăng xuất'),
                      leading: Icon(PhosphorIcons.signOut()),
                      onTap: () {
                        ref.read(userInfoProvider.notifier).state = null;
                        context.go(RouterPath.login);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
