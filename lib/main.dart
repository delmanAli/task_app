import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_app/constant.dart';
import 'package:task_app/controllers/settings_controller.dart';
import 'package:task_app/controllers/task_controller.dart';
import 'package:task_app/db/db_helper.dart';
import 'package:task_app/langueges/localiztion.dart';
import 'package:task_app/services/theme_services.dart';
import 'package:task_app/ui/pages/home_page.dart';
import 'package:task_app/ui/theme.dart';

const String todoBoxName = 'tasks';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DBHelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final TaskController taskController = Get.put(TaskController());
  final SettingController settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: Locale(GetStorage().read<String>('lang').toString()  ),
      translations: LocaliztionApp(),
      fallbackLocale: Locale(eng),
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      // home: const NotificationScreen(payload: 'payload|desc|12:44'),
      home: const HomePage(),
    );
  }
}
