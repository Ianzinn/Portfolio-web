part of 'experience_bloc.dart';

sealed class ExperienceEvent {
  const ExperienceEvent();
}

final class LoadExperienceEvent extends ExperienceEvent {
  const LoadExperienceEvent();
}
