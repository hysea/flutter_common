/// 接口返回的基础 Response 类
///
/// 子类需要重写
abstract class BaseResponseData {
  int code;
  String? message;
  dynamic? data;

  bool get success;

  BaseResponseData({this.code = 0, this.message, this.data});

  @override
  String toString() {
    return 'BaseResponse{code: $code, message: $message, data: $data}';
  }
}

/// BaseResponse 默认实现
///
/// 若不满足业务需求，需自定义ResponseData
class DefaultResponseData extends BaseResponseData {
  @override
  bool get success => code == 0;

  DefaultResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }
}
