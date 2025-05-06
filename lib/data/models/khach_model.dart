class KhachModel {
  int? id;
  final String maKhach;
  final String sdt;
  final bool kDauTren;
  final int hoiTong;
  final int hoi2S;
  final int hoi3S;
  final bool thuongMN;
  final bool themChiMN;
  final bool thuongMT;
  final bool themChiMT;
  final bool thuongMB;
  final bool themChiMB;
  final int kieuTyLe;
  final bool tkDa;
  final bool tkAB;

  KhachModel({
    this.id,
    required this.maKhach,
    required this.sdt,
    required this.kDauTren,
    required this.hoiTong,
    required this.hoi2S,
    required this.hoi3S,
    required this.thuongMN,
    required this.themChiMN,
    required this.thuongMT,
    required this.themChiMT,
    required this.thuongMB,
    required this.themChiMB,
    required this.kieuTyLe,
    required this.tkDa,
    required this.tkAB,
  });

  Map<String, dynamic> toMap() {
    return {
      KhachString.id: id,
      KhachString.maKhach: maKhach,
      KhachString.sdt: sdt,
      KhachString.kDauTren: kDauTren?1:0,
      KhachString.hoiTong: hoiTong,
      KhachString.hoi2S: hoi2S,
      KhachString.hoi3S: hoi3S,
      KhachString.thuongMN: thuongMN?1:0,
      KhachString.themChiMN: themChiMN?1:0,
      KhachString.thuongMT: thuongMT?1:0,
      KhachString.themChiMT: themChiMT?1:0,
      KhachString.thuongMB: thuongMB?1:0,
      KhachString.themChiMB: themChiMB?1:0,
      KhachString.kieuTyLe: kieuTyLe,
      KhachString.tkDa: tkDa?1:0,
      KhachString.tkAB: tkAB?1:0,
    };
  }

  factory KhachModel.fromMap(Map<String, dynamic> map) {
    return KhachModel(
      id: map[KhachString.id],
      maKhach: map[KhachString.maKhach],
      sdt: map[KhachString.sdt],
      kDauTren: map[KhachString.kDauTren]==1?true:false,
      hoiTong: map[KhachString.hoiTong],
      hoi2S: map[KhachString.hoi2S],
      hoi3S: map[KhachString.hoi3S],
      thuongMN: map[KhachString.thuongMN]==1?true:false,
      themChiMN: map[KhachString.themChiMN]==1?true:false,
      thuongMT: map[KhachString.thuongMT]==1?true:false,
      themChiMT: map[KhachString.themChiMT]==1?true:false,
      thuongMB: map[KhachString.thuongMB]==1?true:false,
      themChiMB: map[KhachString.themChiMB]==1?true:false,
      kieuTyLe: map[KhachString.kieuTyLe],
      tkDa: map[KhachString.tkDa]==1?true:false,
      tkAB: map[KhachString.tkAB]==1?true:false,
    );
  }

  KhachModel copyWith({
    int? id,
    String? maKhach,
    String? sdt,
    bool? kDauTren,
    int? hoiTong,
    int? hoi2S,
    int? hoi3S,
    bool? thuongMN,
    bool? themChiMN,
    bool? thuongMT,
    bool? themChiMT,
    bool? thuongMB,
    bool? themChiMB,
    int? kieuTyLe,
    bool? tkDa,
    bool? tkAB,
  }) {
    return KhachModel(
      id: id ?? this.id,
      maKhach: maKhach ?? this.maKhach,
      sdt: sdt ?? this.sdt,
      kDauTren: kDauTren ?? this.kDauTren,
      hoiTong: hoiTong ?? this.hoiTong,
      hoi2S: hoi2S ?? this.hoi2S,
      hoi3S: hoi3S ?? this.hoi3S,
      thuongMN: thuongMN ?? this.thuongMN,
      themChiMN: themChiMN ?? this.themChiMN,
      thuongMT: thuongMT ?? this.thuongMT,
      themChiMT: themChiMT ?? this.themChiMT,
      thuongMB: thuongMB ?? this.thuongMB,
      themChiMB: themChiMB ?? this.themChiMB,
      kieuTyLe: kieuTyLe ?? this.kieuTyLe,
      tkDa: tkDa ?? this.tkDa,
      tkAB: tkAB ?? this.tkAB,
    );
  }
}

abstract class KhachString {
  static const id = "ID";
  static const maKhach = "MaKhach";
  static const sdt = "SDT";
  static const kDauTren = "KDauTren";
  static const hoiTong = "HoiTong";
  static const hoi2S = "Hoi2s";
  static const hoi3S = "Hoi3s";
  static const thuongMN = "ThuongMN";
  static const themChiMN = "ThemChiMN";
  static const thuongMT = "ThuongMT";
  static const themChiMT = "ThemChiMT";
  static const thuongMB = "ThuongMB";
  static const themChiMB = "ThemChiMB";
  static const kieuTyLe = "KieuTyLe";
  static const tkDa = "tkDa";
  static const tkAB = "tkAB";
}

class GiaKhachModel {
  int? id;
  final int khachID;
  final String maKieu;
  double coMN;
  final double chiaMN;
  final double? tyLeMN;
  double trungMN;
  double coMT;
  final double chiaMT;
  final double? tyLeMT;
  double trungMT;
  double coMB;
  final double chiaMB;
  final double? tyLeMB;
  double trungMB;

  GiaKhachModel({
    this.id,
    required this.khachID,
    required this.maKieu,
    required this.coMN,
    this.chiaMN = 100,
    this.tyLeMN,
    required this.trungMN,
    required this.coMT,
    this.chiaMT = 100,
    this.tyLeMT,
    required this.trungMT,
    required this.coMB,
    this.chiaMB = 100,
    this.tyLeMB,
    required this.trungMB,
  });

  Map<String, dynamic> toMap() {
    return {
      GiaKhachString.id: id,
      GiaKhachString.khachID: khachID,
      GiaKhachString.maKieu: maKieu,
      GiaKhachString.coMN: coMN,
      GiaKhachString.chiaMN: chiaMN == 0 ? 100 : chiaMN,
      GiaKhachString.tyLeMN: coMN / chiaMN,
      GiaKhachString.trungMN: trungMN,
      GiaKhachString.coMT: coMT,
      GiaKhachString.chiaMT: chiaMT == 0 ? 100 : chiaMT,
      GiaKhachString.tyLeMT: coMT / chiaMT,
      GiaKhachString.trungMT: trungMT,
      GiaKhachString.coMB: coMB,
      GiaKhachString.chiaMB: chiaMB == 0 ? 100 : chiaMB,
      GiaKhachString.tyLeMB: coMB / chiaMB,
      GiaKhachString.trungMB: trungMB,
    };
  }

  factory GiaKhachModel.fromMap(Map<String, dynamic> map) {
    return GiaKhachModel(
      id: map[GiaKhachString.id],
      khachID: map[GiaKhachString.khachID],
      maKieu: map[GiaKhachString.maKieu],
      coMN: double.parse(map[GiaKhachString.coMN].toString()),
      chiaMN:double.parse( map[GiaKhachString.chiaMN].toString()),
      tyLeMN: double.parse(map[GiaKhachString.tyLeMN].toString()),
      trungMN: double.parse(map[GiaKhachString.trungMN].toString()),
      coMT: double.parse(map[GiaKhachString.coMT].toString()),
      chiaMT: double.parse(map[GiaKhachString.chiaMT].toString()),
      tyLeMT: double.parse(map[GiaKhachString.tyLeMT].toString()),
      trungMT: double.parse(map[GiaKhachString.trungMT].toString()),
      coMB: double.parse(map[GiaKhachString.coMB].toString()),
      chiaMB: double.parse(map[GiaKhachString.chiaMB].toString()),
      tyLeMB: double.parse(map[GiaKhachString.tyLeMB].toString()),
      trungMB: double.parse(map[GiaKhachString.trungMB].toString()),
    );
  }

  GiaKhachModel copyWith({
    int? id,
    int? khachID,
    String? maKieu,
    double? coMN,
    double? chiaMN,
    double? tyLeMN,
    double? trungMN,
    double? coMT,
    double? chiaMT,
    double? tyLeMT,
    double? trungMT,
    double? coMB,
    double? chiaMB,
    double? tyLeMB,
    double? trungMB,
  }) {
    return GiaKhachModel(
      id: id ?? this.id,
      khachID: khachID ?? this.khachID,
      maKieu: maKieu ?? this.maKieu,
      coMN: coMN ?? this.coMN,
      chiaMN: chiaMN ?? this.chiaMN,
      tyLeMN: tyLeMN ?? this.tyLeMN,
      trungMN: trungMN ?? this.trungMN,
      coMT: coMT ?? this.coMT,
      chiaMT: chiaMT ?? this.chiaMT,
      tyLeMT: tyLeMT ?? this.tyLeMT,
      trungMT: trungMT ?? this.trungMT,
      coMB: coMB ?? this.coMB,
      chiaMB: chiaMB ?? this.chiaMB,
      tyLeMB: tyLeMB ?? this.tyLeMB,
      trungMB: trungMB ?? this.trungMB,
    );
  }
}

abstract class GiaKhachString {
  static const id = "ID";
  static const khachID = "KhachID";
  static const maKieu = "MaKieu";
  static const coMN = "CoMN";
  static const chiaMN = "ChiaMN";
  static const tyLeMN = "TyLeMN";
  static const trungMN = "TrungMN";
  static const coMT = "CoMT";
  static const chiaMT = "ChiaMT";
  static const tyLeMT = "TyLeMT";
  static const trungMT = "TrungMT";
  static const coMB = "CoMB";
  static const chiaMB = "ChiaMB";
  static const tyLeMB = "TyLeMB";
  static const trungMB = "TrungMB";
}
