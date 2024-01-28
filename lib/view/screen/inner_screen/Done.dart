import 'dart:io';

import 'package:My_Note/core/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/cubit.dart';
import '../../widget/page.dart';


class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit c = AppCubit.get(context);
          return PageUtl(
            itemCount: c.taskListDone.length,
            height: height,
            width:  width,
            taskList: c.taskListDone,
            firstIcon: Padding(
              padding: EdgeInsets.only(right: 7),
              child: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
            ),
            text1:  "  My  ",
            text2:  " Done ",
            buttonTwo: false,
            flex1: 2,
            flex2: 4,
            flex3: 1,
            flex4: 0,
            selected2: 'done',
            splashColor: Colors.red.shade300,
          );
        });
  }
}
