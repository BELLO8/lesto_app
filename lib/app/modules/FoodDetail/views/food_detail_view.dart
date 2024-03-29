import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/food_detail_controller.dart';

class FoodDetailView extends GetView<FoodDetailController> {
  const FoodDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          ' ',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
