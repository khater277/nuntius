import 'package:dio/dio.dart';
import 'package:nuntius/core/apis/agora/agora_end_points.dart';
import 'package:nuntius/features/messages/data/models/agora_token/agora_token_model/agora_token_model.dart';
import 'package:retrofit/retrofit.dart';

part 'agora_api.g.dart';

@RestApi(baseUrl: AgoraEndPoints.baseUrl)
abstract class AgoraApi {
  factory AgoraApi(Dio dio, {String baseUrl}) = _AgoraApi;

  // @GET("test/publisher/uid/1")
  @GET("{channel}/publisher/uid/{uid}")
  Future<AgoraTokenModel> generateToken(
    @Path() String channel,
    @Path() String uid,
  );
}
