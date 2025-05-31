import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/widgets/export.dart';
import 'package:vacation/shared/export.dart';

import 'w_select_image.dart';
import 'f_trip_form.dart';

class EditTripModalScreen extends StatefulWidget {
  const EditTripModalScreen({
    super.key,
    required this.trip,
    required this.handleCompleteEdit,
  });

  final TripEntity trip;
  final void Function({
    required String tripName,
    required DateTimeRange dateRange,
    XFile? thumbnail,
  })
  handleCompleteEdit;

  @override
  State<EditTripModalScreen> createState() => _EditTripModalScreenState();
}

class _EditTripModalScreenState extends State<EditTripModalScreen>
    with DateFormatterMixIn, DebounceMixin {
  late final TextEditingController _tripNameController;
  late final TextEditingController _dateRangeController;
  late XFile? _currentImage;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormState>(debugLabel: 'edit-trip-form');
    _tripNameController = TextEditingController()..text = widget.trip.tripName;
    _dateRangeController =
        TextEditingController()
          ..text = handleFormatDateRange(widget.trip.dateRange);
    _currentImage =
        widget.trip.thumbnail == null ? null : XFile(widget.trip.thumbnail!);
  }

  @override
  void dispose() {
    super.dispose();
    _tripNameController.dispose();
    _dateRangeController.dispose();
  }

  _handleUpdateCurrentImage(XFile? xFile) {
    setState(() {
      _currentImage = xFile;
    });
  }

  _handleSubmit() => debounce(() async {
    context.unfocus();
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok == null || !ok) return;
    widget.handleCompleteEdit(
      tripName: _tripNameController.text.trim(),
      dateRange: handleFormatStringToDateTimeRange(
        _dateRangeController.text.trim(),
      ),
      thumbnail: _currentImage,
    );
    if (context.canPop()) {
      context.pop();
    }
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("Edit Trip")),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: TripFormFragment(
                  formKey: _formKey,
                  trip: widget.trip,
                  tripNameController: _tripNameController,
                  dateRangeController: _dateRangeController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: SelectImageWidget(
                  trip: widget.trip,
                  currentImage: _currentImage,
                  updateImage: _handleUpdateCurrentImage,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: OnTapButtonWidget(onTap: _handleSubmit),
    );
  }
}
