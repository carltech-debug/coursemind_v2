import '../entities/user_profile.dart';
import '../repositories/user_profile_repository.dart';

class CreateUserProfile {
  CreateUserProfile({
    required this.repository,
  });

  final UserProfileRepository repository;

  Future<void> call(UserProfile profile) {
    return repository.createProfile(profile);
  }
}