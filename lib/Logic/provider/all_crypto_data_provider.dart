import 'package:exchange/Data/api/api.dart';
import 'package:exchange/Data/models/AllCryptoModel.dart';
import 'package:flutter/cupertino.dart';

import 'package:exchange/Data/models/ResponseModel.dart';

import 'package:exchange/Data/repositories/CryproDataRepository.dart';

class AllCryptoDataProvider extends ChangeNotifier {
  late AllCryptoModel _alldataFuture;
  late ResponseModel _allstate;

  AllCryptoModel get dataFuture => _alldataFuture;
  ResponseModel get state => _allstate;


  CryptoDataRepository repository = CryptoDataRepository();


  AllCryptoDataProvider() {
    getAllMarketCapData();
  }


  getAllMarketCapData() async {

    _allstate = ResponseModel.loading("is Loading...");
    notifyListeners();

    try {
      _alldataFuture = await repository.getAllCryptoData();
      _allstate = ResponseModel.completed(_alldataFuture);
      notifyListeners();
    } catch (e) {
      _allstate = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }


}
