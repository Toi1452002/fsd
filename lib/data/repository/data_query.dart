import 'repository.dart';

class SqlRepository{
  final String tableName;

  const SqlRepository({
    required this.tableName,
  });

  Future<List<Map<String, dynamic>>> getData({String? orderBy, String? where, List<Object?>? whereArgs, String? tableNameOther}) async {
    final cnn = await connectData();
    final data = await cnn!.query(tableNameOther??tableName, orderBy: orderBy, where: where, whereArgs: whereArgs);
    return data;
  }

  Future<List<Map<String, dynamic>>> getCustomData(String sql) async {
    final cnn = await connectData();
    final data = await cnn!.rawQuery(sql);
    return data;
  }
  Future<int> addRow(Map<String, dynamic> map) async {
    final cnn = await connectData();
    return await cnn!.insert(tableName, map);
  }

  Future<int> updateRow(Map<String, dynamic> map, {String? where, String? tableNameOther }) async {
    final cnn = await connectData();
    return await cnn!.update(tableNameOther??tableName, map, where: where);
  }

  Future<int> addCell({required String field, required String value}) async {
    final cnn = await connectData();
    return await cnn!.insert(tableName, {field: value});
  }

  Future<int> updateCell({
    required String field,
    required dynamic value,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final cnn = await connectData();
    return await cnn!.update(tableName, {field: value}, where: where, whereArgs: whereArgs);
  }

  Future<int> delete({String? where, String? tableNameOther}) async {
    final cnn = await connectData();
    await cnn!.execute('PRAGMA foreign_keys = ON');
    return await cnn.delete(tableNameOther ?? tableName, where: where);
  }

  Future<String?> getCellValue({required String field, required String where,String? tableNameOther}) async {
    final cnn = await connectData();
    final data = await cnn!.rawQuery("SELECT $field FROM ${tableNameOther??tableName} WHERE $where");
    return data.isEmpty ? null : data.first[field].toString();
  }

  Future<void> addRows(List<Map<String, dynamic>> data, {String? tableNameOther}) async {
    final cnn = await connectData();
    final bacth = cnn!.batch();
    for (var x in data) {
      bacth.insert(tableNameOther ?? tableName, x);
    }
    await bacth.commit(noResult: true);
  }

  Future<int> countRow({String? where, List<Object?>? whereArgs}) async{
    final data = await getData(where:where ,whereArgs: whereArgs);
    return data.length;
  }
}