import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_gate/car/import.dart';
import 'package:in_app_review/in_app_review.dart';

import '../const/import.dart';
import '../nav_manager.dart';
import '../notes/import.dart';
import '../widgets/pop/pop_up_ios_delete.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/setting';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SettingsPage());
  }

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) => false,
      child: Scaffold(
        // appBar: AppBar(
        //     backgroundColor: bgSecondColor,
        //     leadingWidth: 100,
        //     leading: Row(
        //       children: [
        //         GestureDetector(
        //           onTap: () => MyNavigatorManager.instance.bankPop(),
        //           child: const Row(
        //             children: [
        //               Icon(
        //                 Icons.navigate_before,
        //                 color: primary,
        //                 size: 30,
        //               ),
        //               SizedBox(
        //                 width: 0,
        //               ),
        //               Text(
        //                 'Back',
        //                 style: TextStyle(
        //                     fontSize: 17,
        //                     fontWeight: FontWeight.w400,
        //                     color: primary),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ],
        //     ),
        //     centerTitle: true,
        //     title: const Text(
        //       'Account name',
        //       style: TextStyle(
        //           fontSize: 17,
        //           color: Colors.white,
        //           fontWeight: FontWeight.w400),
        //     )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 12, left: 12, top: 45),
            child: Column(children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                        ),
                        const Text(
                          'Setting',
                          style: thirtyFourStyte,
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: backgroundColor),
                child: Column(children: [
                  SettingsItem(
                    image: 'assets/images/docs.png',
                    title: 'Usage Policy',
                    isLast: true,
                    function: () {
                      launchPolicy();
                    },
                  ),
                  SettingsItem(
                    image: 'assets/images/share.png',
                    isLast: true,
                    title: 'Share App',
                    function: () {
                      shareApp(
                          context: context,
                          text:
                              'https://apps.apple.com/us/app/quater-fx/id6474067897');
                    },
                  ),
                  SettingsItem(
                    image: 'assets/images/star_fill.png',
                    isLast: true,
                    title: 'Rate Us',
                    function: () {
                      inAppReview.requestReview();
                    },
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              SettingsItem(
                isLast: true,
                image: 'assets/images/reset.png',
                bgColor: backgroundColor,
                titleColor: Colors.red,
                title: 'Reset progress',
                function: () {
                  showMyIosResetDataPop(context, () {
                    context.read<CarBloc>().add(ReseteSaveNFTEvent());
                    context.read<NoteBloc>().add(ResetNoteEvent());
                    MyNavigatorManager.instance.simulatorPop();
                  });
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final String? image;
  final Color? titleColor;
  final Function() function;
  final bool? isLast;
  final Color? bgColor;
  const SettingsItem({
    super.key,
    required this.function,
    this.image,
    this.titleColor,
    required this.title,
    this.bgColor,
    this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
          border: isLast == null
              ? Border(
                  bottom: BorderSide(color: Colors.white.withOpacity(0.12)))
              : null),
      child: Material(
        color: bgColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: function,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(children: [
              icon,
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: titleColor ?? Colors.white),
                ),
              ),
              const Icon(
                Icons.navigate_next,
                size: 25,
                color: Colors.white,
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget get icon {
    return image != null
        ? SizedBox(
            width: 50,
            child: Image.asset(
              image!,
              height: 25,
              color: primary,
            ),
          )
        : const SizedBox.shrink();
  }
}
