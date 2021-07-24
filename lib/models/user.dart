import 'dart:async';

class UserStream {
  // ignore: avoid_init_to_null
  static dynamic user = null;
  // static List<User> state = [];
  // static void addState (user) => state.add(user);
  static dynamic get onStateChaned => user;

  static StreamController<User?> userController = new StreamController<User?>();
  static Stream<User?> get stream => userController.stream;
  static void closeStream() {
    userController.close();
  }
}

class User {
  // gender: 1=nam, 2=nữ, 0= ko biết;
  User({required this.userName, required this.birthDay, required this.gender});
  String userName;
  DateTime birthDay;
  int gender;

  void login() {
    UserStream.user = this;
    UserStream.userController.sink.add(this);
  }

  void logout() {
    UserStream.user = null;
    UserStream.userController.sink.add(null);
  }

  // void changeInfo({required uname, required birth, required gender}) {
  //   this.userName = uname;
  //   this.birthDay = birth;
  //   this.gender = gender;
  //   UserStream.user = this;
  //   UserStream.userController.sink.add(UserStream.user);
  // }

  User.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        birthDay = DateTime.parse(json['birthDay']),
        gender = json['gender'];

  Map<String, dynamic> toJson() =>
      {'userName': userName, 'birthDay': birthDay.toString(), 'gender': gender};
}

// main(List<String> args) {
//   User u1 = new User(birthDay: DateTime.now(), userName: 'Van Teo');
//   User u2 = new User(birthDay: DateTime(1999, 8, 9), userName: 'Van Lam');
//   print(UserStream.onStateChaned);
//   u2.login();
//   print(UserStream.onStateChaned);
// }
