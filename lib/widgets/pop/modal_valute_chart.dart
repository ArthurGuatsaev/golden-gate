import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_gate/const/import.dart';
import 'package:golden_gate/nav_manager.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../valute/domain/bloc/valute_bloc.dart';

Future showModalSheetChart(
    {required BuildContext context,
    required int index,
    ValuteViewModel? updateVal,
    ValuteViewModel? newVal}) async {
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: BlocBuilder<ValuteBloc, ValuteState>(
                buildWhen: (previous, current) =>
                    previous.allValutePair[index].pairValute !=
                    current.allValutePair[index].pairValute,
                builder: (context, state) {
                  final pair = state.allValutePair[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(child: Image.asset('assets/images/tire.png')),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                MyNavigatorManager.instance.simulatorPop();
                              },
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.navigate_before,
                                    color: primary,
                                    size: 30,
                                  ),
                                  Text(
                                    'Back',
                                    style: seventeenPrimeStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              pair.pairValute,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: CupertinoButton(
                                  child: const Text(
                                    'Select',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        color: primary),
                                  ),
                                  onPressed: () {
                                    context.read<ValuteBloc>().add(
                                          UpdateAndSaveValutePairEvent(
                                            pair: updateVal!,
                                            newPair: newVal!,
                                            index: 0,
                                          ),
                                        );

                                    MyNavigatorManager.instance.untilPop();
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Image.asset(
                    'assets/images/valute/chart.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
