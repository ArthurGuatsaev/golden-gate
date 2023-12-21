import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../car/import.dart';
import '../../nav_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../const/import.dart';
import '../text_field.dart';

Future showModalSheetAddTenant({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController dateController,
  required TextEditingController finishdateController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, bottom: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Center(child: Image.asset('assets/images/tire.png')),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      const Center(
                        child: Text('Add car', style: seventeenStyle),
                      ),
                      SaveButton(
                        nameController: nameController,
                        dateController: dateController,
                        finishdateController: finishdateController,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Name tenant',
                    style: fifteenStyle,
                  ),
                  const SizedBox(height: 10),
                  VTextField(
                    backgroundColor: Colors.transparent,
                    autofocus: true,
                    controller: nameController,
                    hint: 'Name',
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Date',
                    style: fifteenStyle,
                  ),
                  Row(
                    children: [
                      DateTextField(
                        controller: dateController,
                      ),
                      DateTextField(
                        last: false,
                        controller: finishdateController,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class DateTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool? last;
  const DateTextField({super.key, required this.controller, this.last});

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  @override
  void initState() {
    if (widget.controller.text.isNotEmpty) {
      day = widget.controller.text.substring(8, 10);
      month = widget.controller.text.substring(5, 7);
      year = widget.controller.text.substring(0, 4);
    }
    super.initState();
  }

  void imput() {
    setState(() {
      widget.controller.text = '$year-$month-$day';
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
            child: TextFormField(
              initialValue: day,
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
            child: TextFormField(
              initialValue: month,
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
            child: TextFormField(
              initialValue: year,
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
                year = value;
                imput();
                if (year.length > 3 && widget.last == null) {
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

class SaveButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController dateController;
  final TextEditingController finishdateController;

  const SaveButton({
    super.key,
    required this.nameController,
    required this.dateController,
    required this.finishdateController,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  void dispose() {
    widget.nameController.dispose();
    widget.dateController.dispose();
    widget.finishdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      builder: (context, state) {
        final car = state.car[state.current];
        return Align(
          alignment: Alignment.centerRight,
          child: CupertinoButton(
            child: const Text(
              'Save',
              style: sixteenPrimeStyle,
            ),
            onPressed: () {
              if (widget.nameController.text.isEmpty ||
                  widget.dateController.text.isEmpty ||
                  DateTime.tryParse(widget.dateController.text) == null ||
                  DateTime.tryParse(widget.finishdateController.text) == null) {
                return;
              }
              final ten = TenantModel()
                ..name = widget.nameController.text
                ..startDate = DateTime.tryParse(widget.dateController.text)
                ..finishDate =
                    DateTime.tryParse(widget.finishdateController.text);
              final tenants = car.tenants != null && car.tenants!.isNotEmpty
                  ? [...car.tenants!, ten]
                  : [ten];
              context
                  .read<CarBloc>()
                  .add(SaveNFTEvent(model: car.copyWith(tenants: tenants)));
              MyNavigatorManager.instance.carPop();
            },
          ),
        );
      },
    );
  }
}
