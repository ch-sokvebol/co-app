import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/loan_arrear_respone_model.dart';

part 'restrofit_arrear.g.dart';

@RestApi(baseUrl: "http://45.115.209.191:2020/api/")
abstract class ApiServiceArrear {
  factory ApiServiceArrear(Dio dio, {String baseUrl}) = _ApiServiceArrear;

  @POST("LoanArrear/arrear")
  Future<List<LoanAreaResponseModel>> searchArea(
      @Body() Map<String, dynamic> body);
}
