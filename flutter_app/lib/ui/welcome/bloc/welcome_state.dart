part of 'welcome_bloc.dart';

@immutable
class WelcomeState {
  final int page;
  const WelcomeState({
    required this.page,
  });
}

class WelcomeInitial extends WelcomeState {
  const WelcomeInitial() : super(page: 0);
}
