import 'package:dio/dio.dart';
import 'package:frontend/services/home/models/data/home_model.dart';
import 'package:frontend/services/home/models/dto/add_home_request_dto_model.dart';
import 'package:frontend/services/home/models/dto/home_detail_response_dto.dart';
import 'package:frontend/services/home/models/dto/share_home_request_dto.dart';
import 'package:frontend/services/home/models/dto/unshare_home_request_dto.dart';

class HomeService {
  final Dio dio;

  HomeService(this.dio);

  Future<List<Home>> fetchHomes() async {
    final response = await dio.get('/home');
    final List data = response.data;
    return data.map((json) => Home.fromJson(json)).toList();
  }

  Future<HomeDetailResponseDto> getHomeDetail(int homeId) async {
    final response = await dio.get('/home/$homeId');
    return HomeDetailResponseDto.fromJson(response.data);
  }

  Future<void> addHome(AddHomeRequestDTO request) async {
    await dio.post('/home', data: request.toJson());
  }

  Future<void> deleteHome(int homeId) async {
    await dio.delete('/home/$homeId');
  }

  Future<void> shareHome(int homeId, ShareHomeRequestDTO request) async {
    await dio.post('/home/$homeId/share', data: request.toJson());
  }

  Future<void> removeSharingHome(
    int homeId,
    UnshareHomeRequestDTO request,
  ) async {
    await dio.delete('/home/$homeId/share', data: request.toJson());
  }
}
