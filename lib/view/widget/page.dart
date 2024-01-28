import 'dart:io';

import 'package:My_Note/controller/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/image.dart';
import 'dialoge.dart';

class PageUtl extends StatelessWidget {
  const PageUtl({
    required this.itemCount,
    required this.height,
    required this.width,
    required this.taskList,
    required this.firstIcon,
    this.buttonTwo = false,
    required this.text1,
    required this.text2,
    required this.flex1,
    required this.flex2,
    required this.flex3,
    required this.flex4,
    required this.selected2,
    required this.splashColor
  });

  final int itemCount;
  final double height;
  final double width;
  final List<Map<String, dynamic>> taskList;
  final Widget firstIcon;
  final bool buttonTwo;
  final String text1;
  final String text2;
  final int flex1;
  final int flex2;
  final int flex3;
  final int flex4;
  final String selected2;
  final Color splashColor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit c = AppCubit.get(context);
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  text1,
                  style: TextStyle(fontSize: 40, color: Colors.black),
                )),
                Center(
                    child: Text(
                  text2,
                  style: TextStyle(fontSize: 35, color: Colors.black),
                )),
              ],
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: itemCount,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              itemBuilder: (context, i) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                    child: Container(
                      height: height / 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              flex: flex1,
                              child: InkWell(
                                  onTap: () {
                                    c.getData(
                                        image: taskList[i]["image"],
                                      );
                                  },
                                  child:Stack(
                                    children: [
                                      Container(
                                        height: height / 7.5,
                                        width: width / 4.5,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        margin: EdgeInsets.fromLTRB(7, 7, 7, 13),
                                        child: taskList[i]["image"] != "null"
                                            ? Image.file(
                                          File(taskList[i]["image"]),
                                          fit: BoxFit.fill,
                                          filterQuality: FilterQuality.high,
                                        )
                                            : Image.asset(AppImage.image),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          "  ${taskList[i]['time']}    ",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.red.shade700,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                              )
                          ),
                          Expanded(
                            flex: flex2,
                            child: Text(
                              " ${taskList[i]['title']}",
                              style: const TextStyle(
                                height: 1.5,
                                fontSize: 15,
                              ),
                              maxLines: 4,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Expanded(
                              flex: flex3,
                              child: Padding(
                                padding: !buttonTwo? const EdgeInsets.symmetric(horizontal: 6): EdgeInsets.zero,
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                      splashColor: splashColor,
                                      splashRadius: 17,
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                          if (selected2 == "task") {
                                            c.updateData(
                                                status: 'done',
                                                id: taskList[i]['id']);
                                          }
                                          else if (selected2 == "done")
                                          {
                                            c.updateData(
                                                status: 'remove',
                                                id: c.taskListDone[i]['id']);
                                          } else {
                                            showDialog(
                                                context: context,
                                                barrierColor:  Colors.transparent.withOpacity(.2),
                                                builder: (BuildContext context) {
                                                  return DialogUtl(
                                                    onPressed: () {
                                                      c.deleteData(
                                                          id: c.taskListRemove[i]["id"]);
                                                      Navigator.of(context).maybePop();
                                                    },
                                                  );
                                                });
                                          }
                                      },
                                      icon: firstIcon
                                  ),
                                )
                              )
                          ),
                          buttonTwo
                              ? Expanded(
                            flex: flex4,
                            child:  Material(
                              color: Colors.transparent,
                              child: IconButton(
                                splashColor: Colors.red.shade300,
                                splashRadius: 18,
                                color: Colors.red.shade400,
                                onPressed: () {
                                  c.updateData(
                                      status: 'archive',
                                      id: taskList[i]['id']);
                                },
                                icon: const Icon(Icons.delete_forever),
                              ),
                            )
                          )
                              : SizedBox.shrink()
                        ],
                      ),
                    ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
