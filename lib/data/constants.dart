import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hr_app/widgets/routine.dart';
part 'constants.g.dart';

const kPagePadding = EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 0.0);
const kPagePaddingwithTopbar = EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0);

const kTimerTitleStyle = TextStyle(
  fontSize: 48.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kUndoStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kDoneStyle = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const kPageTitleStyle = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kPageSubTitleStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.normal,
  color: Color(0xFF8E8E93),
);
const kTopBarTextStyle = TextStyle(
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);
const kRoutineTitleStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kRoutineTagStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  color: Color(0xFFE0E0E0),
);

const kWorkoutNameStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kWorkoutAddSetTitleStyle = TextStyle(
  fontSize: 32.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kWorkoutAddSetTagStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
  color: Colors.black54,
);

const kOutlinedButtonTextStyle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
const kBottomFixedButtonTextStyle1 = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const kBottomFixedButtonTextStyle2 = TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
  color: Colors.blue,
);

const kAddSetPageRemoveButtonTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 16.0,
);

const kAddSetPageAddButtonTextStyle = TextStyle(
  color: Colors.blueAccent,
  fontSize: 16.0,
);
const kSetDataTextStyle = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const kSizedBoxBetweenItems = SizedBox(
  height: 24.0,
);

final kBorderRadius = BorderRadius.circular(20.0);

final Routine kErrorRoutine = Routine(
  name: '!###LOADING###!',
  days: [],
);
enum WorkoutState {
  onWorkoutList,
  onFront,
  onRoutine,
}

@HiveType(typeId: 3)
enum WorkoutType {
  @HiveField(0)
  none,
  @HiveField(1)
  durationWeight,
  @HiveField(2)
  setWeight,
}
