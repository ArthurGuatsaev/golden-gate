import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import '../car/import.dart';
import '../const/import.dart';
import '../widgets/pop/modal_table_calendar.dart';

class PaymantPage extends StatefulWidget {
  const PaymantPage({super.key});

  @override
  State<PaymantPage> createState() => _PaymantPageState();
}

class _PaymantPageState extends State<PaymantPage> {
  late ValueNotifier<DateTime> value;
  @override
  void initState() {
    value = ValueNotifier<DateTime>(DateTime(2023, 12, 1));
    value.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      buildWhen: (previous, current) => previous.car != current.car,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              GestureDetector(
                onTap: () {
                  showModalSheetDatePick(context: context, datePick: value);
                },
                child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/images/filter.png',
                      color: primary,
                    )),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Text(
                    'General payments',
                    style: thirtyFourStyte,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
                SliverToBoxAdapter(
                  child: Builder(
                    builder: (context) {
                      if (state.expMap.values.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: SizedBox(
                            height: 600,
                            child: SizedBox(
                              height: 270,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/car_empty.png'),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  const Text('Empty', style: twentyPrimeStyle),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
                SliverList.builder(
                  itemCount: value.value == DateTime(2023, 12, 1)
                      ? state.expMap.keys.length
                      : 1,
                  itemBuilder: (context, index) {
                    final date = value.value == DateTime(2023, 12, 1)
                        ? state.expMap.keys.toList()[index]
                        : '${value.value.month.monthString} ${value.value.day}';
                    final expList = state.expMap[date];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(date,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 10),
                        Column(
                          children: List.generate(
                            expList?.length ?? 0,
                            (index) {
                              final exp = expList![index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          exp.name!,
                                          style: seventeenStyle,
                                        ),
                                        Text(
                                          exp.date!.dateString,
                                          style: thirdteenGreyStyle,
                                        ),
                                      ],
                                    )),
                                    Text(
                                      '\$${exp.price!}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: exp.price! >= 0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
