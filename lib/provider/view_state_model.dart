import 'package:flutter/material.dart';

enum ViewState {
  idle, // 空闲状态
  loading, // 加载中
  empty, // 无数据
  error, // 加载失败
}

class ViewStateModel with ChangeNotifier {
  /// 防止页面销毁后，异步任务才执行完，导致报错
  bool _disposed = false;

  /// 当前的页面状态,默认为idle,可在viewModel的构造方法中指定;
  ViewState _viewState;

  ViewStateModel({ViewState? state}) : _viewState = state ?? ViewState.idle;

  /// 根据状态构造ViewStateModel
  ///
  /// 子类可以在构造函数指定需要的页面状态
  ViewState get viewState => _viewState;

  set viewState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }

  /// 以下变量是为了代码书写方便,加入的get方法.严格意义上讲,并不严谨
  ///
  /// get
  bool get isLoading => viewState == ViewState.loading;

  bool get isIdle => viewState == ViewState.idle;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  /// set
  void setIdle() {
    viewState = ViewState.idle;
  }

  void setLoading() {
    viewState = ViewState.loading;
  }

  void setEmpty() {
    viewState = ViewState.empty;
  }

  void setError() {
    viewState = ViewState.error;
  }

  @override
  void notifyListeners() {
    // 页面未销毁才通知监听
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
