import 'dart:math';

class AppConstants {
  static const localhot = "100.88.19.23";
  // static const localhot = "localhost";
  static const String baseUrl = "http://$localhot:8087";
  static const String apiUrl = "$baseUrl/api/";

  static String generateRandomCode(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz123456788';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}
