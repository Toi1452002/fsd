import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/application/notifier/z_notifier.dart';
import 'package:fsd/data/data.dart';


final kqxsProvider = StateNotifierProvider.autoDispose<KQXSNotifier, KQXSState>((ref) {
  return KQXSNotifier();
});
