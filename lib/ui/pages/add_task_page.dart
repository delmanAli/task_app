import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_app/controllers/task_controller.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/ui/theme.dart';
import 'package:task_app/ui/widgets/button.dart';
import 'package:task_app/ui/widgets/costum_forn_field.dart';
import 'package:task_app/ui/widgets/custom_appbar.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //tis find the right controller come from GETX.
  final _taskController = Get.find<TaskController>();

  final _titleController = TextEditingController(); //for the title
  final _noteController = TextEditingController(); // for the note
  DateTime _selectedDate = DateTime.now(); // current date
  String _startTime = DateFormat('hh:mm a')
      .format(DateTime.now())
      .toString(); //current date with format.
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString(); //current time with format plus 15 menute for the ends.

  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ]; // default is 5

  String _selectedRepeat = 'none';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ]; //default is none.

  int _selectedColor = 0; //current selected color == blue.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: CostumAppBar(
        title: 'Add Task'.tr,
        context: context,
        isBack: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task here'.tr,
                style: headingStyle,
              ),
              defaultFormField(
                titleText: 'Title'.tr,
                onChanged: (val) {},
                label: 'Title'.tr,
                controller: _titleController,
              ),
              defaultFormField(
                onChanged: (val) {},
                label: 'Note'.tr,
                titleText: 'Note'.tr,
                controller: _noteController,
              ),
              defaultFormField(
                onChanged: (val) {},
                titleText: 'Date'.tr,
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () => _getDateFromUser(),
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: defaultFormField(
                      onChanged: (val) {},
                      titleText: 'Start Time'.tr,
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: defaultFormField(
                      onChanged: (val) {},
                      titleText: 'End Time'.tr,
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () => _getTimeFromUser(isStartTime: true),
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              defaultFormField(
                titleText: 'Remind'.tr,
                onChanged: (val) {},
                hint: '$_selectedRemind minutes early'.tr,
                widget: DropdownButton(
                  borderRadius: BorderRadius.circular(10),
                  dropdownColor: Colors.blueGrey,
                  items: remindList
                      .map<DropdownMenuItem<String>>(
                          (int value) => DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(
                                '$value',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )))
                      .toList(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                  style: subTitleStyle,
                  onChanged: (String? newValue) {
                    _selectedRemind = int.parse(newValue!);
                  },
                ),
              ),
              defaultFormField(
                titleText: 'Repeat'.tr,
                onChanged: (val) {},
                hint: '$_selectedRepeat repeat early',
                widget: DropdownButton(
                  dropdownColor: Colors.blueGrey,
                  items: repeatList
                      .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              )))
                      .toList(),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                  style: subTitleStyle,
                  onChanged: (String? newValue) {
                    _selectedRepeat = newValue!;
                  },
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                    lable: 'Create Task'.tr,
                    onTap: () {
                      _validateData();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _colorPalette() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color'.tr, style: titleStyle),
        Wrap(
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        'required'.tr,
        'all field is required!'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: pinkClr,
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    } else {
      debugPrint('debugPrintIsHere: error valedat');
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTasks(
      task: Task(
        title: _titleController.text,
        note: _noteController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        isCompleted: 0,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
        color: _selectedColor,
      ),
    );
    debugPrint('debugPrintIsHere $value ');
  }

  _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2019),
      lastDate: DateTime(2024),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    } else {
      debugPrint('debugPrintIsHere: not select date');
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(DateTime.now().add(
              const Duration(minutes: 15),
            )),
    );
    String _foramatedTime = _pickedTime!.format(context);
    if (isStartTime) {
      setState(() {
        _startTime = _foramatedTime;
      });
    } else if (!isStartTime) {
      setState(() {
        _endTime = _foramatedTime;
      });
    } else {
      debugPrint('debugPrintIsHere: Time cancled ');
    }
  }
}
