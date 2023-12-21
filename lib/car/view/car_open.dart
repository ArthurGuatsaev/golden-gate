import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/import.dart';
import '../domain/blocs/car/car_bloc.dart';

class CarOpen extends StatelessWidget {
  const CarOpen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      builder: (context, state) {
        final car = state.car[state.current];
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: bgSecondColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: AspectRatio(
                  aspectRatio: 362 / 230,
                  child: FutureBuilder<FileImage?>(
                    future: car.productImage,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return const CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        );
                      }
                      return AspectRatio(
                        aspectRatio: 362 / 230,
                        child: Image(
                          image: snapshot.data!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const SizedBox(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car.name!.toFirstLetter,
                            maxLines: 1,
                            style: seventeenStyle,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            car.status,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: car.status == 'Rented'
                                    ? Colors.green
                                    : Colors.red),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${car.price!}',
                      style: seventeenPrimeStyle,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
