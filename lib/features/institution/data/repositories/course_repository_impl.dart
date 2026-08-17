import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';
import '../datasources/course_firestore_datasource.dart';
import '../models/course_model.dart';

final class CourseRepositoryImpl implements CourseRepository {
  CourseRepositoryImpl({
    required this._dataSource,
  });

  final CourseFirestoreDataSource _dataSource;

  @override
  Future<void> createCourse(Course course) {
    return _dataSource.createCourse(
      CourseModel(
        id: course.id,
        institutionId: course.institutionId,
        programmeId: course.programmeId,
        levelId: course.levelId,
        semesterId: course.semesterId,
        name: course.name,
        code: course.code,
        description: course.description,
        creditHours: course.creditHours,
        isActive: course.isActive,
      ),
    );
  }

  @override
  Future<List<Course>> getCourses({
    required String institutionId,
    required String programmeId,
    required String levelId,
    required String semesterId,
  }) {
    return _dataSource.getCourses(
      institutionId: institutionId,
      programmeId: programmeId,
      levelId: levelId,
      semesterId: semesterId,
    );
  }
}