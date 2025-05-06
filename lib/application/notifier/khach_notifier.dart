import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/application/application.dart';
import 'package:fsd/core/core.dart';
import 'package:fsd/data/data.dart';

class KhachNotifier extends StateNotifier<KhachState> {
  KhachNotifier() : super(KhachInit()) {
    getListKhach();
  }

  final _sqlRepository = SqlRepository(tableName: TableString.khach);

  Future<void> getListKhach() async {
    try {
      state = KhachLoading();
      final data = await _sqlRepository.getData(orderBy: KhachString.maKhach);
      state = KhachData(khach: data.map((e) => KhachModel.fromMap(e)).toList());
      // state = data.map((e) => KhachModel.fromMap(e)).toList();
    } catch (e) {
      CustomAlert().error(e.toString());
    }
  }

  Future<bool> addKhach(KhachModel k, List<GiaKhachModel> giaKhach) async {
    try {
      if (k.maKhach.isEmpty) {
        CustomAlert().error('Tên khách trống!');
        return false;
      }

      final idInsert = await _sqlRepository.addRow(k.toMap());

      await _sqlRepository.addRows(
        giaKhach.map((e) {
          e = e.copyWith(khachID: idInsert);
          e.id = null;
          return e.toMap();
        }).toList(),
        tableNameOther: TableString.giaKhach,
      );

      getListKhach();

      return true;
    } catch (e) {
      if(e.toString().contains('UNIQUE')){
        CustomAlert().error('Tên khách đã tồn tại');
      }else{
        CustomAlert().error(e.toString());
      }
      return false;
    }
  }


  Future<void> deleteKhach(KhachModel khach) async{
    try{
      await _sqlRepository.delete(where: "${KhachString.maKhach} = '${khach.maKhach}'");
      getListKhach();
    }catch(e){
      CustomAlert().error(e.toString());
    }
  }


  Future<void> getGiaKhach(int kieuTyLe, int khachID, WidgetRef ref) async{
    try{
        final data = await _sqlRepository.getData(tableNameOther: TableString.giaKhach,where: "KhachID = ?",whereArgs: [khachID]);
        if(kieuTyLe==1){
          ref.read(listGiaKhach1Provider.notifier).state = data.map((e)=>GiaKhachModel.fromMap(e)).toList();
        }else{
          ref.read(listGiaKhach2Provider.notifier).state = data.map((e)=>GiaKhachModel.fromMap(e)).toList();
        }
    }catch(e){
      CustomAlert().error(e.toString());
    }
  }

  Future<bool> updateKhach(KhachModel khach, List<GiaKhachModel> giaKhach) async{
    // try{
      if (khach.maKhach.isEmpty) {
        CustomAlert().error('Tên khách trống!');
        return false;
      }

      await Future.wait([
        _sqlRepository.updateRow(khach.toMap(),where: "ID = ${khach.id}"),
        _sqlRepository.delete(tableNameOther: TableString.giaKhach,where: "KhachID = ${khach.id}").whenComplete((){
          _sqlRepository.addRows(
            giaKhach.map((e) {
              e.id = null;
              return e.toMap();
            }).toList(),
            tableNameOther: TableString.giaKhach,
          );
        }),

      ]);
      getListKhach();
      return true;
    // }catch(e){
    //   if(e.toString().contains('UNIQUE')){
    //     CustomAlert().error('Tên khách đã tồn tại');
    //   }else{
    //     CustomAlert().error(e.toString());
    //   }
    //   return false;
    // }
  }



}


abstract class KhachState{}

class KhachInit extends KhachState{}

class KhachLoading extends KhachState{}

class KhachData extends KhachState{
  List<KhachModel> khach;

  KhachData({
    required this.khach,
  });
}