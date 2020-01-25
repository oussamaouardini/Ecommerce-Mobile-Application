class RedirectionFound{
  @override
  String toString() {
    return " Too many Redirection. " ;
  }
}


class ResourceNotFound implements Exception {

  String message ;
  ResourceNotFound(this.message);


  @override
  String toString() {
    return "Resource ${this.message} Not Found";
  }
}


class NoInternetException implements Exception{


  @override
  String toString() {
    return 'No Internet Connection Available !!!' ;
  }
}


class PropoertyIsRequired implements Exception {


  String field ;
  PropoertyIsRequired(this.field);

  @override
  String toString() {
    return 'Property ${this.field} is required';
  }


}