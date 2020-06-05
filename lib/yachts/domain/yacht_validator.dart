class NameFieldValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Please provide a name.';
    }
    return null;
  }
}


class ImoFieldValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Please provide an IMO.';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid number.';
    }
    if (int.parse(value) <= 0) {
      return 'Please enter a number greater than zero.';
    }
    return null;
  }
}


class LengthFieldValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Please provide a length.';
    }
    if (double.tryParse(value) == null) {
      return 'Please enter a valid number.';
    }
    if (double.parse(value) <= 0) {
      return 'Please enter a number greater than zero.';
    }
    return null;
  }
}
