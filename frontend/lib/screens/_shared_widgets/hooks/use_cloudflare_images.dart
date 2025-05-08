import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

const cloudlfareAccountId = "3ccdc8be03338be5bcb35eb1c768a1c4";
const cloudflareUploadUrl =
    'https://api.cloudflare.com/client/v4/accounts/$cloudlfareAccountId/images/v1';
const cloudflareToken = 'xLJ8K32fVpGHLqDAlsheMesv7flCjoTvc2LNnV3z';
const cloudflareAccountHash = 'UBZWeFQQoLk6g5JDQWgvdQ';

typedef CloudflareImagesHook =
    ({
      Future<bool> Function(String imageId) deleteImage,
      Future<String?> Function(XFile? image) uploadImage,
      ValueNotifier<bool> loading,
    });

CloudflareImagesHook useCloudflareImages() {
  final loading = useState<bool>(false);

  Future<bool> deleteImage(String imageId) async {
    loading.value = true;

    final response = await http.delete(
      Uri.parse('$cloudflareUploadUrl/$imageId'),
      headers: {'Authorization': 'Bearer $cloudflareToken'},
    );

    loading.value = false;

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to delete image: ${response.body}');
      return false;
    }
  }

  Future<String?> uploadImage(XFile? image) async {
    if (image == null) return null;

    loading.value = true;

    final uri = Uri.parse(cloudflareUploadUrl);

    final request =
        http.MultipartRequest('POST', uri)
          ..headers['Authorization'] = 'Bearer $cloudflareToken'
          ..files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();

    loading.value = false;

    if (response.statusCode == 200) {
      final respStr = await response.stream.bytesToString();
      final jsonResp = jsonDecode(respStr);
      final id = jsonResp['result']['id'];

      return id;
    } else {
      print('Upload failed: ${response.statusCode}');
      return null;
    }
  }

  return (deleteImage: deleteImage, uploadImage: uploadImage, loading: loading);
}
