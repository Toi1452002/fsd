import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/application/application.dart';

import '../../core/appstring/appstring.dart';
import '../../data/data.dart';


class UserNotifier extends StateNotifier<void> {
  UserNotifier() : super(());
  final _sql = SqlRepository(tableName: TableString.user);

  Future<bool> loginUser(String userName, String passWord, WidgetRef ref) async{
    try{
      final data = await _sql.getData(where: "UserName = ? AND PassWord = ?",whereArgs: [userName,passWord]);
      if(data.isEmpty){
        return false;
      }else{
        ref.read(userInfoProvider.notifier).state = UserModel.fromMap(data.first);
        return true;
      }
    }catch(e){
      return false;
    }
  }
}