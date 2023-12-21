import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../const/import.dart';
import '../../import.dart';

class NoteTitleUnderline extends StatefulWidget {
  final int id;
  final TextEditingController textController;
  const NoteTitleUnderline(
      {super.key, required this.textController, required this.id});

  @override
  State<NoteTitleUnderline> createState() => _NoteTitleUnderlineeState();
}

class _NoteTitleUnderlineeState extends State<NoteTitleUnderline> {
  @override
  void dispose() {
    widget.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New note',
              style: fifteenStyle,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextField(
                      maxLines: 1,
                      controller: widget.textController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Text here...',
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: primary)),
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.3)),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.12)))),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (widget.textController.text.isEmpty) {
                      return;
                    }
                    final note = VNotesIssar()
                      ..date = DateTime.now()
                      ..body = widget.textController.text
                      ..iD = widget.id;
                    context.read<NoteBloc>().add(SaveNoteEvent(note: note));
                    widget.textController.clear();
                  },
                  child: Image.asset(
                    'assets/images/turn_around.png',
                    color: primary,
                  ),
                ),
              ],
            ),
            BlocBuilder<NoteBloc, NoteState>(
              buildWhen: (previous, current) =>
                  previous.currentNotes.length != current.currentNotes.length,
              builder: (context, state) {
                if (state.currentNotes.isEmpty) {
                  return SizedBox(
                    height: 300,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/notes_empty.png'),
                          const SizedBox(height: 10),
                          const SizedBox(height: 15),
                          const Text(
                            'Empty',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Text(
                                "You don't have any added notes yet",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withOpacity(0.7)),
                              )),
                            ],
                          )
                        ]),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
