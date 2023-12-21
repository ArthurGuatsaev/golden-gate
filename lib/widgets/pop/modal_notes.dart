import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import '../../notes/import.dart';
import '../../car/import.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../const/import.dart';

Future showModalSheetNotes({
  required BuildContext context,
  required TextEditingController nameController,
  required CarModel car,
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
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Center(child: Image.asset('assets/images/tire.png')),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text('Note', style: seventeenStyle),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                NoteTitleUnderline(
                    textController: TextEditingController(), id: car.id!),
                const NoteListTwo(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
