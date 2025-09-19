import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'favorites_controller.dart';

class FavoritesPage extends GetView<FavoritesController> {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('favorites'.tr));
  }
}
