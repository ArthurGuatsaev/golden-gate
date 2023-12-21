import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:golden_gate/nav_manager.dart';

import '../car/import.dart';
import '../const/import.dart';
import '../widgets/pop/modal_nft_add.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/collect';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const MainPage());
  }

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    MyNavigatorManager.instance
        .navigatorInit(context.findAncestorStateOfType<NavigatorState>()!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      buildWhen: (previous, current) => previous.car != current.car,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              GestureDetector(
                onTap: () {
                  showModalSheetCarAdd(
                    context: context,
                    priceController: TextEditingController(),
                    nameController: TextEditingController(),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.add,
                    color: primary,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Text(
                    'Main',
                    style: thirtyFourStyte,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
                SliverToBoxAdapter(
                  child: Builder(
                    builder: (context) {
                      if (state.car.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: SizedBox(
                            height: 600,
                            child: SizedBox(
                              height: 270,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/images/car_empty.png'),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                  const Text('No cars added',
                                      style: twentyPrimeStyle),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 70),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Click «+» on the button to start tracking car income",
                                            style: fifteenStyle,
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
                SliverGrid.builder(
                    itemCount: state.car.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 173 / 208,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return CarItem(
                        nft: state.car[index],
                      );
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
