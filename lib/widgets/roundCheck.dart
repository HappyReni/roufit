import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

enum TweenProps { backgroundColor, textColor }

class RoundCheck extends StatefulWidget {
  RoundCheck({
    Key key,
    @required this.day,
    this.selectedDays,
    this.onTap,
    this.isModify = false,
  });

  final Day day;
  final List<Day> selectedDays;
  final Function onTap;
  bool isModify;

  @override
  _RoundCheckState createState() => _RoundCheckState();
}

class _RoundCheckState extends State<RoundCheck> {
  @override
  Widget build(BuildContext context) {
    return RoundCheckBox(
      isChecked: widget.isModify,
      uncheckedWidget: Center(
        child: Text(
          '${widget.day.day}',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
      checkedColor: Colors.blue,
      animationDuration: Duration(milliseconds: 400),
      // animationCurve: Curves.easeOut,
      onTap: (isChecked) {
        setState(
          () {
            isChecked
                ? widget.selectedDays.add(widget.day)
                : widget.selectedDays.remove(widget.day);
            print(widget.selectedDays);
          },
        );
      },
    );
  }
}
