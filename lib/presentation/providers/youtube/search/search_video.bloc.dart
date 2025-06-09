import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/usecases/export.dart';
import 'package:vacation/shared/export.dart';

import '../../abs/abs_state.dart';

part 'search_video.state.dart';

part 'search_video.event.dart';

part 'search_video.bloc.g.dart';

@injectable
class SearchVideoBloc extends Bloc<SearchVideoEvent, SearchVideoState>
    with LoggerMixIn {
  final YoutubeUseCase _useCase;

  SearchVideoBloc(this._useCase) : super(SearchVideoState.initState()) {
    on<UpdateSearchVideoStateEvent>(_onUpdate);
    on<ResetVideoEvent>(_onReset);
    on<KeywordChangedEvent>(_onChanged);
    on<FetchMoreVideoEvent>(_onFetchMore);
  }

  Future<void> _onUpdate(
    UpdateSearchVideoStateEvent event,
    Emitter<SearchVideoState> emit,
  ) async {
    emit(
      state.copyWith(
        status: event.status ?? state.status,
        message: event.message ?? state.message,
      ),
    );
  }

  Future<void> _onReset(
    ResetVideoEvent event,
    Emitter<SearchVideoState> emit,
  ) async {
    emit(
      state
          .copyWith(status: Status.initial, message: '', data: [])
          .copyWithNull(query: true),
    );
  }

  Future<void> _onChanged(
    KeywordChangedEvent event,
    Emitter<SearchVideoState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .search(event.query)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l);
                emit(
                  state.copyWith(
                    status: Status.error,
                    message: l.message ?? 'fetching videos fails',
                  ),
                );
              },
              (r) {
                emit(
                  state.copyWith(
                    status: Status.success,
                    message: '',
                    data: r.videos,
                    query: event.query,
                    nextPageToken: r.nextPageToken,
                  ),
                );
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'fetch videos fails'));
    }
  }

  Future<void> _onFetchMore(
    FetchMoreVideoEvent event,
    Emitter<SearchVideoState> emit,
  ) async {
    if (state.query == null) {
      logger.w('query is not null, but try to fetch more videos');
      return;
    }
    try {
      emit(state.copyWith(status: Status.loading));
      final temp = state.nextPageToken;
      await _useCase
          .search(state.query!, pageToken: state.nextPageToken)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l);
                emit(
                  state.copyWith(
                    status: Status.error,
                    message: l.message ?? 'fetching videos fails',
                  ),
                );
              },
              (r) {
                emit(
                  state
                      .copyWith(
                        status: Status.success,
                        message: '',
                        data: [...state.data, ...r.videos],
                        nextPageToken: r.nextPageToken,
                      )
                      .copyWithNull(
                        nextPageToken:
                            (temp == r.nextPageToken) ||
                            (r.nextPageToken == null),
                      ),
                );
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(status: Status.error, message: 'fetch more video fails'),
      );
    }
  }
}
