
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

export 'data_query.dart';

Future<Database?> connectData() async{
  // Android
  var dbPath = await getDatabasesPath();
  var path = join(dbPath, "data.db");
  var exist = await databaseExists(path);

  if(exist){
    return await openDatabase(path);
  }else{
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}
    ByteData data = await rootBundle.load(join("assets", "data.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);

    return await openDatabase(path);
  }
}

