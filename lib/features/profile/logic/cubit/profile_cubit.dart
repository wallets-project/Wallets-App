
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallets/core/storage/user_storage.dart';
import 'package:wallets/features/profile/data/repo/profile_repo.dart';
import 'package:wallets/features/profile/logic/cubit/profile_state.dart';


class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _repo;
  final UserStorage _userStorage;
  ProfileCubit(this._repo, this._userStorage) : super(ProfileState());

  Future<void> fetchProfile() async {
    final cachedUser = _userStorage.getUserJson();
    if (cachedUser != null) {
      emit(
        state.copyWith(
          isLoading: true,
          errorMessage: null,
          isSuccess: false,
          user: cachedUser,
        ),
      );
    } else {
      emit(
        state.copyWith(isLoading: true, errorMessage: null, isSuccess: false),
      );
    }
    try {
      final user = await _repo.getProfile();
      emit(state.copyWith(isLoading: false, isSuccess: true, user: user));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: e.toString(), isSuccess: false));
    }
  }
  
}
