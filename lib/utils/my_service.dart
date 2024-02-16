import 'package:localstorage/localstorage.dart';

class MyService {
  final LocalStorage storage = new LocalStorage('user_data');

  static MyService get instance => _instance;

  MyService._internal();

  static MyService _instance = MyService._internal();
}