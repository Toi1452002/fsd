import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/app_router/app_router.dart';
import 'package:go_router/go_router.dart';

import '../views/views.dart';

final routerProvider = StateProvider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouterPath.login,
    routes: [
      GoRoute(path: RouterPath.login, builder: (context, state) => LoginView()),
      GoRoute(path: RouterPath.home, builder: (context, state) => HomeView()),

      GoRoute(path: RouterPath.khach, builder: (context, state) => KhachView()),
      GoRoute(path: RouterPath.thongTinKhach, builder: (context, state) => ThongTinKhachView()),

      GoRoute(path: RouterPath.caiDat, builder: (context, state) => CaiDatView()),
      GoRoute(path: RouterPath.tuyChinhMaDai, builder: (context, state) => TuyChinhMaDaiView()),
    ],
  );
});
