// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'signin_cubit.dart';

enum SigninStatus { initial, submiting, success, error }

class SigninState extends Equatable {
  final SigninStatus signinStatus;
  final CustomError error;
  SigninState({
    required this.signinStatus,
    required this.error,
  });

  factory SigninState.initial() {
    return SigninState(
        signinStatus: SigninStatus.initial, error: CustomError());
  }

  @override
  List<Object> get props => [signinStatus, error];

  SigninState copyWith({
    SigninStatus? signinStatus,
    CustomError? error,
  }) {
    return SigninState(
      signinStatus: signinStatus ?? this.signinStatus,
      error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;
}