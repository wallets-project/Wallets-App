import 'package:equatable/equatable.dart';
import 'package:wallets/features/auth/data/models/user_data.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;
  final User? user;

  const ProfileState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
    this.user,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
    User? user,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, isSuccess, user];
}
