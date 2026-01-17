import 'package:equatable/equatable.dart';

class LogoutState extends Equatable {
  final bool isLoading;
  final String? erorrMesseage;
  final bool isSuccess;

  const LogoutState({
    this.isLoading = false,
    this.erorrMesseage,
    this.isSuccess = false,
  });

  LogoutState copyWith({bool? isLoading, String? erorrMesseage, bool? isSuccess}) {
    return LogoutState(
      erorrMesseage: erorrMesseage ?? this.erorrMesseage,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, erorrMesseage, isSuccess];
}
