import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:yatrigan/controller/handle_errors_api.dart';
import 'package:yatrigan/controller/rest_api.dart';
import 'package:yatrigan/model/main/ir/station/ir_station_list_mdl.dart';
import 'package:yatrigan/model/main/ir/station/shops/info/ir_shop_info_res_mdl.dart';
import 'package:yatrigan/model/main/ir/station/shops/list/ir_shop_list_obj_res_mdl.dart';
import 'package:yatrigan/model/main/ir/station/shops/list/ir_shops_list_res_mdl.dart';
import 'package:yatrigan/model/main/ir/train/ir_train_list_mdl.dart';
import 'package:yatrigan/model/main/ir/train/schedule/ir_train_shdl_res_mdl.dart';

class IrCtrlApi extends HandleErrorsApi {
  Future<IrStationListMdl?> getSearchStationListApi({
    required BuildContext context,
    required bool showError,
  }) async {
    super.context = context;
    super.showError = showError;
    IrStationListMdl? res;
    if (await checkInternetConnectivity()) {
      var response = await http.get(
        Uri.parse(IrApiUri.stations.uri),
      );
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        res = IrStationListMdl.fromJson(json);
      }
      //TODO: Handle errors if not response not serialized
    }
    return res;
  }

  Future<IrShopListResMdl?> getShopListApi({
    required BuildContext context,
    required bool showError,
    required String stationCode,
  }) async {
    super.context = context;
    super.showError = showError;
    IrShopListResMdl? res;
    if (await checkInternetConnectivity()) {
      String uri = IrApiUri.stationShopList.uri;
      uri = uri.replaceAll("<code>", stationCode);
      var response = await http.get(
        Uri.parse(uri),
      );
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        res = IrShopListResMdl.success(json);
      } else if (response.statusCode == 400) {
        res = IrShopListResMdl.fail(json);
      }
      //TODO: Handle errors if not response not serialized
    }
    return res;
  }

  Future<IrShopInfoResMdl?> getShopInfoApi({
    required BuildContext context,
    required bool showError,
    required String stationCode,
    required IrShopListObjResMdl shop,
  }) async {
    super.context = context;
    super.showError = showError;
    IrShopInfoResMdl? res;
    if (await checkInternetConnectivity()) {
      String uri = IrApiUri.stationShopInfo.uri;
      uri = uri.replaceAll("<code>", stationCode);
      uri = uri.replaceAll("<id>", shop.id);
      var response = await http.get(
        Uri.parse(uri),
      );
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        res = IrShopInfoResMdl.success(json);
      } else if (response.statusCode == 400) {
        res = IrShopInfoResMdl.fail(json);
      }
      //TODO: Handle errors if not response not serialized
    }
    return res;
  }

  Future<IrTrainListMdl?> getSearchTrainListApi({
    required BuildContext context,
    required bool showError,
  }) async {
    super.context = context;
    super.showError = showError;
    IrTrainListMdl? res;
    if (await checkInternetConnectivity()) {
      var response = await http.get(
        Uri.parse(IrApiUri.trains.uri),
      );
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        res = IrTrainListMdl.fromJson(json);
      }
      //TODO: Handle errors if not response not serialized
    }
    return res;
  }

  Future<IrTrainShdlResMdl?> getTrainShdlApi({
    required BuildContext context,
    required bool showError,
    required String trainNo,
  }) async {
    super.context = context;
    super.showError = showError;
    IrTrainShdlResMdl? res;
    if (await checkInternetConnectivity()) {
      var response =
          await http.get(Uri.parse(IrApiUri.trainShdl.uri), headers: {
        'train': trainNo,
      });
      var json = jsonDecode(response.body);
      if (response.statusCode == 200) {
        res = IrTrainShdlResMdl.success(json);
      } else if (response.statusCode == 400) {
        res = IrTrainShdlResMdl.fail(json);
      }
      //TODO: Handle errors if not response not serialized
    }
    return res;
  }
}
