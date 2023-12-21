import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../const/import.dart';
import '../../import.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.homeIndex != current.homeIndex,
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) => context
                .read<HomeBloc>()
                .add(ChangeHomeIndexEvent(homeIndex: value)),
            currentIndex: state.homeIndex,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: primary,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedLabelStyle: const TextStyle(
                color: primary, fontSize: 10, fontWeight: FontWeight.w500),
            unselectedLabelStyle: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                fontWeight: FontWeight.w500),
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/car_face.png',
                        color: Colors.white.withOpacity(0.3))),
                label: 'Main',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/car_face.png',
                      color: primary,
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/statis.png',
                        color: Colors.white.withOpacity(0.3))),
                label: 'Statistics',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/statis.png',
                      color: primary,
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/card.png',
                        color: Colors.white.withOpacity(0.3))),
                label: 'Payments',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/card.png',
                      color: primary,
                    )),
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset('assets/images/settings.png',
                        color: Colors.white.withOpacity(0.3))),
                label: 'Settings',
                activeIcon: SizedBox(
                    width: 40,
                    height: 40,
                    child: Image.asset(
                      'assets/images/settings.png',
                      color: primary,
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
