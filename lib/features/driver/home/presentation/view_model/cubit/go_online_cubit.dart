import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/go_onilne_use_case.dart';

part 'go_online_state.dart';

class GoOnlineCubit extends Cubit<GoOnlineState> {
  GoOnlineCubit(this.goOnilneUseCase) : super(GoOnlineInitial());
  final GoOnilneUseCase goOnilneUseCase;

  Future<void> goOnline(bool isOnline) async {
    emit(GoOnlineLoading());
    var result = await goOnilneUseCase.call(isOnline);
    result.fold(
      (failure) => {emit(GoOnlineFailure(failure.failurMsg))},
      (data) => {isOnline ? emit(GoOnlineSuccess()) : emit(GoOfflineSuccess())},
    );
  }
}
