import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Year range (example from wireframe 1994-2014)
  final RangeValues yearRange = const RangeValues(1994, 2014);
  final Rx<RangeValues> selectedRange = const RangeValues(1994, 2014).obs;

  // Genres chips
  final genres = const ['Hip-hop', 'R&B', 'EDM', 'Pop'];
  final RxSet<String> selectedGenres = <String>{}.obs;

  // Toggle between Albums / Artists
  final RxString mode = 'albums'.obs; // 'albums' | 'artists'

  void toggleGenre(String g) {
    if (selectedGenres.contains(g)) {
      selectedGenres.remove(g);
    } else {
      selectedGenres.add(g);
    }
  }

  void setMode(String m) => mode.value = m;

  void setRange(RangeValues v) => selectedRange.value = v;
}
