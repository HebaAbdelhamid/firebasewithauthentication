import 'package:bloc/bloc.dart';

import 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageState().init());
}
