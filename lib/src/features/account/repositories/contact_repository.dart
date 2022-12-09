import 'package:dio/dio.dart';
import 'package:lady_skin/src/features/account/models/contact.dart';
import 'package:lady_skin/src/utils/services/api_provider.dart';

class ContactRepository {
  Future<Contact> getContact() async {
    ApiProvider apiProvider = ApiProvider();
    try {
      Response response = (await apiProvider.get(
          "https://chamreungphal.anakutjobs.com/anakut/public/api/setting",
          null,
          null))!;
      return Contact.fromJson(response.data["data"]);
    } catch (e) {
      throw e;
    }
  }
}
