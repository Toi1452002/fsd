import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/application/application.dart';
import 'package:fsd/core/core.dart';
import 'package:fsd/data/data.dart';
import 'package:fsd/widgets/custom_datatable.dart';
import 'package:fsd/widgets/custom_textfield.dart';
import 'package:fsd/widgets/widget_select_mien.dart';
import 'package:gap/gap.dart';
import 'package:loading_overlay/loading_overlay.dart';

class KQXSView extends ConsumerStatefulWidget {
  const KQXSView({super.key});

  @override
  ConsumerState createState() => _KQXSViewState();
}

class _KQXSViewState extends ConsumerState<KQXSView> {
  Set<String> _selectedMien = {'Nam'};
  DateTime _ngay = NGAYLAMVIEC;
  List<TableRow> _row = [];
  List<TableRow> _column = [];

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    ref.read(maDaiProvider.notifier).getMaDaiTheoThu(mien: _selectedMien.first[0], thu: _ngay.weekday - 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final wMaDai = ref.watch(maDaiProvider);

    ref.listen(kqxsProvider, (a, state) {
      _row.clear();
      _column.clear();
      if (state is KQXSLoading) {
        _isLoading = true;
      } else if (state is KQXSData) {
        _isLoading = false;
        if (state.data.isEmpty) {
          CustomAlert().warning('KQXS chưa hoàn thành');
        } else {
          final data = state.data;
          final lstDai = data.map((e) => e.maDai).toSet().toList();
          _column.add(
            TableRow(
              children: [
                Text(''),
                for (String x in lstDai)
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      wMaDai.firstWhere((e) => e.maDai == x).moTa,
                      softWrap: false,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade700),
                    ),
                  ),
              ],
            ),
          );

          final List<String> giai = data.map((e) => e.maGiai).toSet().toList();

          for (String g in giai) {
            _row.add(
              TableRow(
                children: [
                  Align(alignment: Alignment.center, child: Text(g, style: TextStyle(fontWeight: FontWeight.w600))),
                  ...lstDai.map((e) {
                    final kqSo = data.where((a) => a.maDai == e && a.maGiai == g).toList();
                    final str = kqSo.map((x) => x.kqSo).toList().join(e == 'mb' ? ' - ' : '\n');
                    if (g == 'DB') {
                      return Align(
                        alignment: Alignment.center,
                        child: Text(
                          str,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 15),
                        ),
                      );
                    }
                    return Align(
                      alignment: Alignment.center,
                      child: Text(str, style: TextStyle(fontWeight: FontWeight.w500), softWrap: true),
                    );
                  }),
                ],
              ),
            );
          }
        }
      }
      setState(() {});
    });

    return PopScope(
      canPop: !_isLoading,
      child: LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
          appBar: AppBar(titleSpacing: 0, title: Text('Kết quả xổ số')),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: CustomTextField(
                        label: 'Chọn ngày',
                        readOnly: true,
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: _ngay,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            setState(() {
                              _ngay = date;
                            });
                          }
                        },
                        controller: TextEditingController(text: CustomDateFormat().dMy(_ngay)),
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: WidgetSelectMien(
                        selected: _selectedMien,
                        onSelectionChanged: (val) {
                          setState(() {
                            _selectedMien = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      ref
                          .read(maDaiProvider.notifier)
                          .getMaDaiTheoThu(mien: _selectedMien.first[0], thu: _ngay.weekday - 1);
                      ref.read(kqxsProvider.notifier).getKQXS(mien: _selectedMien.first[0], ngay: _ngay);
                    },
                    child: Text('Xem kết quả'),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: const {0: FractionColumnWidth(.1)},
                      border: TableBorder.all(color: Colors.black, style: BorderStyle.solid, width: 1),
                      children: [..._column, ..._row],
                    ),
                  ),
                  // child: CustomDatatable(
                  //   headingRowHeight: 30,
                  //   columns: [
                  //     DataColumn2(label: Text(''), fixedWidth: 30),
                  //     // ...wMaDai.map((e) => DataColumn2(headingRowAlignment: MainAxisAlignment.center, label: Text(e.moTa))),
                  //     ..._column,
                  //   ],
                  //   rows: _row,
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
