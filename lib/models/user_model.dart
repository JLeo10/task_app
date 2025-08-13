// lib/models/user_model.dart
class UserModel {
  final String uid;
  final String nombre;
  final String email;

  UserModel({required this.uid, required this.nombre, required this.email});

  // Constructor para crear un usuario desde un mapa (Firestore)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      nombre: json['nombre'],
      email: json['email'],
    );
  }

  // Método para convertir el usuario a un mapa (para Firestore)
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'nombre': nombre, 'email': email};
  }
}
