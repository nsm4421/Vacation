import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/dependency_injection.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/presentation/widgets/export.dart';
import 'package:vacation/shared/export.dart';

import 'f_histories.dart';

class TripDetailScreen extends StatelessWidget with DateFormatterMixIn {
  const TripDetailScreen(this._trip, {super.key});

  final TripEntity _trip;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DisplayTripDetailCubit>(param1: _trip)..mount(),
      child: BlocBuilder<DisplayTripDetailCubit, DisplayTripDetailState>(
        builder: (context, state) {
          return LoadingOverlayWidget(
            showOverlay: state.status == Status.loading,
            child: Scaffold(
              appBar: AppBar(
                leading:
                    _trip.thumbnail == null
                        ? null
                        : CircularAvatarImageWidget(
                          imagePath: _trip.thumbnail!,
                        ),
                title: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style, // 기본 스타일 상속
                    children: [
                      TextSpan(
                        text: '${_trip.tripName}\n',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: handleFormatDateRange(_trip.dateRange),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                    icon: Icon(Icons.clear),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: HistoriesFragment(state.data),
              ),
            ),
          );
        },
      ),
    );
  }
}
