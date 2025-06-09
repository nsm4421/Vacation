import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/shared/export.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget(this.query, {super.key});

  final String? query;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Search Video',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (query != null)
              TextSpan(
                text: '\n# $query',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  overflow: TextOverflow.ellipsis,
                  color: Theme.of(context).colorScheme.primary
                ),
              ),
          ],
        ),
      ),
      actions: [
        if (query != null)
          IconButton(
            onPressed: () {
              context.read<SearchVideoBloc>().add(ResetVideoEvent());
            },
            icon: Icon(Icons.rotate_left),
            tooltip: 'Reset',
          ),
        IconButton(
          onPressed: () async {
            await showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (_) {
                return SearchVideoModalWidget((query) {
                  context.read<SearchVideoBloc>().add(
                    KeywordChangedEvent(query),
                  );
                });
              },
            );
          },
          icon: Icon(Icons.search),
          tooltip: 'Search',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SearchVideoModalWidget extends StatefulWidget {
  const SearchVideoModalWidget(this.handleSubmit, {super.key});

  final void Function(String text) handleSubmit;

  @override
  State<SearchVideoModalWidget> createState() => _SearchVideoModalWidgetState();
}

class _SearchVideoModalWidgetState extends State<SearchVideoModalWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late bool _isFocused;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode()..addListener(_handleFocus);
    _isFocused = _focusNode.hasFocus;
    _formKey = GlobalKey<FormState>(debugLabel: 'search-video-form-key');
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode
      ..removeListener(_handleFocus)
      ..dispose();
  }

  _handleFocus() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  String? _handleValidate(String? text) {
    if (text == null || text.isEmpty) {
      return 'keyword is empty';
    }
    return null;
  }

  _handleSubmit() async {
    context.unfocus();
    _formKey.currentState?.save();
    final ok = _formKey.currentState?.validate();
    if (ok != true) return;
    widget.handleSubmit(_controller.text.trim());
    if (context.canPop()) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 16,
        right: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Search', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(decorationThickness: 0),
                    validator: _handleValidate,
                    decoration: InputDecoration(
                      hintText: 'Keyword',
                      border:
                          _isFocused
                              ? OutlineInputBorder()
                              : UnderlineInputBorder(),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: _handleSubmit,
                icon: Icon(
                  Icons.search,
                  color:
                      _isFocused ? Theme.of(context).colorScheme.primary : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
