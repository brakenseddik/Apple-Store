import 'package:planety_app/models/payment_model.dart';
import 'package:planety_app/repository/repository.dart';

class PaymentController {
  Repository? _repository;

  PaymentController() {
    _repository = Repository();
  }

  makePayment(PaymentModel payment) async {
    return await _repository!.httpPost('make-payment', payment.toJson());
  }
}
