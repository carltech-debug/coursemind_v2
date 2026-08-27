import '../../domain/entities/course_assignment.dart';
import '../../domain/repositories/course_assignment_repository.dart';
import '../datasources/course_assignment_firestore_datasource.dart';
import '../models/course_assignment_model.dart';

final class CourseAssignmentRepositoryImpl
    implements CourseAssignmentRepository {
  CourseAssignmentRepositoryImpl({
    required this._dataSource,
  });

  final CourseAssignmentFirestoreDataSource _dataSource;

  @override
  Future<void> createAssignment(
    CourseAssignment assignment,
  ) {
    return _dataSource.createAssignment(
      CourseAssignmentModel(
        id: assignment.id,
        institutionId: assignment.institutionId,
        lecturerId: assignment.lecturerId,
        courseId: assignment.courseId,
        assignedAt: assignment.assignedAt,
        isActive: assignment.isActive,
      ),
    );
  }

  @override
  Future<List<CourseAssignment>> getAssignments({
    required String institutionId,
    String? lecturerId,
    String? courseId,
  }) {
    return _dataSource.getAssignments(
      institutionId: institutionId,
      lecturerId: lecturerId,
      courseId: courseId,
    );
  }
}