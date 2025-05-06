import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fsd/application/application.dart';
import 'package:fsd/core/core.dart';
import 'package:fsd/data/data.dart';

import '../../../widgets/widgets.dart';


class ThayDoiTaiKhoan extends ConsumerWidget {
  ThayDoiTaiKhoan({super.key});
  final txtUserName = TextEditingController();
  final txtMatKhauMoi = TextEditingController();
  final txtXacNhanMatKhau = TextEditingController();

  
  void onSave(WidgetRef ref, BuildContext context) async{
    if(txtUserName.text.isEmpty || txtMatKhauMoi.text.isEmpty || txtXacNhanMatKhau.text.isEmpty){
      CustomAlert().error(AppString.thieuThongTin);
      return;
    }
    if(txtMatKhauMoi.text != txtXacNhanMatKhau.text){
      CustomAlert().error('Mật khẩu không khớp');
      return;
    }
    
    
    final sqlRepository = SqlRepository(tableName: TableString.user);
    final user = ref.read(userInfoProvider);
    final result = await sqlRepository.updateRow({
      'UserName': txtUserName.text.trim(),
      'PassWord': txtXacNhanMatKhau.text.trim()
    },where: "ID = ${user?.id}");
    
    if(result==1 && context.mounted){
      Navigator.pop(context);
      CustomAlert().success('Đổi tài khoản thành công');
    }
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Thay đổi tài khoản', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
            CustomTextField(label: 'Tên đăng nhập',controller: txtUserName,),
            CustomTextField(label: 'Mật khẩu mới',controller: txtMatKhauMoi,obscureText: true,),
            CustomTextField(label: 'Xác nhận mật khẩu mới',controller: txtXacNhanMatKhau,obscureText: true,),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Hủy'),
                ),
                FilledButton(onPressed: () {
                  onSave(ref, context);
                }, child: Text('Chấp nhận')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}