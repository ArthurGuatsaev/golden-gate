import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/color.dart';

showSheetCustomEntity({
  required BuildContext context,
  required TextEditingController controller,
  required List<dynamic> list,
}) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return Material(
        child: Container(
          color: bgSecondColor,
          height: 400,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 12, top: 20, right: 12, bottom: 40),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Choose account',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                          pickerTextStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.5)))),
                  child: CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: 31,
                    scrollController: FixedExtentScrollController(
                      initialItem: 0,
                    ),
                    onSelectedItemChanged: (value) =>
                        controller.text = list[value],
                    children: List.generate(
                      list.length,
                      (index) => Center(
                        child: Text(list[index].name!),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      );
    },
  );
}
