class OrderModel {
  String? title;
  String? price ;
  String? image ;
  String? number;


  OrderModel ({
    required this.title ,
    required this.price,
    required this.image,
    required this.number ,

  });

  OrderModel.fromFire(Map <String , dynamic> fire){
    title = fire['title'];
    price = fire['price'];
    image = fire['image'];
    number = fire['number'];

  }

  Map <String , dynamic> toMap ()
  {
    return{
      'title' : title,
      'price' : price,
      'image' : image,
      'number' : number,
    };
  }

}