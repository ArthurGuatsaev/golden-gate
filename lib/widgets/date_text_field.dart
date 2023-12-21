import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/import.dart';

class DateTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool? last;
  const DateTextField({super.key, required this.controller, this.last});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  void imput() {
    setState(() {
      widget.controller.text = '$year.$month.$day';
    });
  }

  String day = '';
  String month = '';
  String year = '';
  FocusNode focusDay = FocusNode();
  FocusNode focusMonth = FocusNode();
  FocusNode focusYear = FocusNode();
  @override
  Widget build(BuildContext context) {
    const width = 20.0;
    const height = 45.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
            width: width,
            height: height,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
              ],
              focusNode: focusDay,
              textAlignVertical: TextAlignVertical.bottom,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              showCursor: false,
              style: const TextStyle(fontSize: 13, color: Colors.white),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary)),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: textColor,
                    ),
                  )),
              onChanged: (value) {
                day = value;
                imput();
                if (day.length > 1) {
                  focusDay.nextFocus();
                }
              },
            )),
        const Text(
          '.',
          style: TextStyle(color: textColor),
        ),
        SizedBox(
            width: width,
            height: height,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(2),
              ],
              textAlignVertical: TextAlignVertical.bottom,
              focusNode: focusMonth,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              showCursor: false,
              style: const TextStyle(fontSize: 13, color: Colors.white),
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary)),
                  contentPadding: EdgeInsets.only(bottom: 10),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor))),
              onChanged: (value) {
                month = value;
                imput();
                if (month.length > 1) {
                  focusMonth.nextFocus();
                }
              },
            )),
        const Text(
          '.',
          style: TextStyle(color: textColor),
        ),
        SizedBox(
            width: width * 2,
            height: height,
            child: TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
              ],
              textAlignVertical: TextAlignVertical.bottom,
              focusNode: focusYear,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              showCursor: false,
              style: const TextStyle(fontSize: 13, color: Colors.white),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 10),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary)),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor))),
              onChanged: (value) {
                day = value;
                imput();
                if (day.length > 3 && widget.last != null) {
                  focusYear.nextFocus();
                }
              },
            )),
        widget.last != null
            ? const SizedBox.shrink()
            : const Text(
                ' - ',
                style: TextStyle(color: Colors.white),
              ),
      ],
    );
  }
}
