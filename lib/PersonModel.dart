/// name : "Ansar Ali"
/// age : 12
/// gender : "Female"

class PersonModel {
  PersonModel({
      String? name, 
      int? age, 
      String? gender,}){
    _name = name;
    _age = age;
    _gender = gender;
}

  PersonModel.fromJson(dynamic json) {
    _name = json['name'];
    _age = json['age'];
    _gender = json['gender'];
  }
  String? _name;
  int? _age;
  String? _gender;
PersonModel copyWith({  String? name,
  int? age,
  String? gender,
}) => PersonModel(  name: name ?? _name,
  age: age ?? _age,
  gender: gender ?? _gender,
);
  String? get name => _name;
  int? get age => _age;
  String? get gender => _gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['age'] = _age;
    map['gender'] = _gender;
    return map;
  }

}