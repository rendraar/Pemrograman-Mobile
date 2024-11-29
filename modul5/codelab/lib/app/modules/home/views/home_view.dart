import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7676BB), // Warna #181829
        title: const Text(
          'Lokasi Anda',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF0D0D17), // Warna #0D0D17
              const Color(0xFF181829), // Warna #181829
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(85.0),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  controller.locationMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Warna teks putih agar kontras
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: controller.loading.value
                      ? null
                      : controller.getCurrentLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.loading.value
                        ? const Color(0xFF7676BB)
                        : const Color(0xFF7676BB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                  ),
                  child: controller.loading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Dapatkan Lokasi'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: controller.currentPosition.value != null
                      ? controller.openGoogleMaps
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.currentPosition.value != null
                        ? const Color(0xFF7676BB)
                        : const Color(0xFF7676BB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                  ),
                  child: const Text('Buka di Google Maps'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
