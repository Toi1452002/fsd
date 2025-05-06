import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/application/notifier/user_notifier.dart';
import 'package:fsd/data/data.dart';


final userProvider = StateNotifierProvider<UserNotifier, void>((ref) {
  return UserNotifier();
});


final userInfoProvider = StateProvider<UserModel?>((ref) {
  return null;
});
