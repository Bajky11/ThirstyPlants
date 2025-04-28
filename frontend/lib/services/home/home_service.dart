import 'package:dio/dio.dart';
import 'package:frontend/services/home/models/data/home_model.dart';

class HomeService {
  final Dio dio;

  HomeService(this.dio);

  Future<List<Home>> fetchHomes() async {
    final response = await dio.get('/home');
    final List data = response.data;
    return data.map((json) => Home.fromJson(json)).toList();
  }
}
