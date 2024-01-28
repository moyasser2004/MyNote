import 'dart:io';

import 'package:My_Note/core/image.dart';
import 'package:My_Note/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/page.dart';

class Task extends StatelessWidget {
  const Task({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit c = AppCubit.get(context);
          return PageUtl(
            itemCount: c.taskListNew.length,
            height: height,
            width:  width,
            taskList: c.taskListNew,
            firstIcon: const Icon(Icons.done),
            text1:  "  My  ",
            text2:  " Tasks ",
            buttonTwo: true,
            flex1: 3,
            flex2: 5,
            flex3: 1,
            flex4: 2,
            selected2: 'task',
            splashColor: Colors.blue,
          );
        });
  }
}
