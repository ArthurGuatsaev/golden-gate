import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../import.dart';

class NoteList extends StatelessWidget {
  const NoteList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      buildWhen: (previous, current) =>
          previous.currentNotes != current.currentNotes,
      builder: (context, state) {
        return SliverList.builder(
          itemCount: state.currentNotes.length,
          itemBuilder: (context, index) {
            final note = state.currentNotes[index];
            return Container(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        context.read<NoteBloc>().add(DelNoteEvent(note: note)),
                    child: Image.asset(
                      'assets/images/trash.png',
                      width: 40,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.06),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            note.dateString,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: MediaQuery.of(context).size.width - 115,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints.loose(Size(
                                MediaQuery.of(context).size.width - 90, 300)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    note.body!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
