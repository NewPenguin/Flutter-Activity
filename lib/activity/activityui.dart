import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../history/historyui.dart';
import './activitycontroller.dart';

final ActivityController counterController = Get.put(ActivityController());

class MyActivity extends StatefulWidget {
  const MyActivity({super.key, required this.title});
  final String title;

  @override
  State<MyActivity> createState() => MainScreen();
}

class MainScreen extends State<MyActivity> {
  final ActivityController controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() => Text(
                  controller.activity.value,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                )),
              ),
              Obx(() => Text(
                controller.price.value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
              SizedBox(height: 20),
              ElevatedButton(onPressed: controller.fetchActivity, child: Text('Next')),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (Get.isRegistered<ActivityController>()) {
                    Get.to(() => HistoryScreen());
                  } else {
                    print("ActivityController not registered yet");
                  }
                },
                child: Text('History'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
