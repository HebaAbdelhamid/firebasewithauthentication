import 'package:bloc/bloc.dart';

import 'chat_page_state.dart';

class ChatPageCubit extends Cubit<ChatPageState> {
  ChatPageCubit() : super(ChatPageState().init());
}
