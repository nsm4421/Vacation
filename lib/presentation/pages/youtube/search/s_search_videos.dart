import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation/dependency_injection.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/presentation/widgets/export.dart';
import 'package:vacation/shared/export.dart';

import 'f_video_list.dart';
import 'w_app_bar.dart';

class SearchVideosScreen extends StatelessWidget {
  const SearchVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SearchVideoBloc>(),
      child: BlocBuilder<SearchVideoBloc, SearchVideoState>(
        builder: (context, state) {
          return LoadingOverlayWidget(
            showOverlay: state.status == Status.loading,
            child: Scaffold(
              appBar: AppbarWidget(state.query),
              body: VideoListFragment(state.data),
            ),
          );
        },
      ),
    );
  }
}
