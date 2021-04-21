class Food {
  int id;
  String username;
  String food;

  Food({this.id, this.username, this.food});

  factory Food.fromJSON(Map<String, dynamic> json) {
    return Food(
      id: json['id'] as int,
      username: json['username'] as String,
      food: json['food'] as String,
    );
  }
}
