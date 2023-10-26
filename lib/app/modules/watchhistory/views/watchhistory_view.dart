import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/watchhistory_controller.dart';

class WatchhistoryView extends GetView<WatchhistoryController> {
  const WatchhistoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WatchhistoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WatchhistoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
