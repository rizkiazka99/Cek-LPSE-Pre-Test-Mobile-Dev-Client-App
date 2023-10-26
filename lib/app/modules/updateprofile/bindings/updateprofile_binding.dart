import 'package:get/get.dart';

import '../controllers/updateprofile_controller.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProfileController>(
      () => UpdateProfileController(),
    );
  }
}
