import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  static const String _onboardingKey = 'onboarding_completed';

  OnboardingBloc() : super(OnboardingInitial()) {
    on<CheckOnboardingStatus>(_onCheckOnboardingStatus);
    on<CompleteOnboarding>(_onCompleteOnboarding);
  }

  Future<void> _onCheckOnboardingStatus(
    CheckOnboardingStatus event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final isCompleted = prefs.getBool(_onboardingKey) ?? false;

      if (isCompleted) {
        emit(OnboardingCompleted());
      } else {
        emit(OnboardingNotCompleted());
      }
    } catch (e) {
      emit(OnboardingNotCompleted());
    }
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_onboardingKey, true);
      emit(OnboardingCompleted());
    } catch (e) {
      // Handle error if needed
      emit(OnboardingNotCompleted());
    }
  }
}
