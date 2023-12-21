import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:golden_gate/nav_manager.dart';
import '../../const/import.dart';
import '../domain/blocs/car/car_bloc.dart';
import '../domain/model/car_model.dart';

class CarItem extends StatelessWidget {
  final CarModel nft;
  const CarItem({super.key, required this.nft});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: bgSecondColor),
      child: GestureDetector(
        onTap: () {
          context.read<CarBloc>().add(ChangeIndexEvent(index: nft));
          MyNavigatorManager.instance.carPush();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: AspectRatio(
                aspectRatio: 174 / 118,
                child: FutureBuilder<FileImage?>(
                  future: nft.productImage,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      );
                    }
                    return AspectRatio(
                      aspectRatio: 174 / 118,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '\$${nft.price!}',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.028,
                          color: primary,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      nft.name!.toFirstLetter,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      nft.status,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.028,
                          fontWeight: FontWeight.w400,
                          color: nft.status == 'Rented'
                              ? Colors.green
                              : Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
