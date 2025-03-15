import 'package:coffee_house/models/user_account.dart';
import 'package:coffee_house/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAccountNotifier extends StateNotifier<AsyncValue<UserAccount?>> {
  UserAccountNotifier() : super(const AsyncValue.loading()) {
    fetchUserAccount();
  }

  Future<void> fetchUserAccount() async {
    try {
      final user = await UserService.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final userAccountProvider =
    StateNotifierProvider<UserAccountNotifier, AsyncValue<UserAccount?>>(
  (ref) => UserAccountNotifier(),
);