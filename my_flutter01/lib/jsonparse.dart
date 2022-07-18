import 'package:json_annotation/json_annotation.dart';
import 'address.dart';
part 'jsonparse.g.dart';

@JsonSerializable(explicitToJson:true)
class User {
  String name;
  String email;
  @JsonKey(name: 'my_first_key')
  String myFirstName;
  @JsonKey(defaultValue: false)
  bool isAdult;
  @JsonKey(required: true)
  String id;

  Address address;

  User(this.id,this.isAdult,this.name, this.email, this.myFirstName,this.address);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}



void main(){
  Address address = Address('My st.', 'New York');
  User user = User('John',false,"ss","hah","2323", address);
  print(user.toJson());
}



