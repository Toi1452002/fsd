import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/app_router/app_router.dart';
import 'package:fsd/application/application.dart';
import 'package:fsd/core/core.dart';
import 'package:fsd/widgets/custom_textfield.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerWidget {
  LoginView({super.key});

  final txtUserName = TextEditingController();
  final txtPassWord = TextEditingController();
  final txtNgayLamViec = TextEditingController(text: CustomDateFormat().dMy(DateTime.now()));

  void login(WidgetRef ref, BuildContext context) async {
    if (txtUserName.text.isNotEmpty && txtPassWord.text.isNotEmpty) {
      final result = await ref.read(userProvider.notifier).loginUser(txtUserName.text, txtPassWord.text, ref);
      if (!result) {
        CustomAlert().error('Đăng nhập thất bại!');
      } else {
         if(context.mounted){
           showDialog(
             context: context,
             barrierDismissible: false,
             builder: (context) {
               return Dialog(
                 child: Padding(
                   padding: const EdgeInsets.all(10),
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Text('Chọn ngày làm việc', style: TextStyle(fontWeight: FontWeight.bold)),
                       CustomTextField(
                         readOnly: true,
                         textAlign: TextAlign.center,
                         controller: txtNgayLamViec,
                         onTap: ()  async {
                           final date = await showDatePicker(
                             context: context,
                             firstDate: DateTime(2000),
                             lastDate: DateTime.now(),
                             initialDate: CustomDateFormat().toDate(txtNgayLamViec.text),
                           );
                           if (date != null) {
                             NGAYLAMVIEC = date;
                             txtNgayLamViec.text = CustomDateFormat().dMy(date);
                           }
                         },
                       ),
                       Gap(10),
                       FilledButton(
                         onPressed: () {
                           Navigator.pop(context);
                           context.go(RouterPath.home);
                         },
                         child: Text('Chấp nhận'),
                       ),
                     ],
                   ),
                 ),
               );
             },
           );
         }
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login app', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                CustomTextField(label: 'Tài khoản', controller: txtUserName),
                CustomTextField(label: 'Mật khẩu', controller: txtPassWord, obscureText: true),
              ],
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: FilledButton(onPressed: () async{
               // final data =  await getKQXSHomNay(mien: 'N',ngay: DateTime.now().copyWith(day: 22));
               // final data1 =  await getKQXSMinhNgoc(mien: 'N',ngay: DateTime.now().copyWith(day: 22));
               // print('Data: $data lan1');
               // print('Data: $data1 lan2');
                login(ref, context);
              }, child: Text('Đăng nhập')),
            ),
          ],
        ),
      ),
    );
  }
}
