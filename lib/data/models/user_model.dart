class UserModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? address;
  String? location;
  int? totalPrice ;
  int? uId ;
  bool? selected;
  bool? done;


  UserModel ({
    required this.firstName ,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.location,
    required this.address,
    required this.totalPrice,
    required this.uId ,
    required this.selected ,
    required this.done ,

  });

  UserModel.fromFire(Map <String , dynamic> fire){
    firstName = fire['firstName'];
    lastName = fire['lastName'];
    address = fire['address'];
    phoneNumber = fire['phoneNumber'];
    email = fire['email'];
    totalPrice = fire['totalPrice'];
    uId = fire['uId'];
    selected = fire['selected'];
    location = fire['location'];
    done = fire['done'];

  }

  Map <String , dynamic> toMap ()
  {
    return{
      'firstName' : firstName,
      'lastName' : lastName,
      'phoneNumber' : phoneNumber,
      'address' : address,
      'email' : email,
      'location' : location,
      'totalPrice' : totalPrice,
      'uId' : uId,
      'selected' : selected,
      'done' : done,
    };
  }

}