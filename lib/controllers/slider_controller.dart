import 'package:planety_app/repository/repository.dart';

class SliderController {
  late Repository _repository;
  SliderController() {
    _repository = Repository();
  }

  getSliders() async {
    return await _repository.httpGet('sliders');
  }
}
