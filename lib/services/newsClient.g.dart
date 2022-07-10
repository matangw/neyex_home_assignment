// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'newsClient.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _NewsClient implements NewsClient {
  _NewsClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://newsapi.org/v2/top-headlines';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Article>> fetchItems(apiKey, category, country, q) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'apikey': apiKey,
      r'category': category,
      r'country': country,
      r'q': q
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    try{
    final _result = await _dio.get(
      baseUrl as String ,
      queryParameters: queryParameters,
      options: Options(
        extra: _extra,
        headers: _headers,
        method: 'GET',
        contentType: 'application/json; charset=utf-8',
          responseType: ResponseType.json,

      )
    );

    List<Article> value = [];
    List<dynamic> jsonList = _result.data['articles'];
    for(var j in jsonList){
      value.add(Article.fromJson(j));
    }
    return value;
    }
    catch(err) {
      print(err);
      return [];
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
