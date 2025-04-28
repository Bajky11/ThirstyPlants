import 'package:cached_query/cached_query.dart';
import 'package:frontend/modules/core/dio/dio_client.dart';
import 'package:frontend/services/flower/flower_service.dart';
import 'package:frontend/services/flower/models/dto/add_flower_request_dto_model.dart';
import 'package:frontend/services/flower/models/data/flower_model.dart';
import 'package:frontend/services/flower/models/dto/flower_response_dto.dart';
import 'package:frontend/services/flower/models/dto/update_flower_request_dto_model.dart';

Query<List<FlowerResponseDTO>> flowersQuery(int homeId) =>
    Query<List<FlowerResponseDTO>>(
      key: ["flowers", homeId],
      queryFn: () async {
        return await FlowerService(dio).fetchFlowersByHomeId(homeId);
      },
    );

Mutation<void, AddFlowerRequestDTO> addFlowerMutation(int homeId) {
  return Mutation<void, AddFlowerRequestDTO>(
    // Zanoření do hranatých závorek
    // Pokud by byli klíče pouhé stringy, nebylo by třeba to takto zanořovat, ale strukturované klíče je třeba
    // V dokumentaci je to popsáno slovy „Pass a list of query keys to invalidateQueries“ – tj. list klíčů, ne list řetězců.
    refetchQueries: [
      ['flowers', homeId],
    ],
    queryFn: (dto) => FlowerService(dio).addFlower(dto),
  );
}

Mutation<void, UpdateFlowerRequestDTO> updateFlowerMutation(
  int flowerId,
  int homeId,
) {
  return Mutation<void, UpdateFlowerRequestDTO>(
    refetchQueries: [
      ['flowers', homeId],
    ],
    queryFn: (dto) => FlowerService(dio).updateFlower(flowerId, dto),
  );
}
