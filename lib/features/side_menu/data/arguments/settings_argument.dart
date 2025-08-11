import 'dart:ui';

class SettingsArgument {
  final bool isPatient;

  final VoidCallback onUpdate;

  SettingsArgument({
    required this.isPatient,
    required this.onUpdate,
  });
}
