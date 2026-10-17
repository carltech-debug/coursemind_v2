import 'package:cloud_functions/cloud_functions.dart';

class InstitutionVerificationService {
  InstitutionVerificationService({
    FirebaseFunctions? firebaseFunctions,
  }) : _firebaseFunctions =
            firebaseFunctions ?? FirebaseFunctions.instance;

  final FirebaseFunctions _firebaseFunctions;

  Future<StartVerificationResult> startEmailVerification({
    required String email,
  }) async {
    final callable = _firebaseFunctions.httpsCallable(
      'startInstitutionEmailVerification',
    );

    final response = await callable.call({
      'email': email.trim(),
    });

    final data = Map<String, dynamic>.from(
      response.data as Map,
    );

    return StartVerificationResult.fromMap(data);
  }

  Future<VerifyVerificationResult> verifyEmailCode({
    required String verificationSessionId,
    required String code,
  }) async {
    final callable = _firebaseFunctions.httpsCallable(
      'verifyInstitutionEmailCode',
    );

    final response = await callable.call({
      'verificationSessionId': verificationSessionId,
      'code': code.trim(),
    });

    final data = Map<String, dynamic>.from(
      response.data as Map,
    );

    return VerifyVerificationResult.fromMap(data);
  }

  Future<ResendVerificationResult> resendEmailVerification({
    required String verificationSessionId,
    required String email,
  }) async {
    final callable = _firebaseFunctions.httpsCallable(
      'resendInstitutionEmailVerification',
    );

    final response = await callable.call({
      'verificationSessionId': verificationSessionId,
      'email': email.trim(),
    });

    final data = Map<String, dynamic>.from(
      response.data as Map,
    );

    return ResendVerificationResult.fromMap(data);
  }
}

class StartVerificationResult {
  const StartVerificationResult({
    required this.verificationSessionId,
    required this.expiresIn,
  });

  factory StartVerificationResult.fromMap(
    Map<String, dynamic> map,
  ) {
    return StartVerificationResult(
      verificationSessionId:
          map['verificationSessionId'] as String,
      expiresIn: map['expiresIn'] as int,
    );
  }

  final String verificationSessionId;
  final int expiresIn;
}

class VerifyVerificationResult {
  const VerifyVerificationResult({
    required this.verified,
  });

  factory VerifyVerificationResult.fromMap(
    Map<String, dynamic> map,
  ) {
    return VerifyVerificationResult(
      verified: map['verified'] as bool,
    );
  }

  final bool verified;
}

class ResendVerificationResult {
  const ResendVerificationResult({
    required this.verificationSessionId,
    required this.expiresIn,
    required this.resendAvailableIn,
  });

  factory ResendVerificationResult.fromMap(
    Map<String, dynamic> map,
  ) {
    return ResendVerificationResult(
      verificationSessionId:
          map['verificationSessionId'] as String,
      expiresIn: map['expiresIn'] as int,
      resendAvailableIn:
          map['resendAvailableIn'] as int,
    );
  }

  final String verificationSessionId;
  final int expiresIn;
  final int resendAvailableIn;
}