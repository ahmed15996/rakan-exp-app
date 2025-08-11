import 'dart:async';

import 'package:flutter/widgets.dart';

import 'custom_text_form_field.dart';

class CustomPartSearchBarWidget extends StatefulWidget {
  final void Function() playSearch, stopSearch;
  final String title;
  final TextEditingController ctrl;

  const CustomPartSearchBarWidget(
      {super.key,
      required this.playSearch,
      required this.stopSearch,
      required this.title,
      required this.ctrl});

  @override
  State<CustomPartSearchBarWidget> createState() =>
      _CustomPartSearchBarWidgetState();
}

class _CustomPartSearchBarWidgetState extends State<CustomPartSearchBarWidget> {
  Timer? debounce;

  void playSearch({
    required String value,
    required void Function() stopSearch,
    required void Function() playSearch,
  }) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    if (value.isEmpty) {
      stopSearch();
    } else {
      debounce = Timer(
        const Duration(milliseconds: 1000),
        () {
          playSearch();
        },
      );
    }
  }

  @override
  void dispose() {
    if (debounce != null) {
      debounce!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      onChanged: (value) {
        playSearch(
          value: value,
          playSearch: widget.playSearch,
          stopSearch: widget.stopSearch,
        );
      },
      hintText: widget.title,
      ctrl: widget.ctrl,
    );
  }
}
