import 'package:intl/intl.dart';

class CustomDateFormat{
  String dMy(dynamic date){
    if(date.runtimeType == DateTime){
      return DateFormat('dd/MM/yyyy').format(date);
    }
    return date.toString();
  }
  String yMd(dynamic date){
    if(date.runtimeType == DateTime){
      return DateFormat('yyyy-MM-dd').format(date);
    }
    if(date.runtimeType == String){
      final tmp = date.toString().split('/');
      return "${tmp.last}-${tmp[1]}-${tmp.first}";
    }
    return date.toString();
  }
  DateTime toDate(String value){
    if(value.contains('/')){
      final lst = value.split('/');
      final date = "${lst.last}-${lst[1]}-${lst.first}";
      return DateTime.parse(date);
    }
    return DateTime.now();
  }
}