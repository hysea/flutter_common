import 'package:flutter_common/provider/view_state_list_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 基于Refresh刷新的Model
abstract class ViewStateRefreshListModel<T> extends ViewStateListModel<T> {
  /// 分页第一页页码
  static const int pageNumFirst = 0;

  /// 分页条目数量
  static const int pageSize = 20;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 下拉刷新
  Future<List<T>?> refresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      
      var data = await loadData(_currentPageNum);

    } catch (e) {
      if (init) list.clear();
      _refreshController.refreshFailed();
      setError();
      return null;
    }
  }

  /// 加载数据
  ///
  /// [pageNum] 页面
  Future<List<T>> loadData({int pageNum});
}
