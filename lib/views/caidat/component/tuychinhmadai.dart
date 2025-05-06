import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/application/application.dart';
import 'package:fsd/core/core.dart';
import 'package:fsd/data/data.dart';
import 'package:fsd/widgets/custom_dropdown.dart';
import 'package:fsd/widgets/custom_textfield.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TuyChinhMaDaiView extends ConsumerStatefulWidget {
  const TuyChinhMaDaiView({super.key});

  @override
  ConsumerState createState() => _TuyChinhMaDaiViewState();
}

class _TuyChinhMaDaiViewState extends ConsumerState<TuyChinhMaDaiView> {
  Set<String> _selectedMien = {'Nam'};
  int _selectedThu = 0;

  void deleteMaDai(MaDaiModel maDai) async {
    final btn = await CustomAlert().warning('Có chắc muốn xóa');
    if (btn == AlertButton.okButton) {
      ref.read(maDaiProvider.notifier).deleteMaDai(maDai);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tùy chỉnh mã đài'),
        titleSpacing: 0,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return ThongTinMaDai(thu: _selectedThu, mien: _selectedMien.first);
                },
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Text('Thứ: '),
                CustomDropdown(
                  value: _selectedThu,
                  items: [
                    CustomDropdownItem(value: 0, text: '2'),
                    CustomDropdownItem(value: 1, text: '3'),
                    CustomDropdownItem(value: 2, text: '4'),
                    CustomDropdownItem(value: 3, text: '5'),
                    CustomDropdownItem(value: 4, text: '6'),
                    CustomDropdownItem(value: 5, text: '7'),
                    CustomDropdownItem(value: 6, text: '8'),
                  ],
                  onChanged: (val) {
                    ref.read(maDaiProvider.notifier).getMaDaiTheoThu(thu: val!, mien: _selectedMien.first[0]);

                    setState(() {
                      _selectedThu = val;
                    });
                  },
                  width: 70,
                ),
                Spacer(),
                SegmentedButton(
                  showSelectedIcon: false,
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
                  ),
                  selectedIcon: null,
                  onSelectionChanged: (val) {
                    ref.read(maDaiProvider.notifier).getMaDaiTheoThu(thu: _selectedThu, mien: val.first[0]);
                    setState(() {
                      _selectedMien = val;
                    });
                  },
                  segments: [
                    ButtonSegment(value: 'Nam', label: Text('Nam')),
                    ButtonSegment(value: 'Trung', label: Text('Trung')),
                  ],
                  selected: _selectedMien,

                  // selected: _selectedMien,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade300,
              child: Consumer(
                builder: (context, ref, child) {
                  final wMaDai = ref.watch(maDaiProvider);
                  if (wMaDai.isEmpty) {
                    return Center(child: Text('Trống', style: TextStyle(color: Colors.grey)));
                  } else {
                    return ListView.builder(
                      itemCount: wMaDai.length,
                      itemBuilder: (context, i) {
                        final item = wMaDai[i];
                        return Card(
                          child: ListTile(
                            subtitle: Text(item.moTa),
                            title: Text(item.maDai),
                            leading: Text(item.tt.toString()),
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return ThongTinMaDai(thu: _selectedThu, mien: _selectedMien.first, maDaiModel: item);
                                },
                              );
                            },
                            trailing: IconButton(
                              onPressed: () {
                                deleteMaDai(item);
                              },
                              icon: Icon(PhosphorIcons.trash(), color: Colors.red),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThongTinMaDai extends ConsumerStatefulWidget {
  final int thu;
  final String mien;
  final MaDaiModel? maDaiModel;

  const ThongTinMaDai({super.key, required this.thu, required this.mien, this.maDaiModel});

  @override
  ConsumerState createState() => _ThongTinMaDaiState();
}

class _ThongTinMaDaiState extends ConsumerState<ThongTinMaDai> {
  final txtMaDai = TextEditingController();
  final txtTT = TextEditingController();
  final txtTenDai = TextEditingController();

  onSave() async {
    final maDai = MaDaiModel(
      id: widget.maDaiModel?.id,
      maDai: txtMaDai.text.trim(),
      moTa: txtTenDai.text.trim(),
      mien: widget.mien[0],
      thu: widget.thu,
      tt: int.parse(txtTT.text.isEmpty ? '0' : txtTT.text),
    );
    if (widget.maDaiModel == null) {
      final result = await ref.read(maDaiProvider.notifier).addMaDai(maDai);
      if (result && context.mounted) {
        Navigator.pop(context);
      }
    }else{
      final result = await ref.read(maDaiProvider.notifier).updateMaDai(maDai);
      if (result && context.mounted) {
        Navigator.pop(context);
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    if(widget.maDaiModel!=null){
      txtMaDai.text = widget.maDaiModel!.maDai;
      txtTT.text = widget.maDaiModel!.tt.toString();
      txtTenDai.text = widget.maDaiModel!.moTa;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Text('Thông tin mã đài', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
            Row(
              children: [
                Row(
                  spacing: 20,
                  children: [
                    Text('Thứ: ${mThu[widget.thu]}', style: TextStyle(fontWeight: FontWeight.w500)),

                    Text('Miền: ${widget.mien}', style: TextStyle(fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(child: CustomTextField(label: 'Mã đài', maxLength: 3, controller: txtMaDai)),
                Expanded(child: CustomTextField(label: 'TT', isNumber: true, maxLength: 1, controller: txtTT)),
              ],
            ),
            CustomTextField(label: 'Tên đài', controller: txtTenDai),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              spacing: 10,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Hủy'),
                ),
                FilledButton(onPressed: onSave, child: Text(widget.maDaiModel==null?  'Thêm': 'Cập nhật')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
