import 'package:cached_query/cached_query.dart';
import 'package:frontend/modules/core/dio/dio_client.dart';
import 'package:frontend/services/home/home_service.dart';
import 'package:frontend/services/home/models/data/home_model.dart';
import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:frontend/state/app/app_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_query.g.dart';

/*
final Query<List<Home>> homesQuery = Query<List<Home>>(
  key: 'homes',
  queryFn: () async {
    final service = HomeService(dio);
    return await service.fetchHomes();
  },
);
*/

// usage: final homesQuery = ref.watch(homesQueryProvider);
@riverpod
Query<List<Home>> homesQuery(Ref ref) {
  return Query(
    key: 'homes',
    queryFn: () async {
      final service = HomeService(dio);
      return await service.fetchHomes();
    },
  );
}
