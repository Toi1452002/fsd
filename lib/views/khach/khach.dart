import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/application/application.dart';
import 'package:fsd/core/core.dart';
import 'package:fsd/data/data.dart';
import 'package:fsd/views/khach/component/thongtinkhach.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../app_router/app_router.dart';
export 'component/thongtinkhach.dart';

class KhachView extends ConsumerWidget {
  const KhachView({super.key});

  void onDelete(WidgetRef ref, KhachModel khach) async {
    final btn = await CustomAlert().warning('Dữ liệu của khách này sẽ bị xóa', title: 'Có chắc muốn xóa');
    if (btn == AlertButton.okButton) {
      ref.read(khachProvider.notifier).deleteKhach(khach);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách khách'),
        actions: [
          IconButton(
            onPressed: () {
              context.push(RouterPath.thongTinKhach);
            },
            icon: Icon(Icons.add),
          ),
        ],
        titleSpacing: 0,
        centerTitle: false,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final wKhach = ref.watch(khachProvider);
          if (wKhach is KhachData) {
            if (wKhach.khach.isEmpty) {
              return Center(child: Text('Chưa có khách, nhấn (+) để thêm khách', style: TextStyle(color: Colors.grey)));
            } else {
              return ListView(
                children: List.generate(wKhach.khach.length, (i) {
                  var x = wKhach.khach[i];
                  return ListTile(
                    leading: Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text('${i + 1}', style: TextStyle(color: Colors.white)),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            onTap: (){
                              x = x.copyWith(maKhach: '');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinKhachView(khach: x,isCopy: true,)));
                            },
                            child: Row(spacing: 5, children: [Icon(PhosphorIcons.copy()), Text('Sao chép')]),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              onDelete(ref, x);
                            },
                            child: Row(
                              spacing: 5,
                              children: [
                                Icon(PhosphorIcons.trash(), color: Colors.red),
                                Text('Xóa', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ThongTinKhachView(khach: x)));
                    },
                    title: Text(x.maKhach),
                  );
                }),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
