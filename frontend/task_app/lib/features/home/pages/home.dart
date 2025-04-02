import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/features/home/cubit/home_cubit.dart';
import 'package:task_app/features/home/pages/add_new_task.dart';
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
                icon: const Icon(CupertinoIcons.add)),
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
            }
            return Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    //date selector
                    DateSelector(),

                    //Task cards
                    Row(
                      children: [
                        //The task card
                        Expanded(
                            child: TaskCard(
                                cardColor:
                                    const Color.fromRGBO(246, 222, 194, 1),
                                headerText: "Hello ",
                                descriptionText:
                                    "Develop a user authentication system that includes registration, login, and password recovery functionalities. The system should be secure, scalable, and user-friendly.")),

                        //Circle
                        Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: strenghtenColor(
                                    Color.fromRGBO(246, 222, 194, 1), 0.69))),

                        //Due date
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child:
                              Text("10:00 AM ", style: TextStyle(fontSize: 17)),
                        )
                      ],
                    ),
                  ],
                ));
          },
        ));
  }
}
