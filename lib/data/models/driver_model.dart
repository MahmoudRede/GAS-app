class DriverModel {
  String? name;
  String? phoneNumber;
  String? email;
  String? uId ;
  bool ?isVerified;


  DriverModel ({
    required this.name ,
    required this.phoneNumber,
    required this.email,
    required this.uId ,
    required this.isVerified ,
  });

  DriverModel.fromFire(Map <String , dynamic> fire){
    name = fire['name'];
    phoneNumber = fire['phoneNumber'];
    email = fire['email'];
    uId = fire['uId'];
    isVerified = fire['isVerified'];

  }

  Map <String , dynamic> toMap ()
  {
    return{
      'name' : name,
      'phoneNumber' : phoneNumber,
      'email' : email,
      'uId' : uId,
      'isVerified' : isVerified,
    };
  }

}