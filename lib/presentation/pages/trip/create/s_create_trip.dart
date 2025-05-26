import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/dependency_injection.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/presentation/widgets/export.dart';
import 'package:vacation/shared/export.dart';

import 'f_form.dart';
import 'w_submit_button.dart';

class CreateTripScreen extends StatelessWidget {
  const CreateTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateTripCubit>(),
      child: BlocListener<CreateTripCubit, CreateTripState>(
        listener: (context, state) {
          switch (state.status) {
            case Status.success:
              // TODO : show success message
              context.pop();
              return;
            case Status.error:
              // TODO : show error message
              Timer(Duration(seconds: 1), () {
                context.read<CreateTripCubit>().updateStatus(
                  status: Status.initial,
                  message: '',
                );
              });
              return;
            default:
              return;
          }
        },
        child: BlocBuilder<CreateTripCubit, CreateTripState>(
          builder: (context, state) {
            return LoadingOverlayWidget(
              showOverlay: state.status != Status.initial,
              child: Scaffold(
                appBar: AppBar(title: Text("Create Trip")),
                body: CreateTripFormFragment(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: SubmitCreateTripFormButton(),
              ),
            );
          },
        ),
      ),
    );
  }
}
