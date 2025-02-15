import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../activity/activitycontroller.dart';
import '../activity/activityui.dart';

class HistoryScreen extends StatelessWidget {
  final ActivityController controller = Get.find<ActivityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
              () => ListView.builder(
            itemCount: controller.history.length,
            itemBuilder: (context, index) {
              final entry = controller.history[index];
              return Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  title: Text(entry['activity'] ?? 'Unknown Activity'),
                  subtitle: Text(entry['price'] ?? 'Price: N/A'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
