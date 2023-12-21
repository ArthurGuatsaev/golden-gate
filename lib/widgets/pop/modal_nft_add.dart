import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../car/import.dart';
import '../../nav_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../const/import.dart';
import '../text_field.dart';

Future showModalSheetCarAdd({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController priceController,
}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
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
                          child: Text('Add car', style: seventeenStyle),
                        ),
                        SaveButton(
                          nameController: nameController,
                          priceController: priceController,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  const ImageAdd(),
                  const SizedBox(height: 80),
                  const Text(
                    'Car',
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
                    'Current price',
                    style: fifteenStyle,
                  ),
                  const SizedBox(height: 10),
                  VTextField(
                    backgroundColor: Colors.transparent,
                    autofocus: true,
                    controller: priceController,
                    hint: '100\$',
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
        return Align(
          alignment: Alignment.centerRight,
          child: CupertinoButton(
            child: const Text(
              'Save',
              style: sixteenPrimeStyle,
            ),
            onPressed: () {
              if (widget.nameController.text.isEmpty ||
                  widget.priceController.text.isEmpty ||
                  state.image == null) {
                return;
              }
              final car = CarModel(
                  isFavorite: false,
                  myId: DateTime.now().microsecond,
                  name: widget.nameController.text,
                  price: double.tryParse(widget.priceController.text) ?? 0);
              context.read<CarBloc>().add(SaveNFTEvent(model: car));
              MyNavigatorManager.instance.carPop();
            },
          ),
        );
      },
    );
  }
}

class ImageAdd extends StatefulWidget {
  const ImageAdd({
    super.key,
  });

  @override
  State<ImageAdd> createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd> {
  late CarBloc carBloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    carBloc = context.read<CarBloc>();
  }

  @override
  void dispose() {
    carBloc.add(CancelImageEvent());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            context.read<CarBloc>().add(ChooseNFTEvent());
          },
          child: CircleAvatar(
            radius: 51,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: BlocBuilder<CarBloc, CarState>(
              builder: (context, state) {
                return CircleAvatar(
                  backgroundColor: backgroundColor,
                  backgroundImage: state.image == null
                      ? null
                      : Image.file(File(state.image!.path)).image,
                  radius: 50,
                  child: Stack(
                    children: [
                      Center(
                          child: state.image != null
                              ? const SizedBox.shrink()
                              : Image.asset('assets/images/car.png')),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset('assets/images/plus.png'),
                      )
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
