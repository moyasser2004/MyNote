import 'package:flutter/material.dart';

import '../../core/color.dart';

class DialogUtl extends StatelessWidget {

  const DialogUtl({Key? key, required this.onPressed}) : super(key: key);
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    "Warning !",
                    style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade500,
                    ),
                  ),
                  const SizedBox(
                      height: 10),
                  const Text(
                    "Do you want to remove data ?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Divider(height: 0,color: AppColors.c1.withOpacity(.8),),
            Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceEvenly,
              children: [
                Expanded(
                  flex: 30,
                  child: TextButton(
                    onPressed: onPressed,
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 35,
                    width: 0,
                    color: AppColors.c1.withOpacity(.8),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color:
                        Colors.grey[500],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
