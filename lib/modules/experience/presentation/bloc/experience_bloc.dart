import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/usecases/get_experience_usecase.dart';

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final GetExperienceUseCase getExperienceUseCase;

  ExperienceBloc({required this.getExperienceUseCase})
      : super(ExperienceInitial()) {
    on<LoadExperienceEvent>(_onLoad);
  }

  Future<void> _onLoad(
    LoadExperienceEvent event,
    Emitter<ExperienceState> emit,
  ) async {
    emit(ExperienceLoading());
    final result = await getExperienceUseCase(const NoParams());
    result.fold(
      (failure) => emit(ExperienceError(failure.message)),
      (list) => emit(ExperienceLoaded(list)),
    );
  }
}
