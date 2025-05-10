class MaDaiModel {
  int? id;
  String maDai;
  String moTa;
  String mien;
  int thu;
  int tt;

  MaDaiModel({
    this.id,
    required this.maDai,
    required this.moTa,
    required this.mien,
    required this.thu,
    required this.tt,
  });

  Map<String, dynamic> toMap() {
    return {
      MaDaiString.id: id,
      MaDaiString.maDai: maDai,
      MaDaiString.moTa: moTa,
      MaDaiString.mien: mien,
      MaDaiString.thu: thu,
      MaDaiString.tt: tt,
    };
  }

  factory MaDaiModel.fromMap(Map<String, dynamic> map) {
    return MaDaiModel(
      id: map[MaDaiString.id],
      maDai: map[MaDaiString.maDai],
      moTa: map[MaDaiString.moTa],
      mien: map[MaDaiString.mien],
      thu: map[MaDaiString.thu],
      tt: map[MaDaiString.tt]??0,
    );
  }
}

abstract class MaDaiString {
  static const id = "ID";
  static const maDai = "MaDai";
  static const moTa = "MoTa";
  static const mien = "Mien";
  static const thu = "Thu";
  static const tt = "TT";
}
