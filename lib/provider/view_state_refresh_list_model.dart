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
      var data = await loadData(pageNum: _currentPageNum);
      if (data.isEmpty) {
        _refreshController.refreshCompleted(resetFooterState: true);
        list.clear();
        setEmpty();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        _refreshController.refreshCompleted();

        if (data.length < pageSize) {
          // 小于分页的数量，禁止上拉加载更多
          _refreshController.loadNoData();
        } else {
          // 防止上次上拉加载更多失败，需要重置状态
          _refreshController.loadComplete();
        }
        setIdle();
      }
    } catch (e) {
      // 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      // 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      _refreshController.refreshFailed();
      setError();
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<T>?> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        _refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < pageSize) {
          _refreshController.loadNoData();
        } else {
          _refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e) {
      _currentPageNum--;
      _refreshController.loadFailed();
      return null;
    }
  }

  /// 加载数据
  ///
  /// [pageNum] 页码
  Future<List<T>> loadData({int pageNum});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
