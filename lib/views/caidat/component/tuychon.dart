import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/core/appstring/appstring.dart';
import 'package:fsd/data/data.dart';
import 'package:fsd/widgets/custom_textfield.dart';

final kXCProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
final auProvider = StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

final getTuyChonProvider = FutureProvider.autoDispose<void>((ref) async {
  final sqlRepository = SqlRepository(tableName: TableString.tuyChon);
  final data = await sqlRepository.getData(where: "Ma IN ('kxc','au')");
  ref.read(kXCProvider.notifier).state = data.firstWhere((e) => e['Ma'] == 'kxc')['GiaTri'] == 1;
  ref.read(auProvider.notifier).state.text = data.firstWhere((e) => e['Ma'] == 'au')['GiaTri'].toString();
});

class TuyChon extends ConsumerStatefulWidget {
  const TuyChon({super.key});

  @override
  TuyChonState createState() => TuyChonState();
}

class TuyChonState extends ConsumerState<TuyChon> {
  @override
  void initState() {
    // TODO: implement initState
    ref.read(getTuyChonProvider.future);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Tùy chọn', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
            ListTile(
              title: Text('Lấy 3 con'),
              subtitle: Text('1234b1.b1.xc1.dd1=1234b1.234b1.234.xc1.34dd1'),
              trailing: Checkbox(
                value: ref.watch(kXCProvider),
                onChanged: (val) {
                  ref.read(kXCProvider.notifier).state = val!;
                },
              ),
            ),
            ListTile(
              title: Text('An ủi'),
              subtitle: Text('vd: đánh 15 nếu ra 14 hoặc 16 được an ủi'),
              trailing: SizedBox(
                width: 50,
                child: CustomTextField(maxLength: 2, isNumber: true, controller: ref.watch(auProvider)),
              ),
            ),
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
                FilledButton(
                  onPressed: () async {
                    final sqlRepository = SqlRepository(tableName: TableString.tuyChon);
                    await Future.wait([
                      sqlRepository.updateRow({'GiaTri': ref.read(kXCProvider) ? 1 : 0}, where: "Ma = 'kxc'"),
                      sqlRepository.updateRow({
                        'GiaTri': int.parse(ref.read(auProvider).text.isEmpty ? '0' : ref.read(auProvider).text),
                      }, where: "Ma = 'au'")
                    ]);
                    Navigator.pop(context);
                  },
                  child: Text('Chấp nhận'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
