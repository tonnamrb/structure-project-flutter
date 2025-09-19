import 'dart:async';

import '../../domain/entities/profile_data.dart';
import 'api_client_service.dart';
import 'logger_service.dart';
import 'secure_storage_service.dart';

class AuthService {
  AuthService({
    required this.apiClient,
    required this.storage,
    required this.logger,
  });

  final ApiClientService apiClient;
  final SecureStorageService storage;
  final LoggerService logger;

  Future<void> sendOtp({required String channel, required String value}) async {
    logger.log('sendOtp channel=$channel value=$value');
    // Simulated network delay.
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }

  Future<bool> verifyOtp(String otp) async {
    logger.log('verifyOtp code=$otp');
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return otp == '123456';
  }

  Future<void> saveProfile(ProfileData profile) async {
    logger.log('saveProfile ${profile.fullName}');
    await Future<void>.delayed(const Duration(milliseconds: 500));
    await storage.write('profile_full_name', profile.fullName);
    await storage.write('profile_email', profile.email ?? '');
  }
}
