import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/application/application.dart';
import 'package:fsd/data/data.dart';

final maDaiProvider = StateNotifierProvider.autoDispose<MaDaiNotifier, List<MaDaiModel>>((ref) {
  return MaDaiNotifier();
});
