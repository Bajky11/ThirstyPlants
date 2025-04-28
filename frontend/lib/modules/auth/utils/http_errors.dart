import 'package:dio/dio.dart';

String parseDioError(DioException e, {String fallback = 'Chyba při komunikaci se serverem'}) {
  final errorResponse = e.response?.data;
  print(e.response);
  return errorResponse is Map && errorResponse['error'] != null
      ? errorResponse['error'].toString()
      : fallback;
}