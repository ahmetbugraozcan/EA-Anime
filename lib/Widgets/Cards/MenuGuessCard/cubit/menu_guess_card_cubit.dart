import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_guess_card_state.dart';

class MenuGuessCardCubit extends Cubit<MenuGuessCardState> {
  MenuGuessCardCubit() : super(MenuGuessCardState()) {}
}
