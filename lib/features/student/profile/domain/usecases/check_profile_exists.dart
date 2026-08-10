import '../repositories/user_profile_repository.dart';

class CheckProfileExists {
  CheckProfileExists({
    required this.repository,
  });

  final UserProfileRepository repository;

  Future<bool> call(String uid) {
    return repository.profileExists(uid);
  }
}