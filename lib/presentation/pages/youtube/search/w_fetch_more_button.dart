import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/shared/export.dart';

class FetchMoreButtonWidget extends StatelessWidget {
  const FetchMoreButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchVideoBloc, SearchVideoState>(
      builder: (context, state) {
        return (state.query == null) ||
                (state.nextPageToken == null) ||
                (state.status == Status.loading)
            ? SizedBox.shrink()
            : Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<SearchVideoBloc>().add(FetchMoreVideoEvent());
                },
                child: Text('Fetch More'),
              ),
            );
      },
    );
  }
}
