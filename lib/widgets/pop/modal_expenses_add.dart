import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../car/import.dart';
import '../../nav_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../const/import.dart';
import '../text_field.dart';

Future showModalSheetExpensesAdd({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController priceController,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Center(
                          child: Text('Add expenses', style: seventeenStyle),
                        ),
                        SaveButton(
                          nameController: nameController,
                          priceController: priceController,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Name',
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
                    'Price',
                    style: fifteenStyle,
                  ),
                  const SizedBox(height: 10),
                  VTextField(
                    backgroundColor: Colors.transparent,
                    autofocus: true,
                    controller: priceController,
                    hint: '-100\$',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class SaveButton extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  const SaveButton({
    super.key,
    required this.nameController,
    required this.priceController,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  void dispose() {
    widget.nameController.dispose();
    widget.priceController.dispose();
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
                  widget.priceController.text.isEmpty) {
                return;
              }
              final exp = ExpensesModel()
                ..date = DateTime.now()
                ..name = widget.nameController.text
                ..price = double.tryParse(widget.priceController.text) ?? 0;
              final expenses = car.expenses == null || car.expenses!.isEmpty
                  ? <ExpensesModel>[]
                  : [...car.expenses!]
                ..add(exp);
              context
                  .read<CarBloc>()
                  .add(SaveNFTEvent(model: car.copyWith(expenses: expenses)));
              MyNavigatorManager.instance.carPop();
            },
          ),
        );
      },
    );
  }
}
