
import 'package:exchange/Data/api/api.dart';
import 'package:exchange/Data/models/AllCryptoModel.dart';

class CryptoDataRepository{

  var response;
  DataUrl api = DataUrl();
  late AllCryptoModel dataFuture;


  Future<AllCryptoModel> getTopGainerData() async {
    response = await api.getTopGainerData();
    dataFuture = AllCryptoModel.fromJson(response.data);

    return dataFuture;
  }

  Future<AllCryptoModel> getTopLoserData() async {
    response = await api.getTopLosersData();
    dataFuture = AllCryptoModel.fromJson(response.data);

    return dataFuture;
  }

  Future<AllCryptoModel> getTopMarketCapData() async {
    response = await api.getTopMarketCapData();
    dataFuture = AllCryptoModel.fromJson(response.data);

    return dataFuture;
  }

  Future<AllCryptoModel> getAllCryptoData() async {
    response = await api.getAllCryptoData();
    dataFuture = AllCryptoModel.fromJson(response.data);

    return dataFuture;
  }


}