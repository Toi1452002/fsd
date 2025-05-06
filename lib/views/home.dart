import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsd/widgets/custom_drawer.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(title: Text('Xử lý tin'),titleSpacing: 0,),
      body: Center(
        child: Text('Chưa có tin nào'),
      ),
    );
  }
}
