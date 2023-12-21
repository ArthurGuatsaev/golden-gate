import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_gate/const/import.dart';

import '../../import.dart';

class NoteListTwo extends StatelessWidget {
  const NoteListTwo({
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
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/note.png',
                        color: _color,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            'Note #${index + 1}',
                            style: fifteenWhiteStyle,
                          ),
                          Text(
                            note.dateString,
                            style: elevenGreyStyle,
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => context
                            .read<NoteBloc>()
                            .add(DelNoteEvent(note: note)),
                        child: Image.asset(
                          'assets/images/trash.png',
                          width: 40,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: bgSecondColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
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

const Color _color = Color(0xFF6D7587);
