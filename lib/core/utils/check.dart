class Check{
  bool isInteger(dynamic number) {
    return number.isFinite && number == number.floor();
  }


  bool number(dynamic x){
    try{
      int.parse(x.toString());
      return true;
    }catch(e){
      return false;
    }
  }

}