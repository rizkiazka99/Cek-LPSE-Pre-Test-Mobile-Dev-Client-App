import 'package:get/get.dart';

import '../controllers/watchhistory_controller.dart';

class WatchhistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchhistoryController>(
      () => WatchhistoryController(),
    );
  }
}
