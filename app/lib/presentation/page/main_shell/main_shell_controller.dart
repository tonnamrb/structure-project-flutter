import 'package:get/get.dart';

class MainShellController extends GetxController {
  final currentIndex = 0.obs;

  void onTab(int index) => currentIndex.value = index;
}
