import 'package:flutter_common/provider/view_state_model.dart';

/// 基于ViewStateModel的列表Provider
abstract class ViewStateListModel<T> extends ViewStateModel {
  /// 数据数据
  List<T> list = [];

  initData() async {
    setLoading();
    await refresh(init: true);
  }

  refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setIdle();
      }
    } catch (e) {
      if (init) list.clear();
      setError();
    }
  }

  /// 数据加载完成
  void onCompleted(List<T> data) {}

  /// 加载数据
  Future<List<T>> loadData();
}
