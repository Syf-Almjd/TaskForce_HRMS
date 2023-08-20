import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ba_b_event.dart';
part 'ba_b_state.dart';

class BaBBloc extends Bloc<BaBEvent, BaBState> {
  BaBBloc() : super(const BaBInitial(3)) {
    on<BaBEvent>((event, emit) {
      if (event is TabChange) {
        switch (event.currentIndex) {
          case (0):
            emit(ProfileScreen(event.currentIndex));
          case (1):
            emit(CartScreen(event.currentIndex));
          case (2):
            emit(ProductScreen(event.currentIndex));
          case (3):
            emit(HomeScreen(event.currentIndex));
        }
      }
    });
  }
}
