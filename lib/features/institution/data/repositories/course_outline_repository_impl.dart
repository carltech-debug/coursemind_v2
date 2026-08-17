import '../../domain/entities/course_outline.dart';
import '../../domain/repositories/course_outline_repository.dart';
import '../datasources/course_outline_firestore_datasource.dart';
import '../models/course_outline_model.dart';

final class CourseOutlineRepositoryImpl
    implements CourseOutlineRepository {
  CourseOutlineRepositoryImpl({
    required this._dataSource,
  });

  final CourseOutlineFirestoreDataSource _dataSource;

  @override
  Future<void> createCourseOutline(
    CourseOutline outline,
  ) {
    return _dataSource.createCourseOutline(
      CourseOutlineModel(
        id: outline.id,
        institutionId: outline.institutionId,
        programmeId: outline.programmeId,
        levelId: outline.levelId,
        semesterId: outline.semesterId,
        courseId: outline.courseId,
        title: outline.title,
        topics: outline.topics,
        description: outline.description,
        version: outline.version,
        isActive: outline.isActive,
      ),
    );
  }

  @override
  Future<List<CourseOutline>> getCourseOutlines({
    required String institutionId,
    required String programmeId,
    required String levelId,
    required String semesterId,
    required String courseId,
  }) {
    return _dataSource.getCourseOutlines(
      institutionId: institutionId,
      programmeId: programmeId,
      levelId: levelId,
      semesterId: semesterId,
      courseId: courseId,
    );
  }
}