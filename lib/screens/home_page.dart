import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/functions/db_functions.dart';
import 'package:todolist/model/data_model.dart';
import 'package:todolist/screens/widget_pages/checkbox_change.dart';
import 'package:todolist/screens/widget_pages/drawer.dart';
import 'package:todolist/screens/widget_pages/search_bar.dart';
import 'package:todolist/theme/theme_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum FilterCriteria {
  Daily,
  Weekly,
  Monthly,
  Yearly,
}

FilterCriteria selectedFilter = FilterCriteria.Daily;

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _discriptController = TextEditingController();
  List<TaskModel> todolist = [];
  List<TaskModel> filteredTasks = [];
  final _formKey = GlobalKey<FormState>();
  List<int>? imageBytes;
  File? file;
  ImagePicker image = ImagePicker();
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    final taskDb = Hive.box<TaskModel>('task_db');
    todolist = taskDb.values.toList();
    taskListNotifier.value = todolist;
    filteredTasks = todolist;
  }

  void filterTasks(String search) {
    final filteredBySearch = search.isEmpty
        ? todolist
        : todolist
            .where((task) =>
                task.taskName.toLowerCase().contains(search.toLowerCase()))
            .toList();

    final filteredByCriteria = filterTasksByCriteria(filteredBySearch);

    setState(() {
      filteredTasks = filteredByCriteria;
    });
  }

  List<TaskModel> filterTasksByCriteria(List<TaskModel> tasks) {
    final now = DateTime.now();
    switch (selectedFilter) {
      case FilterCriteria.Daily:
        return tasks.where((task) {
          final taskDate = task.date;
          return taskDate.year == now.year &&
              taskDate.month == now.month &&
              taskDate.day == now.day;
        }).toList();
      case FilterCriteria.Weekly:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return tasks.where((task) {
          final taskDate = task.date;
          return taskDate.isAfter(startOfWeek) &&
              taskDate.isBefore(endOfWeek.add(const Duration(days: 1)));
        }).toList();
      case FilterCriteria.Monthly:
        final startOfMonth = DateTime(now.year, now.month, 1);
        final endOfMonth = DateTime(now.year, now.month + 1, 0);
        return tasks.where((task) {
          final taskDate = task.date;
          return taskDate.isAfter(startOfMonth) &&
              taskDate.isBefore(endOfMonth.add(const Duration(days: 1)));
        }).toList();
      case FilterCriteria.Yearly:
        final startOfYear = DateTime(now.year, 1, 1);
        final endOfYear = DateTime(now.year, 12, 31);
        return tasks.where((task) {
          final taskDate = task.date;
          return taskDate.isAfter(startOfYear) &&
              taskDate.isBefore(endOfYear.add(const Duration(days: 1)));
        }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final storedImageBytes = getStoredImage();
    final imageWidget = storedImageBytes != null
        ? Image.memory(
            storedImageBytes,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          )
        : const Icon(
            Icons.party_mode_outlined,
            color: Colors.white,
            size: 40,
          );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: themeManager.primaryColor,
      ),
      endDrawer: draWer(),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.40),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    color: themeManager.primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 160,left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.40),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color:const  Color.fromARGB(255, 185, 184, 184),
                              width: 1.0,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              _addPhotoFunction(context);
                            },
                            child: ClipOval(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                   const Color.fromARGB(255, 174, 198, 221),
                                child: imageWidget,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        AnimatedSearchBar(
                          onSearch: filterTasks,
                        ),
                        
                      ],
                    
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: themeManager.headingsColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "All Task's",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.grey),
                      ),
                      DropdownButton<FilterCriteria>(
                        value: selectedFilter,
                        onChanged: (newValue) {
                          setState(() {
                            selectedFilter = newValue!;
                            filterTasks('');
                          });
                        },
                        items: FilterCriteria.values.map((criteria) {
                          return DropdownMenuItem<FilterCriteria>(
                            value: criteria,
                            child: Text(criteria.toString().split('.').last),
                          );
                        }).toList(),
                      ),
                      FloatingActionButton(
                        backgroundColor: themeManager.floatingButtonColor,
                        splashColor: const Color.fromARGB(255, 240, 189, 48),
                        onPressed: () {
                          _showAddDialogue(context);
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Builder(
              builder: (context) {
                return ValueListenableBuilder(
                    valueListenable: taskListNotifier,
                    builder: (BuildContext ctx, List<TaskModel> studentList,
                        Widget? child) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            final data = filteredTasks[index];
                            return Container(
                              width: 200,
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  elevation: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: ListTile(
                                      title: Text(
                                        data.taskName,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          decoration: data.tasComplete
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${DateFormat('MM/dd/yyyy').format(data.date)}',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          if (data.description != null &&
                                              data.description.isNotEmpty)
                                            Text(
                                              '${data.description}',
                                              style: TextStyle(fontSize: 14),
                                            ),
                                        ],
                                      ),
                                      leading: CustomCheckbox(
                                        value: data.tasComplete,
                                        onChanged: (newValue) {
                                          setState(() {
                                            checkBoxchanged(newValue, index);
                                            data.tasComplete =
                                                newValue ?? false;
                                          });
                                        },
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                              onTap: () {
                                                AlertDialog(
                                                  title: Text(
                                                      'Are you sure you want to delete this task..?'),
                                                );
                                                _showEditDialogBox(index);
                                              },
                                              child: Icon(Icons.edit)),
                                          InkWell(
                                              onTap: () {
                                                AlertDialog(
                                                  title: Text(
                                                      'Are you sure you want to delete this task..?'),
                                                );
                                                _showDeleteConfirmationDialog(
                                                    context, index);
                                              },
                                              child: Icon(Icons.delete)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showAddDialogue(BuildContext context) {
    _dateTime = DateTime.now();
    _dateController.text = _formatDate(_dateTime);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            title: Text('Add Task'),
            content: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Task is Empty';
                    }
                    return null;
                  },
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: 'Task',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 4, 18, 94)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Select Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 4, 18, 94)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        splashColor: Colors.grey,
                        onTap: () => _showDatePicker(),
                        child: Icon(
                          Icons.date_range_outlined,
                          size: 20,
                          color: Colors.grey,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _discriptController,
                  decoration: InputDecoration(
                    hintText: 'Description (optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 4, 18, 94)),
                    ),
                  ),
                  maxLines: 4,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                  child: Text('Add'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        saveTask();
                      });
                      Navigator.of(context).pop();
                    }
                    print('Data is Empty');
                  }),
              TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        );
      },
    );
  }

  Future<void> saveTask() async {
    final _task = _taskController.text.trim();
    final _date = _dateTime;
    final _descriPtion = _discriptController.text.trim();
    final task = TaskModel(
        taskName: _task,
        tasComplete: false,
        date: _date,
        description: _descriPtion);
    await addtask(task);
    _taskController.clear();
    _dateController.clear();
    _discriptController.clear();
  }

  void checkBoxchanged(bool? value, int index) async {
    final taskDb = Hive.box<TaskModel>('task_db');
    final task = taskDb.getAt(index);
    if (task != null) {
      task.tasComplete = value ?? false;
      await taskDb.putAt(index, task);
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  deleteTask(index);
                  todolist.removeAt(index);
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialogBox(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final String currentTaskName = todolist[index].taskName;
        final String currentDescription = todolist[index].description;
        _taskController.text = currentTaskName;
        _discriptController.text = currentDescription;
        _dateController.text =
            DateFormat('MM/dd/yyyy').format(todolist[index].date);

        return Form(
          key: _formKey,
          child: AlertDialog(
            title: Text('Edit Task'),
            content: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Task is Empty';
                    }
                    return null;
                  },
                  controller: _taskController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 4, 18, 94),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date is Empty';
                          }
                          return null;
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Select Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 4, 18, 94)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                        splashColor: Colors.grey,
                        onTap: () => _showDatePicker(),
                        child: Icon(
                          Icons.date_range_outlined,
                          size: 20,
                          color: Colors.grey,
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _discriptController,
                  decoration: InputDecoration(
                    hintText: 'Description (optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 4, 18, 94)),
                    ),
                  ),
                  maxLines: 4,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final updatedTask = TaskModel(
                        taskName: _taskController.text.trim(),
                        tasComplete: todolist[index].tasComplete,
                        date: _dateTime,
                        description: _discriptController.text.trim());
                    updateTask(index, updatedTask);
                    Navigator.of(context).pop();
                  }
                },
              ),
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  getCam(ImageSource source) async {
    var img = await image.pickImage(source: source);
    setState(() {
      file = File(img!.path);
    });
  }

  void _addPhotoFunction(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Add Profile picture')),
          actions: <Widget>[
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () async {
                          final selectedImage =
                              await image.pickImage(source: ImageSource.camera);
                          if (selectedImage != null) {
                            setState(() {
                              file = File(selectedImage.path);
                            });
                            storeImageInHive(file!);

                            Navigator.of(context).pop();
                          }
                        },
                        child: Icon(Icons.camera_alt_outlined,
                            color: Colors.white),
                        backgroundColor: Colors.red,
                      ),
                      FloatingActionButton(
                        onPressed: () async {
                          final selectedImage = await image.pickImage(
                              source: ImageSource.gallery);
                          if (selectedImage != null) {
                            setState(() {
                              file = File(selectedImage.path);
                            });
                            storeImageInHive(file!);

                            Navigator.of(context).pop();
                          }
                        },
                        child: Icon(
                          Icons.folder_open_outlined,
                          color: Colors.white,
                        ),
                        backgroundColor: Color.fromARGB(255, 241, 218, 6),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
          _dateController.text = _formatDate(value);
        });
      }
    });
  }

  String _formatDate(DateTime date) {
    return DateFormat('MM/dd/yyyy').format(date);
  }
}
