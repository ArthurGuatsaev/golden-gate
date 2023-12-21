import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/import.dart';
import '../import.dart';
import '../view/widget/bottom.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => const HomePage());
  }

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.homeIndex != current.homeIndex,
        builder: (context, state) {
          return IndexedStack(index: state.homeIndex, children: const [
            CarNavi(),
            StatisticPage(),
            PaymantPage(),
            SettingsPage(),
          ]);
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
