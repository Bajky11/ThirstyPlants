import 'package:cached_query/cached_query.dart';
import 'package:frontend/modules/core/dio/functions.dart';
import 'package:frontend/services/home/home_service.dart';
import 'package:frontend/services/home/models/data/home_model.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:frontend/services/home/models/dto/add_home_request_dto_model.dart';
import 'package:frontend/services/home/models/dto/home_detail_response_dto.dart';
import 'package:frontend/services/home/models/dto/share_home_request_dto.dart';
import 'package:frontend/services/home/models/dto/unshare_home_request_dto.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_query.g.dart';

// usage: final homesQuery = ref.watch(homesQueryProvider);
@riverpod
Query<List<Home>> homesQuery(Ref ref) {
  return Query(
    key: 'homes',
    queryFn: () async {
      final service = HomeService(await getDio());
      return await service.fetchHomes();
    },
  );
}

Mutation<void, AddHomeRequestDTO> addHomeMutation() {
  return Mutation<void, AddHomeRequestDTO>(
    refetchQueries: ["homes"],
    queryFn: (dto) async => HomeService(await getDio()).addHome(dto),
  );
}

Mutation<void, int> deleteHomeMutation() {
  return Mutation<void, int>(
    refetchQueries: ["homes"],
    queryFn:
        (int homeId) async => HomeService(await getDio()).deleteHome(homeId),
  );
}

Query<HomeDetailResponseDto> homeDetailQuery(WidgetRef ref, int homeId) {
  return Query(
    key: 'home-detail-$homeId',
    queryFn: () async {
      return await HomeService(await getDio()).getHomeDetail(homeId);
    },
  );
}

Mutation<void, ShareHomeRequestDTO> shareHomeMutation(int homeId) {
  return Mutation<void, ShareHomeRequestDTO>(
    refetchQueries: ["home-detail-$homeId"],
    queryFn: (dto) async => HomeService(await getDio()).shareHome(homeId, dto),
  );
}

Mutation<void, UnshareHomeRequestDTO> removeSharingHomeMutation(int homeId) {
  return Mutation<void, UnshareHomeRequestDTO>(
    refetchQueries: ["home-detail-$homeId"],
    queryFn:
        (dto) async =>
            HomeService(await getDio()).removeSharingHome(homeId, dto),
  );
}
