import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';

class GetUserProfile {
  GetUserProfile({
    required this.repository,
  });

  final UserProfileRepository repository;

  Future<UserProfile?> call(String uid) {
    return repository.getProfile(uid);
  }
}