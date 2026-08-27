import '../../domain/entities/lecturer.dart';

class LecturerModel extends Lecturer {
  const LecturerModel({
    required super.userId,
    required super.institutionId,
    required super.name,
    required super.email,
    super.staffId,
    super.isActive,
  });

  factory LecturerModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return LecturerModel(
      userId: map['userId'] as String? ?? '',
      institutionId: map['institutionId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      staffId: map['staffId'] as String?,
      isActive: map['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'institutionId': institutionId,
      'name': name,
      'email': email,
      'staffId': staffId,
      'isActive': isActive,
    };
  }
}