import '../../const/import.dart';
import '../../notes/view/bloc/note_bloc.dart';
import '../import.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NftTopItem extends StatelessWidget {
  final CarModel nft;
  const NftTopItem({super.key, required this.nft});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      height: 118,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            context.read<NoteBloc>().add(ChangeCurrentIdEvent(id: nft.myId!));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 173 / 140,
                  child: SizedBox(
                    height: 118,
                    child: Stack(
                      children: [
                        FutureBuilder<FileImage?>(
                          future: nft.productImage,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                ),
                              );
                            }
                            return AspectRatio(
                              aspectRatio: 173 / 140,
                              child: Image(
                                image: snapshot.data!,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nft.name!,
                      style: seventeenStyle,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '\$${nft.price!} million',
                      maxLines: 1,
                      style: twentyTwoStyle,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      nft.desc!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: thirdteenGreyStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
