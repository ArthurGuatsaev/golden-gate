import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../const/color.dart';

import '../loading/import.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const SplashPage());
  }

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double loadProgress = 0;
  late final double width;
  late double pading;
  @override
  void didChangeDependencies() {
    pading = MediaQuery.of(context).size.width / 3.5;
    width = MediaQuery.of(context).size.width - pading * 2;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:
                Image.asset('assets/images/loading.png', fit: BoxFit.fitWidth),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: BlocBuilder<LoadBloc, LoadState>(
                buildWhen: (previous, current) =>
                    previous.loadingList != current.loadingList,
                builder: (context, state) {
                  loadProgress = (width / (VLoading.values.length - 3)) *
                      (state.loadingList.length + 0.8);
                  final loadPersent = ((state.loadingList.length * 100) /
                          (VLoading.values.length - 3))
                      .toStringAsFixed(0);
                  return SizedBox(
                    height: 50,
                    child: Column(
                      children: [
                        Text(
                          '$loadPersent%',
                          style: const TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 8,
                          width: width,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.1)),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: loadProgress,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primary),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

const _loadingColor = Colors.white;
final _loadingBackColor = Colors.white.withOpacity(0.12);
