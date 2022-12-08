import 'package:flutter/material.dart';

class ShiftTile extends StatelessWidget {
  final String? shiftName;
  final String? shiftTime;
  final IconData? shiftIconData;
  const ShiftTile(
      {super.key, this.shiftIconData, this.shiftName, this.shiftTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: const EdgeInsets.only(right: 12.0),
              decoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(
                width: 1.0,
              ))),
              child: Icon(
                shiftIconData,
                color: Colors.green,
              ),
            ),
            title: Text(
              shiftName!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[Text(shiftTime!, style: const TextStyle())],
            ),
            trailing: const Icon(Icons.keyboard_arrow_right, size: 30.0)),
      ),
    );
  }
}
