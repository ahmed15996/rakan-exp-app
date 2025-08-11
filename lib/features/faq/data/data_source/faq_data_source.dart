



import '../models/faq_model.dart';

abstract class FaqDataSource {
  Future<List<FaqModel>> getData();

}
