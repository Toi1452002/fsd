import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fsd/core/core.dart';
import 'package:fsd/data/data.dart';
import 'package:fsd/views/khach/component/component.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../application/application.dart';
import '../../../widgets/widgets.dart';

class ThongTinKhachView extends ConsumerStatefulWidget {
  final KhachModel? khach;
  final bool isCopy;
  const ThongTinKhachView({super.key, this.khach, this.isCopy = false});

  @override
  ConsumerState createState() => _ThongTinKhachViewState();
}

class _ThongTinKhachViewState extends ConsumerState<ThongTinKhachView> {
  Set<String> _selectedMien = {'Nam'};
  int _selectedKieuTyLe = 1;
  bool tkDa = true;
  bool dauTren = false;
  bool tkAB = false;

  bool tMN = false;
  bool tMT = false;
  bool tMB = false;
  bool tcMN = false;
  bool tcMT = false;
  bool tcMB = false;

  final txtTenKhach = TextEditingController();
  final txtSDT = TextEditingController();
  final txtHoiTong = TextEditingController(text: '0');
  final txtHoi2S = TextEditingController(text: '0');
  final txtHoi3S = TextEditingController(text: '0');

  onSave(List<GiaKhachModel> giaKhach) async {
    KhachModel khach = KhachModel(
      id: widget.khach?.id,
      maKhach: txtTenKhach.text.trim(),
      sdt: txtSDT.text.trim(),
      kDauTren: dauTren,
      hoiTong: int.parse(txtHoiTong.text),
      hoi2S: int.parse(txtHoi2S.text),
      hoi3S: int.parse(txtHoi3S.text),
      thuongMN: tMN,
      themChiMN: tcMN,
      thuongMT: tMT,
      themChiMT: tcMT,
      thuongMB: tMB,
      themChiMB: tcMB,
      kieuTyLe: _selectedKieuTyLe,
      tkDa: tkDa,
      tkAB: tkAB,
    );
    if (widget.khach == null || widget.isCopy) {
      //Insert
      khach.id = null;
      final result = await ref.read(khachProvider.notifier).addKhach(khach, giaKhach);
      if (result && context.mounted) context.pop();

    } else {
      final result = await ref.read(khachProvider.notifier).updateKhach(khach,giaKhach);
      if (result && context.mounted) context.pop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.khach != null) {
      final x = widget.khach;
      _selectedKieuTyLe = x!.kieuTyLe;
      tkDa = x.tkDa;
      dauTren = x.kDauTren;
      tkAB = x.tkAB;
      tMN = x.thuongMN;
      tcMN = x.themChiMN;
      tMT = x.thuongMT;
      tcMT = x.themChiMT;
      tMB = x.thuongMB;
      tcMB = x.themChiMB;

      txtTenKhach.text = x.maKhach;
      txtSDT.text = x.sdt;
      txtHoiTong.text = x.hoiTong.toString();
      txtHoi2S.text = x.hoi2S.toString();
      txtHoi3S.text = x.hoi3S.toString();

      ref.read(khachProvider.notifier).getGiaKhach(x.kieuTyLe, x.id!, ref);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wListGiaKhach1 = ref.watch(listGiaKhach1Provider);
    final wListGiaKhach2 = ref.watch(listGiaKhach2Provider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Text('Thông tin khách'),
          actions: [
            IconButton(
              onPressed: () => onSave(_selectedKieuTyLe == 1 ? wListGiaKhach1 : wListGiaKhach2),
              icon: Icon(PhosphorIcons.floppyDisk()),
            ),
          ],
          bottom: TabBar(
            unselectedLabelColor: Colors.blue.shade200,
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [Tab(text: 'Giá'), Tab(text: 'Tùy chỉnh')],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),

          ///GIA KHACH ******************************************************************************************************
          child: Column(
            spacing: 10,
            children: [
              CustomTextField(label: 'Tên khách', controller: txtTenKhach),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('Kiểu tỷ lệ: '),
                            Expanded(
                              child: CustomDropdown(
                                value: _selectedKieuTyLe,
                                items: [
                                  CustomDropdownItem(value: 1, text: 'Kiểu 1-70/100'),
                                  CustomDropdownItem(value: 2, text: 'Kiểu 2-12.6/18'),
                                ],
                                onChanged: (val) async {
                                  final btn = await CustomAlert().warning('Có muốn thay đổi kiểu tỷ lệ');
                                  if (btn == AlertButton.okButton) {
                                    setState(() {
                                      _selectedKieuTyLe = val!;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        Gap(20),
                        SizedBox(
                          width: double.infinity,
                          child: WidgetSelectMien(selected: _selectedMien,onSelectionChanged: (val){
                            setState(() {
                              _selectedMien = val;
                            });
                          },),
                        ),
                        Expanded(
                          child: CustomDatatable(
                            columns: [
                              DataColumn2(
                                headingRowAlignment: MainAxisAlignment.center,
                                label: Text('Mã kiểu'),
                                fixedWidth: 70,
                              ),
                              DataColumn2(headingRowAlignment: MainAxisAlignment.center, label: Text('Cò')),
                              DataColumn2(headingRowAlignment: MainAxisAlignment.center, label: Text('Trúng')),
                            ],
                            rows:
                                (_selectedKieuTyLe == 1 ? wListGiaKhach1 : wListGiaKhach2).map((e) {
                                  return DataRow2(
                                    cells: [
                                      DataCell(
                                        Container(
                                          alignment: Alignment.center,
                                          color: Colors.grey.shade300,
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Text(e.maKieu, style: TextStyle(fontWeight: FontWeight.w600)),
                                        ),
                                      ),

                                      if (_selectedMien.first == 'Nam')
                                        DataCell(
                                          buildTextFieldTable(
                                            text: e.coMN.toString(),
                                            onChanged: (val) {
                                              e.coMN = double.parse(val.isEmpty ? '0' : val);
                                            },
                                          ),
                                        ),
                                      if (_selectedMien.first == 'Nam')
                                        DataCell(
                                          buildTextFieldTable(
                                            text: e.trungMN.toString(),
                                            onChanged: (val) {
                                              e.trungMN = double.parse(val.isEmpty ? '0' : val);
                                            },
                                          ),
                                        ),
                                      if (_selectedMien.first == 'Trung')
                                        DataCell(
                                          buildTextFieldTable(
                                            text: e.coMT.toString(),
                                            onChanged: (val) {
                                              e.coMT = double.parse(val.isEmpty ? '0' : val);
                                            },
                                          ),
                                        ),
                                      if (_selectedMien.first == 'Trung')
                                        DataCell(
                                          buildTextFieldTable(
                                            text: e.trungMT.toString(),
                                            onChanged: (val) {
                                              e.trungMT = double.parse(val.isEmpty ? '0' : val);
                                            },
                                          ),
                                        ),
                                      if (_selectedMien.first == 'Bắc')
                                        DataCell(
                                          buildTextFieldTable(
                                            text: e.coMB.toString(),
                                            onChanged: (val) {
                                              e.coMB = double.parse(val.isEmpty ? '0' : val);
                                            },
                                          ),
                                        ),
                                      if (_selectedMien.first == 'Bắc')
                                        DataCell(
                                          buildTextFieldTable(
                                            text: e.trungMB.toString(),
                                            onChanged: (val) {
                                              e.trungMB = double.parse(val.isEmpty ? '0' : val);
                                            },
                                          ),
                                        ),
                                    ],
                                  );
                                }).toList(),
                          ),
                        ),
                      ],
                    ),

                    ///TUY CHINH *******************************************************************************************
                    ListView(
                      children: [
                        Gap(5),
                        CustomTextField(label: 'SĐT', controller: txtSDT),
                        Gap(10),
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(child: CustomTextField(label: 'Hồi tổng', controller: txtHoiTong, isNumber: true)),
                            Expanded(child: CustomTextField(label: 'Hồi 2s', controller: txtHoi2S, isNumber: true)),
                            Expanded(child: CustomTextField(label: 'Hồi 3s', controller: txtHoi3S, isNumber: true)),
                          ],
                        ),
                        Gap(5),
                        CustomCheckbox(
                          title: 'Đá 2 đài chuyển thành đá xiên',
                          value: tkDa,
                          onChanged: (val) {
                            setState(() {
                              tkDa = val!;
                            });
                          },
                        ),
                        Divider(),
                        CustomCheckbox(
                          title: 'Thay b=đui, lo=bao',
                          value: tkAB,
                          onChanged: (val) {
                            setState(() {
                              tkAB = val!;
                            });
                          },
                        ),
                        Divider(),
                        CustomCheckbox(
                          title: 'Đầu trên',
                          value: dauTren,
                          onChanged: (val) {
                            setState(() {
                              dauTren = val!;
                            });
                          },
                        ),
                        Gap(5),

                        Text('Thưởng đá thẳng: ', style: TextStyle(fontWeight: FontWeight.w600)),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.grey),
                          ),
                          height: 200,
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomCheckbox(
                                      title: 'Miền Nam',
                                      value: tMN,
                                      onChanged: (val) {
                                        setState(() {
                                          tMN = val!;
                                          if (!val) tcMN = false;
                                        });
                                      },
                                    ),
                                    Divider(endIndent: 0, height: 0),
                                    CustomCheckbox(
                                      title: 'Miền Trung',
                                      value: tMT,
                                      onChanged: (val) {
                                        setState(() {
                                          tMT = val!;
                                          if (!val) tcMT = false;
                                        });
                                      },
                                    ),
                                    Divider(endIndent: 0, height: 0),
                                    CustomCheckbox(
                                      title: 'Miền Bắc',
                                      value: tMB,
                                      onChanged: (val) {
                                        setState(() {
                                          tMB = val!;
                                          if (!val) tcMB = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomCheckbox(
                                      title: 'Thêm chi',
                                      value: tcMN,
                                      enabled: tMN,
                                      onChanged: (val) {
                                        setState(() {
                                          tcMN = val!;
                                        });
                                      },
                                    ),
                                    Divider(endIndent: 0, height: 0),
                                    CustomCheckbox(
                                      title: 'Thêm chi',
                                      value: tcMT,
                                      enabled: tMT,
                                      onChanged: (val) {
                                        setState(() {
                                          tcMT = val!;
                                        });
                                      },
                                    ),
                                    Divider(endIndent: 0, height: 0),
                                    CustomCheckbox(
                                      title: 'Thêm chi',
                                      value: tcMB,
                                      enabled: tMB,
                                      onChanged: (val) {
                                        setState(() {
                                          tcMB = val!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
