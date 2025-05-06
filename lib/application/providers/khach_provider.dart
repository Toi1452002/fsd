import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/application/application.dart';
import 'package:fsd/data/data.dart';

final khachProvider = StateNotifierProvider.autoDispose<KhachNotifier,KhachState >((ref) {
  return KhachNotifier();
});


final listGiaKhach1Provider = StateProvider.autoDispose<List<GiaKhachModel>>((ref) {
  return [
    GiaKhachModel(khachID: 0, maKieu: '2s', coMN: 70, trungMN: 70, coMT: 70, trungMT: 70, coMB: 70, trungMB: 70),
    GiaKhachModel(khachID: 0, maKieu: '3s', coMN: 70, trungMN: 600, coMT: 70, trungMT: 600, coMB: 70, trungMB: 600),
    GiaKhachModel(khachID: 0, maKieu: '4s', coMN: 70, trungMN: 5000, coMT: 70, trungMT: 5000, coMB: 70, trungMB: 5000),
    GiaKhachModel(khachID: 0, maKieu: 'dt', coMN: 70, trungMN: 500, coMT: 70, trungMT: 500, coMB: 70, trungMB: 500),
    GiaKhachModel(khachID: 0, maKieu: 'dx', coMN: 70, trungMN: 500, coMT: 70, trungMT: 500, coMB: 0, trungMB: 0),
  ];
});
final listGiaKhach2Provider = StateProvider.autoDispose<List<GiaKhachModel>>((ref) {
  return [
    GiaKhachModel(khachID: 0, maKieu: 'ab', coMN: 70, trungMN: 70, coMT: 70, trungMT: 70, coMB: 70, trungMB: 70),
    GiaKhachModel(khachID: 0, maKieu: 'xc', coMN: 70, trungMN: 600, coMT: 70, trungMT: 600, coMB: 70, trungMB: 600),
    GiaKhachModel(khachID: 0, maKieu: 'b2', coMN: 70, trungMN: 70, coMT: 70, trungMT: 70, coMB: 70, trungMB: 70),
    GiaKhachModel(khachID: 0, maKieu: 'b3', coMN: 60, trungMN: 600, coMT: 60, trungMT: 600, coMB: 60, trungMB: 600),
    GiaKhachModel(khachID: 0, maKieu: 'b4', coMN: 60, trungMN: 5000, coMT: 60, trungMT: 5000, coMB: 60, trungMB: 5000),
    GiaKhachModel(khachID: 0, maKieu: 'dt', coMN: 70, trungMN: 500, coMT: 70, trungMT: 500, coMB: 70, trungMB: 500),
    GiaKhachModel(khachID: 0, maKieu: 'dx', coMN: 70, trungMN: 500, coMT: 70, trungMT: 500, coMB: 70, trungMB: 500),
    GiaKhachModel(khachID: 0, maKieu: 'd4', coMN: 70, trungMN: 5000, coMT: 70, trungMT: 5000, coMB: 70, trungMB: 5000),
  ];
});