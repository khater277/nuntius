import 'package:dio/dio.dart';
import 'package:nuntius/core/apis/fcm/fcm_end_points.dart';
import 'package:retrofit/retrofit.dart';

part 'fcm_api.g.dart';

@RestApi(baseUrl: FcmEndPoints.baseUrl)
abstract class FcmApi {
  factory FcmApi(Dio dio, {String baseUrl}) = _FcmApi;

  @POST('')
  Future<Map<String, dynamic>> pushNotification({
    @Body() required Map<String, dynamic> fcmBody,
  });
}
