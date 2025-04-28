import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/account.dart';

class AccountNotifier extends StateNotifier<Account?> {
  AccountNotifier() : super(null);

  void set(Account? acc) => state = acc;
  void clear() => state = null;
}

final accountProviderGlobal = StateNotifierProvider<AccountNotifier, Account?>(
  (ref) {
    return AccountNotifier();
  },
);
