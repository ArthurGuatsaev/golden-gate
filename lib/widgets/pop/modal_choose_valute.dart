import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../const/import.dart';
import '../../nav_manager.dart';
import '../../valute/domain/bloc/valute_bloc.dart';
import '../../widgets/pop/modal_valute_chart.dart';

Future showModalSheetChooseValute(
    {required BuildContext context,
    int? index,
    ValuteViewModel? updateVal}) async {
  context.read<ValuteBloc>().add(GetAllValutePriceEvent());
  return showCupertinoModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: backgroundColor),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 5, right: 5, bottom: 12),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () => MyNavigatorManager.instance.simulatorPop(),
                      child: const Row(
                        children: [
                          Icon(Icons.navigate_before,
                              color: Colors.white, size: 30),
                          SizedBox(
                            width: 0,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Currencies',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<ValuteBloc, ValuteState>(
                buildWhen: (previous, current) =>
                    previous.allValutePair != current.allValutePair,
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.allValutePair.length,
                    itemBuilder: (context, ind) {
                      if (state.allValutePair.isEmpty) {
                        return CircularProgressIndicator(
                          color: Colors.white.withOpacity(0.7),
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 75,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: bgSecondColor),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showModalSheetChart(
                                  context: context,
                                  index: ind,
                                  updateVal: updateVal,
                                  newVal: state.allValutePair[ind]);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/valute/${valutePairList[ind].toSymbol}.png',
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                    child: Text(
                                  valutePairList[ind],
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.allValutePair[ind].price}',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${state.allValutePair[ind].changePrice < 0 ? '' : '+'}${state.allValutePair[ind].changePrice.toStringAsFixed(3)}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: state.allValutePair[ind]
                                                    .changePrice <
                                                0
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
