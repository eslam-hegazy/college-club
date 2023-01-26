part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class ChangeBottomNavigationSuccessState extends GlobalState {}

class LoginSuccess extends GlobalState {
  final String message;
  LoginSuccess({
    required this.message,
  });
}

class SignOutSuccess extends GlobalState {
  final String message;
  SignOutSuccess({
    required this.message,
  });
}

class ChangeSwitchMale extends GlobalState {}

class ChangeSwitchLanguage extends GlobalState {}

class ChangeDropListState extends GlobalState {}

class LoadingGenerateImageState extends GlobalState {}

class SuccessGenerateImageState extends GlobalState {}

class ErrorGenerateImageState extends GlobalState {}

class LoadingGenerateMessageState extends GlobalState {}

class SuccessGenerateMessageState extends GlobalState {}

class ErrorGenerateMessageState extends GlobalState {}

class ChangeMicrophoneState extends GlobalState {}

class ChangeVideoState extends GlobalState {}

class GetUserNameState extends GlobalState {}

class GetBioState extends GlobalState {}

class GetStatusState extends GlobalState {}
