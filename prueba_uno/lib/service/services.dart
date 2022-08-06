import 'dart:convert';
import 'package:api/api.dart';
import 'package:separate_api/service/service_interface.dart';

class Services implements ServiceI {
  final Api api;

  Services(this.api);

  @override
  getProducts() async {
    return {"result": jsonDecode((await api.getProducts()).body)["result"]};
  }

  @override
  getCoupon(String code) async {
    return {"result": jsonDecode((await api.getCoupon(code)).body)["result"]};
  }
}
