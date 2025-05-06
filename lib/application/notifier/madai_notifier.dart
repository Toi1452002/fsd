import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/data/data.dart';

import '../../core/core.dart';

class MaDaiNotifier extends StateNotifier<List<MaDaiModel>> {
  MaDaiNotifier() : super([]) {
    getMaDaiTheoThu();
  }

  final _sqlRepository = SqlRepository(tableName: TableString.maDai);

  Future<void> getMaDaiTheoThu({int thu = 0, String mien = 'N'}) async {
    try {
      final data = await _sqlRepository.getData(
        where: "${MaDaiString.thu} = ? AND ${MaDaiString.mien} = ?",
        whereArgs: [thu, mien],
        orderBy: MaDaiString.tt,
      );
      state = data.map((e) => MaDaiModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addMaDai(MaDaiModel maDai) async {
    try {
      if (maDai.tt == 0 || maDai.maDai.isEmpty || maDai.moTa.isEmpty) {
        CustomAlert().error('Điền đầy đủ thông tin');
        return false;
      }

      final checkLength = await _sqlRepository.countRow(
        where: "${MaDaiString.thu} = ?  AND ${MaDaiString.mien} = ?",
        whereArgs: [maDai.thu, maDai.mien],
      );
      if (checkLength == 4) {
        CustomAlert().error('Tối đa 4 mã đài');
        return false;
      }

      final checkMaDai = await _sqlRepository.countRow(
        where: "${MaDaiString.thu} = ? AND ${MaDaiString.maDai} = ? AND ${MaDaiString.mien} = ?",
        whereArgs: [maDai.thu, maDai.maDai, maDai.mien],
      );
      if (checkMaDai > 0) {
        CustomAlert().error('Mã đài đã tồn tại');
        return false;
      }
      final checkTT = await _sqlRepository.countRow(
        where: "${MaDaiString.thu} = ? AND ${MaDaiString.tt} = ?  AND ${MaDaiString.mien} = ?",
        whereArgs: [maDai.thu, maDai.tt, maDai.mien],
      );
      if (checkTT > 0) {
        CustomAlert().error('TT đã tồn tại');
        return false;
      }

      await _sqlRepository.addRow(maDai.toMap());
      getMaDaiTheoThu(mien: maDai.mien, thu: maDai.thu);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> deleteMaDai(MaDaiModel maDai) async {
    try {
      await _sqlRepository.delete(where: "${MaDaiString.id} = ${maDai.id}");
      getMaDaiTheoThu(mien: maDai.mien, thu: maDai.thu);
    } catch (e) {
      CustomAlert().error(e.toString());
    }
  }

  Future<bool> updateMaDai(MaDaiModel maDai) async {
    try {
      if (maDai.tt == 0 || maDai.maDai.isEmpty || maDai.moTa.isEmpty) {
        CustomAlert().error(AppString.thieuThongTin);
        return false;
      }
      final checkMaDai = await _sqlRepository.countRow(
        where: "${MaDaiString.thu} = ? AND ${MaDaiString.maDai} = ? AND ${MaDaiString.mien} = ? AND ${MaDaiString.id} != ?",
        whereArgs: [maDai.thu, maDai.maDai, maDai.mien, maDai.id],
      );
      if (checkMaDai > 0) {
        CustomAlert().error('Mã đài đã tồn tại');
        return false;
      }
      final checkTT = await _sqlRepository.countRow(
        where: "${MaDaiString.thu} = ? AND ${MaDaiString.tt} = ?  AND ${MaDaiString.mien} = ?  AND ${MaDaiString.id} != ?",
        whereArgs: [maDai.thu, maDai.tt, maDai.mien, maDai.id],
      );
      if (checkTT > 0) {
        CustomAlert().error('TT đã tồn tại');
        return false;
      }
      await _sqlRepository.updateRow(maDai.toMap(), where: "ID = ${maDai.id}");
      getMaDaiTheoThu(mien: maDai.mien, thu: maDai.thu);
      return true;
    } catch (e) {
      CustomAlert().error(e.toString());
      return false;
    }
  }
}
