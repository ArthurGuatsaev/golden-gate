import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../car/import.dart';
import '../const/import.dart';
import '../valute/domain/bloc/valute_bloc.dart';
import '../widgets/pop/modal_choose_valute.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      buildWhen: (previous, current) => previous.car != current.car,
      builder: (context, state) {
        // final car = state.car[state.current];
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  left: 12,
                ),
                child: Text(
                  'My statistics',
                  style: thirtyFourStyte,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total balance',
                          style: twelthStyte,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '\$${state.rented + state.driverRented}',
                          style: twentyEightStyle,
                        )
                      ],
                    ),
                    const Spacer(),
                    BlocBuilder<ValuteBloc, ValuteState>(
                      buildWhen: (previous, current) =>
                          previous.valutePair != current.valutePair,
                      builder: (context, state) {
                        final valute = state.valutePair.isNotEmpty
                            ? state.valutePair.first.pairValute.toOneSymbol
                            : 'AUD';
                        return GestureDetector(
                          onTap: () {
                            showModalSheetChooseValute(
                              context: context,
                              index: 0,
                              updateVal: state.valutePair[0],
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/valute/$valute.png',
                                height: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                valute,
                                style: fifteenWhiteStyle,
                              ),
                              const SizedBox(width: 15),
                              Image.asset('assets/images/down.png'),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
                  decoration: const BoxDecoration(
                      color: bgSecondColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 30),
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: backgroundColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Rental income',
                                style: twelthStyte,
                              ),
                              Text(
                                '\$${state.driverRented}',
                                style: seventeenStyle,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 30),
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: backgroundColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Amount of cars',
                                style: twelthStyte,
                              ),
                              Text(
                                '${state.car.length}',
                                style: seventeenStyle,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: backgroundColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Spending on expenses',
                                style: twelthStyte,
                              ),
                              Text(
                                '\$${state.rented}',
                                style: seventeenStyle,
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
