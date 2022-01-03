import 'package:flutter/foundation.dart';

class IsLoginPage with ChangeNotifier {
  bool _isLogin = true;
  bool get isLogin => _isLogin;

  void changeLoginState() {
    _isLogin = !_isLogin;
    notifyListeners();
  }
}

class LoadingState with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void changeLoadingState(bool state) {
    _isLoading = state;
    notifyListeners();
  }
}

class SearchQuery with ChangeNotifier {
  String _title = "";
  String get title => _title;

  void changeSearchTitle(String t) {
    _title = t;
    notifyListeners();
  }
}

class DeleteContact with ChangeNotifier {
  bool _del = false;

  bool get del => _del;

  toggleDel() {
    _del = !_del;
    notifyListeners();
  }
}

class PageProvider with ChangeNotifier {
  int _page = 0;
  int get page => _page;

  changePage(int i) {
    _page = i;
    notifyListeners();
  }
}
