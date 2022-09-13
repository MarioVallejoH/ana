import 'package:form_field_validator/form_field_validator.dart';

/// Class to use in textForm validators when validation is out of validator, usefull
/// for async validation
class CustomValidator extends TextFieldValidator {
  CustomValidator({required String errorText, required this.isValidField})
      : super(errorText);
  final bool isValidField;
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (value?.isNotEmpty ?? false) {
      return isValidField;
    } else {
      return false;
    }
  }

  @override
  String? call(String? value) {
    return isValid(value) ? null : errorText;
  }
}
