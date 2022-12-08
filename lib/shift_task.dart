import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/provider.dart';
import 'package:todo_app/widget/delete_task_dialog.dart';
import 'package:todo_app/widget/update_task.dart';

class ShiftTasks extends StatefulWidget {
  final String? shiftName;
  const ShiftTasks({Key? key, this.shiftName}) : super(key: key);
  @override
  State<ShiftTasks> createState() => _ShiftTasksState();
}

class _ShiftTasksState extends State<ShiftTasks> {
  final fireStore = FirebaseFirestore.instance;
  UserNotifier? _userNotifier;
  @override
  Widget build(BuildContext context) {
    _userNotifier = Provider.of<UserNotifier>(context, listen: false);
    CollectionReference s = FirebaseFirestore.instance
        .collection("users")
        .doc(_userNotifier!.email)
        .collection("tasks");
    Query query = s.where("shift", isEqualTo: widget.shiftName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget.shiftName} Tasks"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: query.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('No tasks to display');
            } else {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  Color taskColor = AppColors.blueShadeColor;
                  var status = data['status'];

                  return Card(
                    elevation: 3.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 6.0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      leading: status
                          ? const Icon(
                              Icons.done,
                              size: 30,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.star_half,
                              color: Colors.amber,
                            ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: Text(
                          data['taskName'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                      subtitle: Text(data['taskDesc']),
                      isThreeLine: true,
                      trailing: PopupMenuButton(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: 'edit',
                              child: const Text(
                                'Edit',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              onTap: () {
                                String taskId = (data['id']);
                                String taskName = (data['taskName']);
                                String taskDesc = (data['taskDesc']);
                                String shift = (data['shift']);
                                bool status = (data['status']);
                                Future.delayed(
                                  const Duration(seconds: 0),
                                  () => showDialog(
                                    context: context,
                                    builder: (context) => UpdateTaskAlertDialog(
                                      taskId: taskId,
                                      taskName: taskName,
                                      taskDesc: taskDesc,
                                      shift: shift,
                                      status: status,
                                    ),
                                  ),
                                );
                              },
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: const Text(
                                'Delete',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              onTap: () {
                                String taskId = (data['id']);
                                String taskName = (data['taskName']);
                                Future.delayed(
                                  const Duration(seconds: 0),
                                  () => showDialog(
                                    context: context,
                                    builder: (context) => DeleteTaskDialog(
                                        taskId: taskId, taskName: taskName),
                                  ),
                                );
                              },
                            ),
                          ];
                        },
                      ),
                      dense: true,
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
