import 'package:logger/logger.dart';


class Log {
  static final logger = Logger(
    printer: PrettyPrinter(
      colors: true,
    ),
  );

  // debug mesages
  static void d(message) {
    return logger.d(message);
  }

  // error messages
  static void e(message) {
    return logger.e(message);
  }

  // informational messages
  static void i(message) {
    return logger.i(message);
  }

  // warning messages
  static void w(message) {
    return logger.w(message);
  }

}
