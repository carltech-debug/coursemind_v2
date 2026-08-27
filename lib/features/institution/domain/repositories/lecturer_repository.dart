import '../entities/lecturer.dart';

abstract interface class LecturerRepository {
  Future<void> createLecturer(Lecturer lecturer);

  Future<List<Lecturer>> getLecturers(String institutionId);
}