// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../const/import.dart';
import '../../../../../widgets/calc_button.dart';
import '../../../../import.dart';

class VBaseBoard extends StatelessWidget {
  final VBoardParam boardParam;
  final int entity;
  const VBaseBoard({
    Key? key,
    required this.entity,
    required this.boardParam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              boardParam.image,
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.43,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: bgSecondColor),
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15, left: 15, bottom: 60),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      // BlocBuilder<LoadBloc, LoadState>(
                      //   buildWhen: (previous, current) =>
                      //       previous.onboardIndex != current.onboardIndex,
                      //   builder: (context, state) {
                      //     return MyCheckBox(
                      //       index: state.onboardIndex,
                      //     );
                      //   },
                      // ),
                      const SizedBox(height: 10),
                      Text(
                        boardParam.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        child: DecoratedBox(
                          decoration: const BoxDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Text(
                              boardParam.body,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      BlocBuilder<LoadBloc, LoadState>(
                        buildWhen: (previous, current) =>
                            previous.onboardIndex != current.onboardIndex,
                        builder: (context, state) {
                          return MyCheckBox(
                            index: state.onboardIndex,
                            entity: entity,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 48,
                        child: CalcButton(
                            text: boardParam.buttonText,
                            function: boardParam.function,
                            fontSize: 16,
                            gradic: gradientButton,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class VBoardParam {
  final String? tg;
  final String image;
  final String title;
  final String body;
  final String buttonText;
  final Function()? function;
  VBoardParam({
    this.tg,
    this.function,
    required this.image,
    required this.title,
    required this.body,
    required this.buttonText,
  });
}

const boxColor = Color(0xFF282C3A);
