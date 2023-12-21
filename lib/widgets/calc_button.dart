import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final Function()? function;
  final String text;
  final String? subText;
  final Gradient? gradic;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? fontSizeSub;
  final FontWeight? fontWeightSub;
  const CalcButton(
      {super.key,
      this.fontWeight,
      this.fontSizeSub,
      this.fontWeightSub,
      this.function,
      this.subText,
      this.gradic,
      this.color,
      required this.text,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 2250),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: gradic ?? _gradient),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Text(text,
                        style: TextStyle(
                            // fontFamily: 'SF',
                            color: color ?? Colors.white,
                            fontSize: fontSize ?? 16,
                            fontWeight: fontWeight ?? FontWeight.w700)),
                  ),
                  subText != null
                      ? Text(subText!,
                          style: TextStyle(
                              color: color ?? Colors.white,
                              fontSize: fontSizeSub ?? 12,
                              fontWeight: fontWeightSub ?? FontWeight.w400))
                      : const SizedBox.shrink()
                ],
              )),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: function,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          )
        ],
      ),
    );
  }
}

const _gradient = LinearGradient(colors: [
  Color(0xFF14C966),
  Color(0xFF0ED82F),
]);
