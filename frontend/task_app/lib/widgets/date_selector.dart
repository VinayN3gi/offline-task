import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:task_app/features/utils/generateWeekDay.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int weekOffset = 0;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final weekDates = generateWeekDates(weekOffset);
    String monthName = DateFormat("MMMM").format(weekDates.first);
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Back button
              IconButton(
                  onPressed: () => {
                        setState(() {
                          weekOffset--;
                        })
                      },
                  icon: const Icon(Icons.arrow_back_ios)),

              Text(monthName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

              //Front button
              IconButton(
                  onPressed: () => {
                        setState(() {
                          weekOffset++;
                        })
                      },
                  icon: const Icon(Icons.arrow_forward_ios)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 80,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weekDates.length,
                itemBuilder: (context, index) {
                  final date = weekDates[index];
                  bool isSelected = DateFormat('d').format(selectedDate) ==
                          DateFormat('d').format(date) &&
                      selectedDate.month == date.month &&
                      selectedDate.year == selectedDate.year;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = date;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.deepOrangeAccent
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: isSelected
                                    ? Colors.deepOrangeAccent
                                    : Colors.grey.shade300,
                                width: 2)),
                        width: 70,
                        margin: EdgeInsets.only(right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(DateFormat("d").format(date),
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black)),
                            SizedBox(height: 5),
                            Text(DateFormat("E").format(date),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black))
                          ],
                        )),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
