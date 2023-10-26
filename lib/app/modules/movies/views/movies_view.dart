import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/movies_controller.dart';

class MoviesView extends GetView<MoviesController> {
  const MoviesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoviesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MoviesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
