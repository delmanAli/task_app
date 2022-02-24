import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:task_app/constant.dart';
import 'package:task_app/langueges/ar.dart';
import 'package:task_app/langueges/en.dart';

class LocaliztionApp extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        eng: en,
        arb: ar,
      };
}
