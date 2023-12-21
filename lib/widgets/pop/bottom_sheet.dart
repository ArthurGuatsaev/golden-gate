import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

showCupertinoBottomSheet({
  required BuildContext context,
  // required ProductModel product,
}) async {
  return showCupertinoModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
                onPressed: () {
                  // context.read<HistoryBloc>().add(SaveHistoryEvent(
                  //     hist: HistoryModel()
                  //       ..date = DateTime.now()
                  //       ..title = '${product.name} added to favorites'));
                  // context.read<ProdBloc>().add(AddFavoriteProduct(
                  //     product: product.copyWith(isFavorite: true)));
                  // MyNavigatorManager.instance.simulatorPop();
                },
                child: const Text('To favorites',
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w400))),
            CupertinoActionSheetAction(
                onPressed: () {
                  // context.read<HistoryBloc>().add(SaveHistoryEvent(
                  //     hist: HistoryModel()
                  //       ..date = DateTime.now()
                  //       ..title = '${product.name} added to archive'));
                  // context.read<ProdBloc>().add(AddFavoriteProduct(
                  //     product: product.copyWith(isArchive: true)));
                  // MyNavigatorManager.instance.simulatorPop();
                },
                child: const Text(
                  'To the archive',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                )),
            CupertinoActionSheetAction(
                onPressed: () {
                  // context.read<HistoryBloc>().add(SaveHistoryEvent(
                  //     hist: HistoryModel()
                  //       ..date = DateTime.now()
                  //       ..title = 'Removed item - ${product.name}'));
                  // context
                  //     .read<ProdBloc>()
                  //     .add(DeleteProductEvent(product: product));
                  // MyNavigatorManager.instance.simulatorPop();
                },
                child: const Text('Delete',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.red))),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            onPressed: () {
              // MyNavigatorManager.instance.simulatorPop();
            },
          ),
        );
      });
}
