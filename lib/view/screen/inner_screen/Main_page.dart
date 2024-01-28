import 'dart:io';

import 'package:My_Note/core/image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/cubit.dart';
import '../../../core/color.dart';
import '../../widget/text_form_field.dart';


class Main extends StatelessWidget {
   Main({Key? key}) : super(key: key);
  GlobalKey bottom = GlobalKey();

  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKeyTitle = GlobalKey<FormState>();

  final TextEditingController _timeController = TextEditingController();
  final GlobalKey<FormState> _formKeyTime = GlobalKey<FormState>();

  File? myFile;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit c = AppCubit.get(context);
          return Scaffold(
            key: c.globalKey,
            backgroundColor: AppColors.c2,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: c.appbarIcons[c.currentIndex],
              title: Text(
                c.title[c.currentIndex],
                style: TextStyle(color: Colors.black,fontSize: width/18),
              ),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              key: bottom,
              index: 0,
              height: 60.0,
              items: const [
                Icon(
                  Icons.note_alt_sharp,
                  size: 30,
                ),
                Icon(
                  Icons.download_done_sharp,
                  size: 30,
                ),
                Icon(
                  Icons.delete_forever,
                  size: 30,
                ),
              ],
              color: Colors.black.withOpacity(.1),
              buttonBackgroundColor: Colors.white,
              backgroundColor: AppColors.c1,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 500),
              onTap: (val) {
                c.getCurrentIndex(val);
              },
            ),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButton: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              mini: true,
              backgroundColor: Colors.lightBlue.withOpacity(.8),
              splashColor: Colors.transparent,
              child: const Icon(Icons.edit,color: Colors.black,),
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 350,
                        decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(.88),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 15, 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: TextFormFieldUtl(
                                  controller: _titleController,
                                  formKey: _formKeyTitle,
                                  onTapOutside: (event) => FocusManager
                                      .instance.primaryFocus
                                      ?.unfocus(),
                                  title: "Task Title",
                                  prefixIcon:
                                  Icon(
                                    Icons.turned_in_not_rounded,
                                    color: Colors.red,
                                    size: 25,
                                  ),
                                  message:  "     Title can't be empty!",
                                  onTap: () {},
                                  onEditingComplete: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    if (_formKeyTime.currentState!
                                        .validate() &&
                                        _formKeyTitle.currentState!
                                            .validate()) {
                                      c.insertToDatabase(
                                        title: _titleController.text,
                                        time: _timeController.text,
                                        image: myFile != null
                                            ? myFile!.path
                                            : "null",
                                      );
                                      myFile = null;
                                      _titleController.text = "";
                                      _timeController.text = "";
                                      Navigator.of(context).pop();
                                    } else if (_formKeyTitle.currentState!
                                        .validate()) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    }
                                  },
                                ),
                              ),
                              TextFormFieldUtl(
                                controller: _timeController,
                                formKey: _formKeyTime,
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                readonly: true,
                                title: "Time Title",
                                prefixIcon:
                                    Icon(Icons.watch, color: Colors.red),
                                message: "     Time can't be empty!",
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if(value != null){
                                      _timeController.text = value.format(context).toString();
                                    }
                                    if (_formKeyTime.currentState!.validate() &&
                                        _formKeyTitle.currentState!
                                            .validate()) {
                                      c.insertToDatabase(
                                        title: _titleController.text,
                                        time: _timeController.text,
                                        image: myFile != null
                                            ? myFile!.path
                                            : "null",
                                      );
                                      myFile = null;
                                      _titleController.text = "";
                                      _timeController.text = "";
                                      Navigator.of(context).pop();
                                    }
                                  });
                                }, onEditingComplete: () {  },
                              ),
                              Spacer(
                                flex: 5,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    ImagePicker imagePicker = ImagePicker();
                                    XFile? file = await imagePicker.pickImage(
                                        source: ImageSource.gallery);
                                    myFile = File(file!.path);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor: AppColors.c1,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 40),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 90, vertical: 2),
                                    child: Text(
                                      "Add Image",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                      );
                    }).whenComplete(() {
                  if (_formKeyTime.currentState!.validate() &&
                      _formKeyTitle.currentState!.validate()) {
                    c.insertToDatabase(
                      title: _titleController.text,
                      time: _timeController.text,
                      image: myFile != null ? myFile!.path : "null",
                    );
                    myFile = null;
                    _titleController.text = "";
                    _timeController.text = "";
                  }
                });
              },
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
            drawer: Container(
                  height: height / 3,
                  width: width / 1.6,
                  child: c.image != "null"
                      ? Image.file(
                    File(c.image ?? ""),
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  )
                      : Image.asset(AppImage.image),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            drawerEnableOpenDragGesture: false,
            drawerScrimColor: Colors.transparent.withOpacity(.15),
            body: c.pages[c.currentIndex],
          );
        },
      ),
    );
  }
}
