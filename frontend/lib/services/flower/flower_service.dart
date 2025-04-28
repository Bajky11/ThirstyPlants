import 'package:dio/dio.dart';
import 'package:frontend/services/flower/models/dto/add_flower_request_dto_model.dart';
import 'package:frontend/services/flower/models/data/flower_model.dart';
import 'package:frontend/services/flower/models/dto/flower_response_dto.dart';
import 'package:frontend/services/flower/models/dto/update_flower_request_dto_model.dart';

class FlowerService {
  final Dio dio;

  FlowerService(this.dio);

  Future<List<FlowerResponseDTO>> fetchFlowersByHomeId(int homeId) async {
    final res = await dio.get('/flower', queryParameters: {'homeId': homeId});
    return (res.data as List).map((e) => FlowerResponseDTO.fromJson(e)).toList();
  }

  Future<void> addFlower(AddFlowerRequestDTO request) async {
    await dio.post('/flower', data: request.toJson());
  }

  Future<void> updateFlower(
    int flowerId,
    UpdateFlowerRequestDTO request,
  ) async {
    print(request.toJson());
    final a = await dio.patch(
      '/flower',
      queryParameters: {'flowerId': flowerId},
      data: request.toJson(),
    );
  }
}
