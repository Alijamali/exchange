import 'package:exchange/Data/api/api.dart';
import 'package:exchange/Data/models/AllCryptoModel.dart';
import 'package:flutter/cupertino.dart';

import 'package:exchange/Data/models/ResponseModel.dart';

import 'package:exchange/Data/repositories/CryproDataRepository.dart';

class CryptoDataProvider extends ChangeNotifier {
  late AllCryptoModel _dataFuture;
  late ResponseModel _state;
  var _defaultChoiceIndex = 0;

  AllCryptoModel get dataFuture => _dataFuture;
  ResponseModel get state => _state;
  get defaultChoiceIndex => _defaultChoiceIndex;



  CryptoDataRepository repository = CryptoDataRepository();


  CryptoDataProvider() {
    getTopMarketCapData();
  }

  getTopMarketCapData() async {
    _defaultChoiceIndex = 0;
    _state = ResponseModel.loading("is Loading...");
    notifyListeners();

    try {
      _dataFuture = await repository.getTopMarketCapData();
      _state = ResponseModel.completed(_dataFuture);
      notifyListeners();
    } catch (e) {
      _state = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }

  getTopGainersData() async {
    _defaultChoiceIndex = 1;
    _state = ResponseModel.loading("is Loading...");
    notifyListeners();

    try {
      _dataFuture = await repository.getTopGainerData();
      _state = ResponseModel.completed(_dataFuture);
      notifyListeners();
    } catch (e) {
      _state = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }

  getTopLosersData() async {
    _defaultChoiceIndex = 2;
    _state = ResponseModel.loading("is Loading...");
    notifyListeners();

    try {
      _dataFuture = await repository.getTopLoserData();
      _state = ResponseModel.completed(_dataFuture);
      notifyListeners();
    } catch (e) {
      _state = ResponseModel.error("please check your connection...");
      notifyListeners();
    }
  }



}
