import 'package:flutter/material.dart';
import 'package:hr_app/data/constants.dart';
import 'package:hr_app/widgets/routine.dart';
import 'package:hr_app/provider/routine_provider.dart';

import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

import '../../models/routine_model.dart';

class RoutineListPage extends StatefulWidget {
  @override
  _RoutineListPageState createState() => _RoutineListPageState();
}

class _RoutineListPageState extends State<RoutineListPage> {
  ScrollController _scrollController;
  bool isRoutine = false;

  init() {
    setState(() {
      _scrollController.dispose();
      _scrollController = ScrollController();
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //전역 루틴 리스트 가져옴
    List<RoutineModel> _routineList =
        Provider.of<RoutineProvider>(context).routineModels;

    if (_routineList.isNotEmpty) isRoutine = true;
    setState(() {});

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Material(
      child: Padding(
        padding: kPagePadding,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('루틴 리스트', style: kPageTitleStyle),
                  ],
                ),
                kSizedBoxBetweenItems,
                isRoutine
                    ? Expanded(
                        child: ReorderableColumn(
                          scrollController: _scrollController,
                          enabled: true,
                          onReorder: Provider.of<RoutineProvider>(context,
                                  listen: false)
                              .reorder,
                          draggingWidgetOpacity: 0,
                          onNoReorder: (int index) {
                            //this callback is optional
                            debugPrint(
                                '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                          },
                          children: Provider.of<RoutineProvider>(context,
                                  listen: true)
                              .routineModels
                              .map((_routine) {
                            return Container(
                              key: UniqueKey(),
                              child: Routine(
                                autoKey: _routine.key,
                                name: _routine.name,
                                color: Color(_routine.color),
                                type: RoutineType.onList,
                                days: _routine.days,
                                workoutModelList: _routine.workoutModelList,
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    : Expanded(
                        flex: 2, child: Center(child: Text('루틴을 추가해주세요.'))),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 30.0,
                  ),
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, 'Routine_input_page')
                        .then((value) => init());
                  },
                ),
                kSizedBoxBetweenItems,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
