import 'package:planety_app/models/shipping_model.dart';
import 'package:planety_app/repository/remote_service.dart';

class ShippingController {
  Repository? _repository;
  ShippingController() {
    _repository = Repository();
  }
  addShipping(ShippingModel shipping) async {
    return await _repository!.httpPost('shipping', shipping.toJson());
  }
}
