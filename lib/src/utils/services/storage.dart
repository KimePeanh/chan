import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final storage = FlutterSecureStorage();
  Future<void> saveToken({required String token}) async {
    await storage.deleteAll();
    // await storage.write(key: 'name', value: user.name);
    // await storage.write(key: 'phone', value: user.phone);
    await storage.write(key: 'token', value: token);
    // await storage.write(key: 'id', value: user.id);
    // await storage.write(key: 'verifyStatus', value: user.verifyStatus);
  }

  Future<String?> getToken() async {
    // String name = await storage.read(key: 'name');
    // String phone = await storage.read(key: 'phone');
    String? token = await storage.read(key: 'token');
    // String id = await storage.read(key: 'id');
    // String verifyStatus = await storage.read(key: 'verifyStatus');
    // if (name != null &&
    //     phone != null &&
    //     token != null &&
    //     id != null &&
    //     verifyStatus != null)
    return token;
  }

  Future<void> removeToken() async {
    await storage.deleteAll();
    return;
  }

  // Future<void> saveSearchHistory({@required String history}) async {
  //   await storage.write(key: "searchHistory", value: history);
  //   return;
  // }

  // Future<String> getSearchHistory() async {
  //   return await storage.read(key: 'searchHistory');
  // }
}
