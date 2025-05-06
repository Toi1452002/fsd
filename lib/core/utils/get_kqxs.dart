import 'package:dio/dio.dart';
import 'package:fsd/core/core.dart';
import 'package:fsd/data/data.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

Map<String, String> mMaMien = {'N': 'mien-nam', 'T': 'mien-trung', 'B': 'mien-bac'};

Future<Map> getKQXSHomNay({required String mien, required DateTime ngay}) async {
  String mMien = mMaMien[mien]!;
  String maMien = 'm${mien.toLowerCase()}';
  Uri uriXshomnay = Uri.parse(
    'https://xosohomnay.com.vn/ket-qua-xo-so-$mMien-kqxs-$maMien/ngay-${DateFormat('dd-MM-yyyy').format(ngay)}',
  );
  final getListMaDai = SqlRepository(tableName: TableString.maDai);
  final data = await getListMaDai.getData(
    where: "${MaDaiString.thu} = ? AND ${MaDaiString.mien} = ?",
    whereArgs: [ngay.weekday - 1, mien],
  );
  final mapMaDai = Map.fromEntries(data.map((e) => MapEntry(e['MoTa'], e['MaDai'])));
  Map<String, dynamic> result = {};
  try {
    final response = await Dio().getUri(uriXshomnay);
    if (response.statusCode == 200) {
      final convertHTML = parse(response.data);
      String dateMonth = convertHTML.getElementsByClassName("daymonth").first.text;
      String year = convertHTML.getElementsByClassName("year").first.text;
      String date = dateMonth.split('/').first;
      String month = dateMonth.split('/').last;

      result['Date'] = "$year-$month-$date";
      if ("$year-$month-$date" != CustomDateFormat().yMd(ngay)) {
        CustomAlert().error('KQXS chưa hoàn thành');
        return {};
      }
      if (maMien != 'mb') {
        final row =
            convertHTML
                .getElementsByClassName("rightcl")
                .first
                .getElementsByTagName("table")
                .first
                .getElementsByTagName("tbody")
                .first
                .getElementsByTagName("tr")
                .first;
        final namelong = row.getElementsByClassName("namelong");
        final dayso = row.getElementsByClassName("dayso");
        final lstDaySo = dayso.map((e) => e.innerHtml).toList();
        for (int i = 0; i < namelong.length; i++) {
          try {
            final dai = mapMaDai[namelong[i].innerHtml];
            result[dai] = lstDaySo.sublist(i * 18, (i + 1) * 18);
          } catch (e) {
            CustomAlert().error('Xung đột mã đài');
            return {};
          }
        }
      } else {
        var row = convertHTML.getElementsByClassName("xsmb").first.getElementsByClassName("dayso");
        result['mb'] = row.map((e) => e.text).toList();
      }
    }
    return result;
  } catch (e) {
    CustomAlert().error(e.toString());
    return {};
  }
}

Future<Map> getKQXSMinhNgoc({required String mien, required DateTime ngay}) async{
  String mMien = mMaMien[mien]!;
  Uri uriXsminhngoc = Uri.parse(
      "https://www.minhngoc.net.vn/ket-qua-xo-so/$mMien/${DateFormat('dd-MM-yyyy').format(ngay)}.html");
  final getListMaDai = SqlRepository(tableName: TableString.maDai);
  final data = await getListMaDai.getData(
    where: "${MaDaiString.thu} = ? AND ${MaDaiString.mien} = ?",
    whereArgs: [ngay.weekday - 1, mien],
  );
  final mapMaDai = Map.fromEntries(data.map((e) => MapEntry(e['MoTa'], e['MaDai'])));
  Map<String, dynamic> result = {};
  try{
    final response = await Dio().getUri(uriXsminhngoc);
    if(response.statusCode == 200){
      final convertHTML = parse(response.data);
      final dateKQXS = convertHTML.getElementsByClassName("title").first.getElementsByTagName("a").last.text;
      result['Date'] = CustomDateFormat().yMd(dateKQXS);
      if (CustomDateFormat().yMd(dateKQXS) != CustomDateFormat().yMd(ngay)) {
        CustomAlert().error('KQXS chưa hoàn thành');
        return {};
      }

      if(mien!='B'){
        final nameLong = convertHTML.getElementsByClassName('content')[0].getElementsByClassName("tinh");
        final row = convertHTML.getElementsByClassName('content')[0].getElementsByClassName("rightcl");
        final lstDaySo = [];
        for(var x in row){
          final dayso = x.getElementsByTagName("div");
          for(var s in dayso){
            lstDaySo.add(s.text);
          }
        }
        for(int i= 0;i<nameLong.length;i++){
          try {
            final dai = mapMaDai[nameLong[i].text.trim()];
            result[dai] = lstDaySo.sublist(i * 18, (i + 1) * 18);
          } catch (e) {
            CustomAlert().error('Xung đột mã đài');
            return {};
          }
        }
      }else{
        final row = convertHTML.getElementsByClassName('content')[0].getElementsByTagName("tbody")[1].getElementsByTagName("div");
        List<String> daySo = [];
        for(var x in row){
          if(Check().number(x.text.toString())){
            daySo.add(x.text);
          }
        }
        result['mb'] = daySo;
      }
    }
    return result;
  }catch(e){
    CustomAlert().error(e.toString());
    return {};
  }

}
