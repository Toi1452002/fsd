import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/core/core.dart';
import 'package:fsd/data/data.dart';

class KQXSNotifier extends StateNotifier<KQXSState> {
  KQXSNotifier() : super(KQXSInit()){
    getKQXS();
  }

  final _sqlRepotory = SqlRepository(tableName: TableString.kqxs);
  final _dateFormat = CustomDateFormat();

  Future<void> getKQXS({String? mien, DateTime? ngay}) async {
    mien ??= 'N';
    ngay ??= NGAYLAMVIEC;
    state = KQXSLoading();
    try{
      final data = await _sqlRepotory.getData(
        where: "${KQXSString.ngay} = ? AND ${KQXSString.mien} = ?",
        whereArgs: [_dateFormat.yMd(ngay), mien],
      );
      if (data.isEmpty) {
        //Chưa co kqxs
        await addKQXS(mien, ngay);
      } else {
        state = KQXSData(data: data.map((e) => KQXSModel.fromMap(e)).toList());
      }
    }catch(e){
      CustomAlert().error(e.toString());
      state = KQXSData(data: []);
    }

  }

  Future<void> addKQXS(String mien, DateTime ngay) async {
    try{
      final xsMN = await _sqlRepotory.getCellValue(
        field: 'GiaTri',
        where: "Ma = 'xsMN'",
        tableNameOther: TableString.tuyChon,
      );
      final lstMaDai = await getDanhSachMaDai(ngay, mien);
      Map data;
      if (xsMN == '0') {
        data = await getKQXSHomNay(mien: mien, ngay: ngay);
      } else {
        data = await getKQXSMinhNgoc(mien: mien, ngay: ngay);
      }
      if (data.isEmpty) {
        state = KQXSData(data: []);
      } else {
        List<KQXSModel> lstInsert = [];
        for (String maDai in lstMaDai) {
          List<String> kqSo = data[maDai];
          for (int i = 0; i < kqSo.length; i++) {
            lstInsert.add(
              KQXSModel(
                ngay: _dateFormat.yMd(ngay),
                mien: mien,
                maDai: maDai,
                maGiai: getMaGiai(i + 1, mien),
                tt: i + 1,
                kqSo: kqSo[i],
              ),
            );
          }
        }
        await _sqlRepotory.addRows(lstInsert.map((e)=>e.toMap()).toList()).whenComplete(() async {
          final data = await _sqlRepotory.getData(
            where: "${KQXSString.ngay} = ? AND ${KQXSString.mien} = ?",
            whereArgs: [_dateFormat.yMd(ngay), mien],
          );
          state = KQXSData(data: data.map((e)=>KQXSModel.fromMap(e)).toList());
        });


      }
    }catch(e){
      state = KQXSData(data: []);
      CustomAlert().error(e.toString());

    }
  }

  Future<List<String>> getDanhSachMaDai(DateTime ngay, String mien)async{
    try{
      int thu = ngay.weekday-1;
      String where = "${MaDaiString.mien} = ?";
      List<Object?>? whereArgs =  [mien];
      if(mien=='B') thu = 0;
      if(mien!='B'){
        where += " AND ${MaDaiString.thu} = ?";
        whereArgs.add(thu);
      }
      final data = await _sqlRepotory.getData(tableNameOther: TableString.maDai,where: where,whereArgs: whereArgs,orderBy: MaDaiString.tt);
      return data.map((e)=>e[MaDaiString.maDai].toString()).toList();
    }catch(e){
      CustomAlert().error(e.toString());
      return [];
    }
  }

  String getMaGiai(int tt, String mien) {
    if (mien != 'B') {
      if (tt == 1) return 'G8';
      if (tt == 2) return 'G7';
      if ([3, 4, 5].contains(tt)) return 'G6';
      if (tt == 6) return 'G5';
      if ([7, 8, 9, 10, 11, 12, 13].contains(tt)) return 'G4';
      if ([14, 15].contains(tt)) return 'G3';
      if (tt == 16) return 'G2';
      if (tt == 17) return 'G1';
      if (tt == 18) return 'DB';
      return '';
    } else {
      if (tt == 1) return 'DB';
      if (tt == 2) return 'G1';
      if ([3, 4].contains(tt)) return 'G2';
      if ([5, 6, 7, 8, 9, 10].contains(tt)) return 'G3';
      if ([11, 12, 13, 14].contains(tt)) return 'G4';
      if ([15, 16, 17, 18, 19, 20].contains(tt)) return 'G5';
      if ([21, 22, 23].contains(tt)) return 'G6';
      if ([24, 25, 26, 27].contains(tt)) return 'G7';
      return '';
    }
  }
}

abstract class KQXSState {}

class KQXSInit extends KQXSState {}

class KQXSLoading extends KQXSState {}

class KQXSData extends KQXSState {
  final List<KQXSModel> data;

  KQXSData({required this.data});
}
