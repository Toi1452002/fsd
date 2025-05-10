class KQXSModel{
  final int? id;
  final String ngay;
  final String mien;
  final String maDai;
  final String maGiai;
  final int tt;
  final String kqSo;

  const KQXSModel({
    this.id,
    required this.ngay,
    required this.mien,
    required this.maDai,
    required this.maGiai,
    required this.tt,
    required this.kqSo,
  });

  Map<String, dynamic> toMap() {
    return {
      KQXSString.id: id,
      KQXSString.ngay: ngay,
      KQXSString.mien: mien,
      KQXSString.maDai: maDai,
      KQXSString.maGiai: maGiai,
      KQXSString.tt: tt,
      KQXSString.kqSo: kqSo,
    };
  }

  factory KQXSModel.fromMap(Map<String, dynamic> map) {
    return KQXSModel(
      id: map[KQXSString.id],
      ngay: map[KQXSString.ngay] ,
      mien: map[KQXSString.mien] ,
      maDai: map[KQXSString.maDai] ,
      maGiai: map[KQXSString.maGiai] ,
      tt: map[KQXSString.tt],
      kqSo: map[KQXSString.kqSo] ,
    );
  }
}

abstract class KQXSString{
  static const id = "ID";
  static const ngay = "Ngay";
  static const mien = "Mien";
  static const maDai = "MaDai";
  static const maGiai = "MaGiai";
  static const tt = "TT";
  static const kqSo = "KQso";
}