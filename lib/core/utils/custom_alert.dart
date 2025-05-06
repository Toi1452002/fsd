import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter/material.dart';
class CustomAlert{
  Future<AlertButton> error(String text, {String title = ''}) async {
    return await FlutterPlatformAlert.showAlert(
      // options: PlatformAlertOptions(
      //     windows: WindowsAlertOptions(
      //         preferMessageBox: true
      //     )
      // ),
      windowTitle: title,
      text: text,
      alertStyle: AlertButtonStyle.ok,
      iconStyle: IconStyle.error,
    );
  }

  Future<AlertButton> success(String text, {String title = 'Success'}) async {
    return await FlutterPlatformAlert.showAlert(
      options: PlatformAlertOptions(
          windows: WindowsAlertOptions(
              preferMessageBox: true
          )
      ),
      windowTitle: 'Success',
      text: text,
      alertStyle: AlertButtonStyle.ok,
      iconStyle: IconStyle.none,
    );
  }

  Future<AlertButton> warning(String text, {String title = 'Thông báo'}) async {
    return await FlutterPlatformAlert.showAlert(
      options: PlatformAlertOptions(
          windows: WindowsAlertOptions(
              preferMessageBox: true
          )
      ),
      windowTitle: title,
      text: text,
      alertStyle: AlertButtonStyle.okCancel,
      iconStyle: IconStyle.warning,
    );
  }
}



class LoadingDialog {
  static void showLoadingDialog(BuildContext context,{String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Ngăn người dùng đóng dialog bằng cách nhấn ra ngoài
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Flexible(
                    child: Text(
                      message,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}

// Ví dụ cách sử dụng:
// void someFunction(BuildContext context) async {
//   LoadingDialog.showLoadingDialog(context, 'Đang tải...');
//   await Future.delayed(Duration(seconds: 2)); // Giả lập tác vụ bất đồng bộ
//   LoadingDialog.hideLoadingDialog(context);
// }