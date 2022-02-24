
import 'package:flutter/material.dart';
import 'package:task_app/constant.dart';
import 'package:task_app/controllers/task_controller.dart';
import 'package:task_app/services/notification_services.dart';
import 'package:task_app/services/theme_services.dart';
import 'package:get/get.dart';
import 'package:task_app/ui/theme.dart';

import '../../controllers/settings_controller.dart';

class CostumAppBar extends StatelessWidget implements PreferredSizeWidget {
  CostumAppBar({
    Key? key,
    required this.context,
    required this.title,
    this.notifyHelper,
    this.isBack = false,
  }) : super(key: key);

  final TaskController _taskController = Get.find();
  final BuildContext context;
  final NotifyHelper? notifyHelper;
  final bool isBack;
  final String title;
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      builder: (controller) => AppBar(
        centerTitle: true,
        title: Text(title,style: TextStyle(color:
        Get.isDarkMode ? Colors.white:Colors.black,


        ),),
        leading: Row(
          children: [
            if (isBack == false)
              IconButton(
                onPressed: () {
                  ThemeServices().switchTheme();
                },
                icon: Icon(
                  Get.isDarkMode
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round_outlined,
                  size: 24,
                  color: Get.isDarkMode ? Colors.white : darkGreyClr,
                ),
              ),
            if (isBack == true)
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 24,
                  color: Get.isDarkMode ? Colors.white : darkGreyClr,
                ),
              ),
          ],
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
        actions: [
          if (isBack == false)
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Delete All Task'.tr,
                  content:  Text('Do you want to delete all tasks?'.tr),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        notifyHelper!.cancleAllNotifications();
                        _taskController.deleteAllTasks();
                      },
                      child:  Text('delete'.tr),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child:  Text('cancel'.tr),
                    ),
                  ],
                );
              },
              icon: Icon(
                Icons.cleaning_services_outlined,
                size: 24,
                color: Get.isDarkMode ? Colors.white : darkGreyClr,
              ),
            ),
          const SizedBox(width: 4),
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              iconSize: 21,
              icon: const Icon(Icons.arrow_drop_down),
              items: [
                DropdownMenuItem(
                  value: eng,
                  child: const Text('EN'),
                ),
                DropdownMenuItem(
                  value: arb,
                  child: const Text('AR'),
                ),
              ],
              value: controller.langlocal,
              onChanged: (value) {
                controller.changeLanguge(value!);
                Get.updateLocale(Locale(value));
              },
            ),
          ),
          // const CircleAvatar(
          //   backgroundImage: AssetImage('images/person.jpeg'),
          //   radius: 18,
          // ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
