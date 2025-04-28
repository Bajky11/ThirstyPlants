
# Auth Module

Tento modul poskytuje plně funkční autentizační řešení ve Flutteru pomocí `Riverpod`, `Dio` a `SharedPreferences`.

## 📦 Obsah modulu

- ✅ Přihlášení (`LoginScreen`)
- ✅ Registrace (`RegisterScreen`)
- ✅ Ukládání uživatele do `SharedPreferences`
- ✅ Přístup k aktuálnímu uživateli pomocí providera
- ✅ Konfigurovatelné endpointy přes `AuthConfig`

---

## 🚀 Použití

### 1. Přidej do projektu

Rozbal složku `auth_module/` do `lib/modules/auth_module/`.

---

### 2. Inicializuj modul

V `main.dart` nebo dříve:

```dart
import '../auth_module/modules/auth_module/auth_module.dart';

void main() {
  AuthModule.init(const AuthConfig(
    baseUrl: 'https://tvuj-backend.cz/api/',
  ));
  runApp(const ProviderScope(child: MyApp()));
}
```

---

### 3. Přidej routy

```dart
MaterialApp(
  routes: {
    '/login': (context) => AuthModule.loginScreen(),
    '/register': (context) => AuthModule.registerScreen(),
    '/': (context) => const HomeScreen(),
  },
)
```

---

### 4. Přístup k přihlášenému uživateli

```dart
final account = ref.watch(AuthModule.accountProvider);
if (account != null) {
  print('Přihlášený: ${account.email}');
}
```

---

### 5. Odhlášení

```dart
await AuthModule.logout();
ref.read(AuthModule.accountProvider.notifier).clear();
Navigator.pushReplacementNamed(context, '/login');
```

---

## 🧩 Možnosti rozšíření

- Callback po úspěšném loginu
- Reset hesla
- Autologin po spuštění
- Samostatný Dart balíček

---

Vytvořeno jako základ pro modulární aplikace ✌️
