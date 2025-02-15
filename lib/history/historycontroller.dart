import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityController extends GetxController {
  var activity = "Press 'Next' to fetch an activity".obs;
  var price = "".obs;
  var history = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> fetchActivity() async {
    final response = await http.get(Uri.parse('https://bored.api.lewagon.com/api/activity'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      activity.value = data['activity'];
      price.value = "Price: \${data['price'].toString()}";
      history.insert(0, {"activity": activity.value, "price": price.value});
      if (history.length > 50) history.removeLast();
      saveHistory();
    }
  }

  Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedHistory = history.map((e) => json.encode(e)).toList();
    await prefs.setStringList('activity_history', savedHistory);
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedHistory = prefs.getStringList('activity_history');
    if (savedHistory != null) {
      history.assignAll(savedHistory.map((e) => json.decode(e) as Map<String, dynamic>)
          .map((e) => e.map((key, value) => MapEntry(key, value.toString())))
          .toList());
    }
  }
}