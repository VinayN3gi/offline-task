import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:task_app/features/home/cubit/home_cubit.dart';
import 'package:task_app/features/home/pages/add_new_task.dart';
import 'package:task_app/features/utils/hexToString.dart';
import 'package:task_app/features/utils/strenghten_color.dart';
import 'package:task_app/widgets/date_selector.dart';
import 'package:task_app/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(builder: (context) => const HomePage());
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'My Tasks',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, AddNewTaskPage.route());
            },
            icon: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeError) {
            return Center(child: Text(state.error));
          } else if (state is HomeGetTask) {
            final tasks = state.tasks;
            return Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  DateSelector(),

                  // Task list
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final currTask = tasks[index];
                        return Row(
                          children: [
                            // Task card
                            Expanded(
                              child: TaskCard(
                                cardColor: hexTorgb(currTask.hexColor),
                                headerText: currTask.title,
                                descriptionText: currTask.description,
                              ),
                            ),

                            // Circle indicator
                            Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: strenghtenColor(
                                  const Color.fromRGBO(246, 222, 194, 1),
                                  0.69,
                                ),
                              ),
                            ),

                            // Due date
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                DateFormat("MM-d-y").format(currTask.dueAt),
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          // ✅ Default return widget to avoid errors
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
