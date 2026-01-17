import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/networking/api_exception.dart';
import 'package:wallets/features/auth/data/repo/auth_repo.dart';
import 'package:wallets/features/auth/logic/logout/cubit/logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepo _repo;
  LogoutCubit(this._repo) : super(LogoutState());
  Future<void> logout() async {
    emit(
      state.copyWith(isLoading: true, erorrMesseage: null, isSuccess: false),
    );
    try {
      await _repo.logout();
      emit(
        state.copyWith(isLoading: false, erorrMesseage: null, isSuccess: true),
      );
    } catch (e) {
      if (e is ApiException) {
        emit(state.copyWith(isLoading: false, erorrMesseage: e.message));
      } else {
        emit(
          state.copyWith(isLoading: false, erorrMesseage: 'حدث خطأ غير متوقع'),
        );
      }
    }
  }
}
