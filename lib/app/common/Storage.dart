import 'package:get_storage/get_storage.dart';

class Storage {
  const Storage._();

  static final _storage = GetStorage();

  static T? get<T>(String key) {
    return _storage.read<T>(key);
  }

  static bool hasData(String key) {
    return _storage.hasData(key);
  }

  static void save<T>(String key, T value) {
    _storage.write(key, value);

  }

  static void clear(){
    _storage.erase();
  }
}
