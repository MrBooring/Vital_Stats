import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalenderController extends GetxController {
  var seletedDateindex = (DateTime.now().day - 1).obs;
  DateTime selectedDate = DateTime.now().copyWith(day: DateTime.now().day);

  var today = DateTime.now();

  List<int> dates = [];
  List<String> days = [];

  void onInit() {
    super.onInit();
    gettingcalender(DateTime.now().year, DateTime.now().month);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => scrollToIndex(
        int.parse(
          seletedDateindex.value.toString(),
        ),
      ),
    );
    onDateChanged(DateTime.now().day - 1);
  }

  onDateChanged(index) {
    seletedDateindex.value = index;
    //date changed
    selectedDate = DateTime.now().copyWith(day: seletedDateindex.value + 1);
  }

  ItemScrollController itemcontroller = ItemScrollController();
  ItemPositionsListener itemlistner = ItemPositionsListener.create();

  Future scrollToItem(index) async {
    itemcontroller.scrollTo(
        index: index,
        alignment: 0.31,
        duration: const Duration(milliseconds: 300));
  }

  Future scrollToIndex(int index, {bool isAnimating = false}) async {
    if (isAnimating) {
      await itemcontroller.scrollTo(
        index: index,
        alignment: 0.31,
        duration: const Duration(milliseconds: 300),
      );
    } else {
      itemcontroller.scrollTo(
        index: index,
        alignment: 0.31,
        duration: const Duration(milliseconds: 800),
      );
    }
  }

  // dates

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  gettingcalender(int year, int month) {
    // var daysinmonth = DateTime(year, month + 1, 0).day;

    int daysInMonth = getDaysInMonth(year, month);
    for (int i = 1; i <= daysInMonth; i++) {
      dates.add(i);

      days.add(getDayOfWeek(year, month, i));
    }
  }

  //days

  String getDayOfWeek(int year, int month, int day) {
    DateTime date = DateTime(year, month, day);
    return date.weekday == 7
        ? 'Sunday'
        : date.weekday == 1
            ? 'Monday'
            : date.weekday == 2
                ? 'Tuesday'
                : date.weekday == 3
                    ? 'Wednesday'
                    : date.weekday == 4
                        ? 'Thursday'
                        : date.weekday == 5
                            ? 'Friday'
                            : date.weekday == 6
                                ? 'Saturday'
                                : '';
  }
}
