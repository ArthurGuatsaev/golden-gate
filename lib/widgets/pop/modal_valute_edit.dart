// import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:quotex291/const/color.dart';
// import 'package:quotex291/pages/trading_valute.dart';
// import 'package:quotex291/product/domain/bloc/prod_bloc.dart';
// import 'package:quotex291/widgets/calc_button.dart';
// import 'package:quotex291/widgets/pop/modal_choose_valute.dart';

// Future showModalSheetValuteEdit(BuildContext context) async {
//   return showCupertinoModalBottomSheet(
//     context: context,
//     builder: (context) => SizedBox(
//       height: MediaQuery.of(context).size.height * 0.9,
//       child: Material(
//         color: Colors.transparent,
//         child: Column(
//           children: [
//             Container(
//                 height: 72,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: bgSecondColor),
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                       top: 10, left: 12, right: 12, bottom: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Center(child: Image.asset('assets/images/tire.png')),
//                       const SizedBox(height: 15),
//                       const Text(
//                         'Editing quotes',
//                         style: TextStyle(
//                             fontSize: 17,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 )),
//             const SizedBox(height: 10),
//             Expanded(
//               child: CustomScrollView(
//                 slivers: [
//                   BlocBuilder<ProdBloc, ProdState>(
//                     builder: (context, state) {
//                       return SliverList.builder(
//                         itemCount: state.valutePair.length,
//                         itemBuilder: (context, index) {
//                           final pair = state.valutePair[index];
//                           return Container(
//                             margin: const EdgeInsets.only(bottom: 10),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 15),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: bgSecondColor),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Image.asset(
//                                               'assets/images/${state.valutePair[index].pairValute.toSymbol}.png'),
//                                           const SizedBox(width: 5),
//                                           Text(
//                                             pair.pairValute,
//                                             style: const TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                                 color: Colors.white),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 10),
//                                       Text(
//                                         '${state.valutePair[index].price}',
//                                         style: const TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.white),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Text(
//                                         '${state.valutePair[index].changePrice < 0 ? '' : '+'}${state.valutePair[index].changePrice.toStringAsFixed(4)}',
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w500,
//                                             color: state.valutePair[index]
//                                                         .changePrice >=
//                                                     0.0
//                                                 ? Colors.green
//                                                 : Colors.red),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 117,
//                                       child: CalcButton(
//                                         text: 'Choose',
//                                         gradic: gradientButton,
//                                         function: () =>
//                                             showModalSheetChooseValute(
//                                                 context: context,
//                                                 index: index,
//                                                 updateVal: pair),
//                                       ),
//                                     ),
//                                     index < 3
//                                         ? const SizedBox.shrink()
//                                         : Row(
//                                             children: [
//                                               const SizedBox(width: 10),
//                                               GestureDetector(
//                                                 onTap: () => context
//                                                     .read<ProdBloc>()
//                                                     .add(
//                                                         DeleteAndSaveValutePairEvent(
//                                                             pair: pair)),
//                                                 child: Image.asset(
//                                                     'assets/images/trash_button.png'),
//                                               ),
//                                             ],
//                                           ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: SizedBox(
//                         height: 48,
//                         child: DecoratedBox(
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(6),
//                               color: Colors.white.withOpacity(0.06)),
//                           child: Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               onTap: () =>
//                                   showModalSheetChooseValute(context: context),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/plus.png',
//                                     color: Colors.white.withOpacity(0.7),
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     'Add',
//                                     style: TextStyle(
//                                         color: Colors.white.withOpacity(0.7),
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w600),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
