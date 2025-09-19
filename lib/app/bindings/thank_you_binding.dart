import 'package:get/get.dart';

import '../controllers/thank_you_controller.dart';

class ThankYouBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThankYouController>(() => ThankYouController(), fenix: true);
  }
}
