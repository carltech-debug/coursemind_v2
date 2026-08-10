import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';

class UpdateUserProfile {
  UpdateUserProfile({
    required this.repository,
  });

  final UserProfileRepository repository;

  Future<void> call(UserProfile profile) {
    return repository.updateProfile(profile);
  }
}