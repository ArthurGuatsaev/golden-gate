import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../const/import.dart';
import 'package:image_picker/image_picker.dart';
import 'package:equatable/equatable.dart';

import '../../model/car_model.dart';
import '../../repository/car_repository.dart';

part 'car_event.dart';
part 'car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final CarRepository nftRepository;
  CarBloc({required this.nftRepository}) : super(const CarState()) {
    on<GetSaveNFTEvent>(getSaveNft);
    on<UpdateNFTEvent>(updateNFT);
    on<SaveNFTEvent>(saveNFT);
    on<RemoveNFTEvent>(removeNFT);
    on<ReseteSaveNFTEvent>(reseteNFT);
    on<ChooseNFTEvent>(chooseImage);
    on<CancelImageEvent>(cancelImage);
    on<ChangeIndexEvent>(changeIndex);
    on<ChangeStateImageEvent>(changeStateImage);
  }

  getSaveNft(GetSaveNFTEvent event, Emitter<CarState> emit) {
    final nft = nftRepository.nft;
    emit(state.copyWith(car: nft));
  }

  updateNFT(UpdateNFTEvent event, Emitter<CarState> emit) async {
    final nft = await nftRepository.getSaveNFT();
    emit(state.copyWith(car: nft, image: null));
  }

  saveNFT(SaveNFTEvent event, Emitter<CarState> emit) async {
    await nftRepository.saveImage(
        image: state.image, key: '${event.model.myId!}');
    await nftRepository.saveNFT(note: event.model);
    add(UpdateNFTEvent());
  }

  removeNFT(RemoveNFTEvent event, Emitter<CarState> emit) async {
    await nftRepository.deleteNFT(event.model);
    add(UpdateNFTEvent());
  }

  reseteNFT(ReseteSaveNFTEvent event, Emitter<CarState> emit) async {
    await nftRepository.reseteNFT();
    add(UpdateNFTEvent());
  }

  chooseImage(ChooseNFTEvent event, Emitter<CarState> emit) async {
    final image = await nftRepository.getNewImage();
    emit(state.copyWith(image: image));
  }

  cancelImage(CancelImageEvent event, Emitter<CarState> emit) async {
    emit(state.copyWith(image: null));
  }

  changeIndex(ChangeIndexEvent event, Emitter<CarState> emit) async {
    final index = state.car.indexOf(event.index);
    emit(state.copyWith(current: index));
  }

  changeStateImage(ChangeStateImageEvent event, Emitter<CarState> emit) async {
    final image = await event.file;
    if (image == null) {
      return;
    }
    final xfile = XFile(image.file.path);
    emit(state.copyWith(image: xfile));
  }
}
