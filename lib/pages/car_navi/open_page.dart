import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_gate/nav_manager.dart';
import 'package:golden_gate/notes/view/bloc/note_bloc.dart';
import 'package:golden_gate/widgets/calc_button.dart';
import '../../home/import.dart';

import '../../const/import.dart';
import '../../car/import.dart';
import '../../widgets/pop/modal_car_edit.dart';
import '../../widgets/pop/modal_expenses_add.dart';
import '../../widgets/pop/modal_notes.dart';
import '../../widgets/pop/modal_tenant_add.dart';

class CapOpenPage extends StatelessWidget {
  static const String routeName = '/car';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const CapOpenPage());
  }

  const CapOpenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      buildWhen: (previous, current) => previous.car != current.car,
      builder: (context, state) {
        if (state.current >= state.car.length) {
          return const SizedBox();
        }
        final car = state.car[state.current];
        return Scaffold(
          appBar: AppBar(
              leadingWidth: 80,
              leading: GestureDetector(
                onTap: () => MyNavigatorManager.instance.carPop(),
                child: const Row(children: [
                  Icon(Icons.navigate_before, color: primary, size: 30),
                  Text(
                    'Back',
                    style: seventeenPrimeStyle,
                  )
                ]),
              ),
              centerTitle: true,
              title: Text(
                car.name!.toFirstLetter,
                style: seventeenStyle,
              )),
          body: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                previous.lessonsIndex != current.lessonsIndex,
            builder: (context, homeState) {
              final index = homeState.lessonsIndex;
              return Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, bottom: 40),
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          AspectRatio(aspectRatio: 362 / 301, child: CarOpen()),
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 30,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 28,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context
                                    .read<HomeBloc>()
                                    .add(const ChangeLessonsIndex(index: 0)),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  decoration: BoxDecoration(
                                    color: index != 0
                                        ? Colors.white.withOpacity(0.06)
                                        : primary,
                                    borderRadius: index != 0
                                        ? BorderRadius.zero
                                        : BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Current info',
                                    style: thirdteenStyle,
                                  )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context
                                    .read<HomeBloc>()
                                    .add(const ChangeLessonsIndex(index: 1)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: index != 1
                                        ? Colors.white.withOpacity(0.06)
                                        : primary,
                                    borderRadius: index != 1
                                        ? BorderRadius.zero
                                        : BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'Expenses',
                                    style: thirdteenStyle,
                                  )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => context
                                    .read<HomeBloc>()
                                    .add(const ChangeLessonsIndex(index: 2)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: index != 2
                                        ? Colors.white.withOpacity(0.06)
                                        : primary,
                                    borderRadius: index != 2
                                        ? BorderRadius.zero
                                        : BorderRadius.circular(8),
                                  ),
                                  child: const Center(
                                      child: Text(
                                    'History',
                                    style: thirdteenStyle,
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: IndexedStack(
                      index: index,
                      children: [
                        CurrentInfo(car: car),
                        Expenses(
                          carModel: car,
                        ),
                        const HistoryTonent(),
                      ],
                    )),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class HistoryTonent extends StatelessWidget {
  const HistoryTonent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      buildWhen: (previous, current) => previous.car != current.car,
      builder: (context, state) {
        final car = state.car[state.current];
        return Column(
          children: [
            const SizedBox(height: 15),
            Column(
              children: List.generate(car.tenants?.length ?? 0, (index) {
                final ton = car.tenants![(car.tenants!.length - 1) - index];
                return Container(
                  height: 44,
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(children: [
                    Expanded(
                        child: Text(ton.name!,
                            style: car.status == 'Rented' && index == 0
                                ? seventeenStyle
                                : seventeenGreyStyle)),
                    Text(
                      '${ton.startDate!.dateString} - ${ton.finishDate!.dateString}',
                      style: car.status == 'Rented' && index == 0
                          ? seventeenPrimeStyle
                          : seventeenGreyStyle,
                    )
                  ]),
                );
              }),
            )
          ],
        );
      },
    );
  }
}

class Expenses extends StatelessWidget {
  final CarModel carModel;
  const Expenses({super.key, required this.carModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Column(
          children: List.generate(
            carModel.expenses?.length ?? 0,
            (index) {
              final exp = carModel.expenses![index];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(exp.name!, style: seventeenStyle),
                        Text(exp.date!.dateString, style: fifteenStyle),
                      ],
                    )),
                    Text(
                      '${exp.price!}',
                      style: TextStyle(
                        fontSize: 15,
                        color: exp.price! >= 0 ? Colors.green : Colors.red,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        CalcButton(
          text: 'Add',
          gradic: gradientButton,
          function: () => showModalSheetExpensesAdd(
              context: context,
              nameController: TextEditingController(),
              priceController: TextEditingController()),
        ),
      ],
    );
  }
}

class CurrentInfo extends StatelessWidget {
  const CurrentInfo({
    super.key,
    required this.car,
  });

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 56,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: textColor))),
        child: Row(children: [
          const Expanded(
            child: Text(
              'Current price',
              style: thirdteenStyle,
            ),
          ),
          Text(
            '\$${car.price!}',
            style: thirdteenStyle,
          ),
        ]),
      ),
      Container(
        height: 56,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: textColor))),
        child: Row(children: [
          const Expanded(
            child: Text(
              'Your tenant',
              style: thirdteenStyle,
            ),
          ),
          Text(
            car.status == 'No rented' ? 'Nobody' : car.tenants!.last.name!,
            style: thirdteenStyle,
          ),
        ]),
      ),
      car.status == 'No rented'
          ? SizedBox.shrink()
          : Container(
              height: 56,
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: textColor))),
              child: Row(children: [
                const Expanded(
                  child: Text(
                    'Dates',
                    style: thirdteenStyle,
                  ),
                ),
                Text(
                  car.tenants!.last.date,
                  style: thirdteenStyle,
                ),
              ]),
            ),
      const SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              context.read<NoteBloc>().add(ChangeCurrentIdEvent(id: car.id!));
              showModalSheetNotes(
                  car: car,
                  context: context,
                  nameController: TextEditingController());
            },
            child: Row(children: [
              Image.asset('assets/images/note.png'),
              const SizedBox(width: 15),
              const Text('Notes', style: seventeenStyle),
              const Spacer(),
              const Icon(
                Icons.navigate_next,
                color: Colors.white,
                size: 35,
              ),
            ]),
          ),
        ),
      ),
      SizedBox(height: 25),
      car.status == 'No rented'
          ? CalcButton(
              text: 'Add tenant',
              gradic: gradientButton,
              function: () => showModalSheetAddTenant(
                  context: context,
                  dateController: TextEditingController(),
                  finishdateController: TextEditingController(),
                  nameController: TextEditingController()),
            )
          : CalcButton(
              text: 'Edit',
              gradic: gradientButton,
              function: () {
                context
                    .read<CarBloc>()
                    .add(ChangeStateImageEvent(file: car.productImage));
                return showModalSheetCarEdit(
                    context: context,
                    dateController: TextEditingController(),
                    finishDatetController: TextEditingController(),
                    priceController: TextEditingController(),
                    tenantController: TextEditingController(),
                    nameController: TextEditingController());
              },
            ),
    ]);
  }
}
