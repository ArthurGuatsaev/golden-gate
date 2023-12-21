import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_gate/widgets/pop/modal_tenant_add.dart';
import '../../car/import.dart';
import '../../nav_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../const/import.dart';
import '../text_field.dart';

Future showModalSheetCarEdit({
  required BuildContext context,
  required TextEditingController nameController,
  required TextEditingController priceController,
  required TextEditingController tenantController,
  required TextEditingController dateController,
  required TextEditingController finishDatetController,
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
              child: BlocBuilder<CarBloc, CarState>(
                buildWhen: (previous, current) => previous.car != current.car,
                builder: (context, state) {
                  if (state.current >= state.car.length) {
                    return const SizedBox();
                  }
                  final car = state.car[state.current];
                  nameController.text = car.name!;
                  priceController.text = '${car.price!}';
                  tenantController.text = car.tenants!.last.name!;
                  dateController.text = car.tenants!.last.startDate!.toString();
                  finishDatetController.text =
                      car.tenants!.last.finishDate!.toString();
                  return Column(
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
                              child: Text('Edit', style: seventeenStyle),
                            ),
                            SaveButton(
                              nameController: nameController,
                              priceController: priceController,
                              dateController: dateController,
                              finishdateController: finishDatetController,
                              tenantController: tenantController,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                      const ImageAdd(),
                      const SizedBox(height: 40),
                      const Text(
                        'Car',
                        style: fifteenStyle,
                      ),
                      VTextField(
                        backgroundColor: Colors.transparent,
                        autofocus: true,
                        controller: nameController,
                        hint: 'Name',
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Current price',
                        style: fifteenStyle,
                      ),
                      VTextField(
                        backgroundColor: Colors.transparent,
                        autofocus: true,
                        controller: priceController,
                        hint: '100\$',
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Tenant',
                        style: fifteenStyle,
                      ),
                      VTextField(
                        backgroundColor: Colors.transparent,
                        autofocus: true,
                        controller: priceController,
                        hint: 'Name',
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Dates',
                        style: fifteenStyle,
                      ),
                      Row(
                        children: [
                          DateTextField(controller: dateController),
                          DateTextField(
                            controller: finishDatetController,
                            last: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CupertinoButton(
                          child: const Text(
                            'Delete car',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            context
                                .read<CarBloc>()
                                .add(RemoveNFTEvent(model: car));
                            MyNavigatorManager.instance.carPopUntil('/collect');
                          })
                    ],
                  );
                },
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
  final TextEditingController tenantController;
  final TextEditingController dateController;
  final TextEditingController finishdateController;
  const SaveButton({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.dateController,
    required this.finishdateController,
    required this.tenantController,
  });

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  void dispose() {
    widget.nameController.dispose();
    widget.priceController.dispose();
    widget.dateController.dispose();
    widget.finishdateController.dispose();
    widget.tenantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      builder: (context, state) {
        final old = state.car[state.current];
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
                  widget.tenantController.text.isEmpty ||
                  widget.dateController.text.isEmpty ||
                  widget.finishdateController.text.isEmpty ||
                  DateTime.tryParse(widget.dateController.text) == null ||
                  DateTime.tryParse(widget.finishdateController.text) == null ||
                  state.image == null) {
                return;
              }
              final ternan = TenantModel()
                ..name = widget.tenantController.text
                ..startDate = DateTime.tryParse(widget.dateController.text)
                ..finishDate =
                    DateTime.tryParse(widget.finishdateController.text);
              final ter = [...old.tenants!]
                ..removeLast()
                ..add(ternan);

              final car = CarModel(
                  id: old.id,
                  isFavorite: false,
                  myId: old.myId,
                  name: widget.nameController.text,
                  tenants: ter,
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
