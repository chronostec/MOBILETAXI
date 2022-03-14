class Sales {
  var price;
  var cars;
  var createdat;

  Sales({this.price, this.cars,this.createdat});

  Sales.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    cars = json['cars'];
    createdat = json['createdat'];
  }
}
