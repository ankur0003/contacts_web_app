class GetResponse<T>{

  List<T> list = [];
  GetResponse.fromJson(List<dynamic> data, T Function(dynamic elementJson) json){
    for(var elements in data){
      list.add(json(elements));
    }
  }

}