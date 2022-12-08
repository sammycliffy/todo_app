import 'package:flutter/material.dart';
import 'package:todo_app/shift_task.dart';
import 'package:todo_app/widget/shift_tile.dart';

class Shifts extends StatefulWidget {
  const Shifts({Key? key}) : super(key: key);

  @override
  State<Shifts> createState() => _ShiftsState();
}

class _ShiftsState extends State<Shifts> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        InkWell(
          onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShiftTasks(
                        shiftName: "Morning",
                      )))),
          child: const ShiftTile(
            shiftName: "Morning Shift",
            shiftTime: "6:30am - 2:00pm",
            shiftIconData: Icons.cloud,
          ),
        ),
        InkWell(
          onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShiftTasks(
                        shiftName: "Evening",
                      )))),
          child: const ShiftTile(
            shiftName: "Evening Shift",
            shiftTime: "2:00am - 9:30pm",
            shiftIconData: Icons.sunny,
          ),
        ),
        InkWell(
          onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShiftTasks(
                        shiftName: "Night",
                      )))),
          child: const ShiftTile(
            shiftName: "Night Shift",
            shiftTime: "9:30pm - 6:30am",
            shiftIconData: Icons.night_shelter,
          ),
        )
      ],
    );
  }
}
