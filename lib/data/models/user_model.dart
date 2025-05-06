class UserModel{
  final int? id;
  final String? maKH;
  final String userName;
  final String passWord;
  final String maKichHoat;
  final String ngayHetHan;

  const UserModel({
    this.id,
    this.maKH,
    required this.userName,
    required this.passWord,
    required this.maKichHoat,
    required this.ngayHetHan,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': this.id,
  //     'maKH': this.maKH,
  //     'userName': this.userName,
  //     'passWord': this.passWord,
  //     'maKichHoat': this.maKichHoat,
  //     'ngayHetHan': this.ngayHetHan,
  //   };
  // }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['ID'],
      maKH: map['MaKH'] ,
      userName: map['UserName'] ,
      passWord: map['PassWord'] ,
      maKichHoat: map['MaKichHoat']??'' ,
      ngayHetHan: map['NgayHetHan']??'',
    );
  }
}