class User {
  int id;
  String name;
  String email;

  User({
    this.id = 0,
    this.name = "",
    this.email = "",
  });

  User.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
    'name'  : name,
    'email' : email,
  };
}