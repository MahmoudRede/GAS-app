class ServiceModel {
  String? title;
  int? price ;
  String? image ;
  String? uId ;
  bool? favorite;


  ServiceModel ({
    required this.title ,
    required this.price,
    required this.image,
    required this.uId ,
    required this.favorite ,

  });

  ServiceModel.fromFire(Map <String , dynamic> fire){
    title = fire['title'];
    price = fire['price'];
    image = fire['image'];
    uId = fire['uId'];
    favorite = fire['favorite'];

  }

  Map <String , dynamic> toMap ()
  {
    return{
      'title' : title,
      'uId' : uId,
      'price' : price,
      'image' : image,
      'favorite' : favorite,
    };
  }

}