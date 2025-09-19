---
applyTo: '**'
---

# 📱 Project Development Instructions

## 1. Core Architecture & Technologies

- **Project Structure:**  
  - Use Clean Architecture: separate `presentation`, `domain`, and `data` layers.  
  - Organize folders: `lib`, `assets`, `test`, etc.  
  - Each **Controller** must be placed in its own folder.  
    - The folder may contain both the controller and its binding file.  
    - If a controller is created as a sub-controller of another, it must reside in the same folder as the main controller.

- **Frameworks & Libraries:**  
  - Use the latest stable versions of Flutter and Dart.  
 ## State Management & Dependency Injection (GetX)

- **Framework**: Use GetX exclusively for state, navigation, and dependency injection (DI).
- **Binding**: Every Controller/Service must have a corresponding Binding file declaring its injection.
- **Access**: Controllers and services must be retrieved with `Get.find<T>()` only.

### Injection Rules
1. **Core Services**
   - Must be injected with `Get.put(Service(), permanent: true)`.
   - Examples: `AppConfig`, `Logger`, `SecureStorage`, `ApiClient`, `AuthService`.
   - Reason: Core services must always be available and cannot be disposed during app lifetime.

2. **Feature Controllers / Non-core Services**
   - Must be injected with `Get.lazyPut(() => Controller())`.
   - Reason: Reduce memory footprint; instantiated only when first accessed.
   - If controller may be disposed and reused later, enforce `fenix: true`.
     ```dart
     Get.lazyPut(() => OtpController(auth: Get.find()), fenix: true);
     ```

3. **Do / Don’t**
   - ✅ Declare injections inside **Binding files** per route/module.
   - ✅ Separate **Core services** (always alive) vs **Feature controllers** (on-demand).
   - ❌ Never call `Get.put` inside a Widget `build()` method.
   - ❌ Never guess or inject dependencies outside of Binding definitions.

### Lifecycle Rules
- Controllers tied to a route are automatically disposed when the route is popped.
- Controllers registered with `fenix: true` are re-created automatically when accessed again after disposal.
- Core services (`permanent: true`) must persist for the entire app lifetime.

  - **Reactive Updates:**  
    - Use `Rx` types for real-time value updates, such as `RxBool`, `RxList`, `RxInt`, etc.  
    - Use `RxStatus` to represent and manage response states (e.g., loading, success, error).  
  - **Localization:** Use GetX for multi-language support.  
  - **Theming:**  
    - Implement light and dark themes with GetX.
    - **Font:**  
      - Use a custom font ('Kanit' or similar) for all text.  
      - **Header:** Font size 24–32, bold  
      - **Content:** Font size 16–18, regular  
      - **Button:** Font size 18–20, medium/bold  
      - Set the font and size in ThemeData and on every page.  
    - **App Color Theme:**  
      - Start with a **neutral Boot Theme**
      - Define **Light** and **Dark** themes in `app_color.dart`.  
      - All colors must be declared as **semantic tokens** (e.g., `buttonBg`, `onButton`, `textFieldFill`, `toastBg`) and used via tokens only.  
      - Do not hardcode colors in widgets or tie them to IDs.  
      - When hi-fi wireframes are available, only token values in `app_color.dart` should change.  
      - Ensure tokens cover: background, text, buttons, textfields, toast/snackbar, dividers, and state colors (success, warning, error, info).  

  - **API:** Use Dio for all network operations.  
  - **Icons:** Use fluttericon and cupertino_icons.  
  - **Platform Support:** Must work on iOS, Android, and Web.  
  - **Persistent Storage:** Use Shared Preferences for saving user settings (e.g., theme, language).  
  - **Routing:** Use GetX for navigation and routing.  
  - **Form Validation:** Use form_field_validator package.  
  - **Image Handling:** Use cached_network_image for efficient image loading and caching.  
  - **JSON Serialization:** Use json_serializable for model classes.  
  - **Environment Variables:** Use flutter_dotenv for managing environment-specific configurations.

- **CI/CD:**  
  - Set up pipelines (e.g., GitHub Actions, Bitrise, Codemagic) for automated testing and deployment.

- **Code Linting & Formatting:**  
  - Enforce code style using `flutter_lints` or custom lint rules.  
  - Use `dart format` and `dart analyze` in your workflow.

- **Secrets Management:**  
  - Never hardcode secrets (API keys, tokens). Use `.env` files or a secrets manager.

- **App Versioning:**  
  - Use semantic versioning and update `pubspec.yaml` accordingly.

- **App Icon & Splash Screen:**  
  - Configure using `flutter_launcher_icons` and `flutter_native_splash`.

## 2. User Interface & Navigation

- **Navigation:**  
  - Implement a fixed Bottom Navigation Bar with 5 items: Home, Profile, Search, Favorites, and Settings.  
  - Each item must route to its respective page.

- **Pages:**  
  - Home Page  
  - Profile Page  
  - Search Page  
  - Favorites Page  
  - Settings Page

- **Settings Page:**  
  - **Localization:** Provide a button or dropdown to change app language.  
  - **Theme:** Provide a toggle or button to switch between light and dark mode.  
    - **Persistence:** Save user preferences using Shared Preferences.

### 📌 Page & Controller Binding Rules

- Every time a new **Page** is created, a corresponding **Controller** must also be created.  
- Pages must extend `GetView<Controller>` only.  
  - Do not use `StatelessWidget` or `StatefulWidget` directly for pages.  
  - Controllers must be injected via **Binding files** (never inline in the page).  
  - In Bindings:  
    - **Core Services** → use `Get.put(Service(), permanent: true)`  
    - **Page/Feature Controllers** → use `Get.lazyPut(() => Controller())` (add `fenix: true` if they need to be re-created after disposal).  
  - Access controllers inside the page only via the `controller` property of `GetView`.  

- If a page requires **multiple controllers**:  
  - The **main controller** should call `Get.find<OtherController>()` internally.  
  - Do not call `Get.find` or `Get.put` directly inside the page widget.  
  - The page should only interact with its bound controller.  

- Every controller must have a **Binding file** to define its injection logic.  
  - The Binding and its controller should be placed in the same folder for clarity.  
  - Sub-controllers must also reside in the same folder as their parent controller.  

## 3. Asset & Data Management

- **Image Assets:**  
  - Store all images in `assets/images` (use subfolders as needed).  
  - Reference images in `pubspec.yaml`.  
  - Optimize images for performance.

- **Localization:**  
  - All user-facing text must be translatable.  
  - Manage translations within the project structure.

- **Network Security:**  
  - Ensure all network requests use HTTPS.  
  - Configure security settings for Android and iOS.

- **Third-party Licenses:**  
  - Include licenses for all third-party packages.

## 4. Code Quality & Development Practices

- **Code Quality:**  
  - Follow Dart/Flutter best practices.  
  - Use meaningful names and keep functions short.

- **Documentation:**  
  - Document all classes, methods, and complex logic.  
  - Maintain a comprehensive README.

- **Version Control:**  
  - Use Git with a clear branching strategy (e.g., Git Flow).  
  - Write clear, structured commit messages.

- **Performance:**  
  - Regularly profile and optimize app/assets.

- **Accessibility:**  
  - Follow accessibility guidelines; test with screen readers.

- **Error Handling:**  
  - Implement robust error handling and user-friendly messages.

- **Security:**  
  - Follow best practices for securing data and user information.

- **Release Checklist:**  
  - Review assets, translations, test coverage, performance, and accessibility before each release.

- **Analytics & Monitoring:**  
  - Integrate analytics (e.g., Firebase Analytics) and error monitoring (e.g., Sentry, Crashlytics).

- **[New Rule: Theming Enforcement]**  
  - All new UI code must use colors only through tokens in `app_color.dart`.  
  - No direct `Color(...)` usage in widgets.  
  - Add **theme snapshot tests** to validate consistency across light/dark modes.

## 5. File Organization Guidelines

- **Widget Components:**  
  - Store reusable widgets in `lib/presentation/widget`

- **Navigation:**  
  - Store navigation-related files in `lib/presentation/nav`

- **Utility Functions:**  
  - Store helper functions in `lib/presentation/util`

- **Pages:**  
  - All page files must be placed in `lib/presentation/page`  
  - Each page must follow the structure: one page = one file  
  - Page must extend `GetView<Controller>` and be paired with its controller and binding

- **Controller & Binding:**  
  - Each controller must be placed in its own folder.  
  - Binding file should be placed alongside the controller.  
  - Sub-controllers must reside in the same folder as their parent controller.

- **Enums:**  
  - Store all enums in `lib/core/enum`

### 🔁 Reuse Before Create

- Before creating any new **function**, **widget**, or **utility**, always check if an existing one already serves the purpose  
- If a reusable component exists, use or extend it instead of duplicating logic  
- If no suitable component is found, you may create a new one following naming and folder conventions

- **Best Practices:**  
  - Use snake_case for file names.  
  - Keep each file focused on a single responsibility.  
  - Split large files into smaller ones when needed.

## 6. Testing Guidelines

- **Test Structure:**  
  - Every time a new **function**, **widget**, or **page** is created, write corresponding **unit test** or **widget test**.  
  - Organize tests in the `test/` folder, mirroring the structure of the `lib/` folder.

- **Test Types:**  
  - **Unit Test:** For business logic and pure functions  
  - **Widget Test:** For UI components and interactions  
  - **Integration Test (optional):** For flows involving multiple components

- **Best Practices:**  
  - Use `_test.dart` suffix for all test files  
  - Use `flutter_test`, `mocktail`, and `get_test` for assertions and mocking  
  - Cover both success and failure scenarios  
  - Include test execution in CI/CD pipeline  

- **Coverage & Maintenance:**  
  - Target >80% test coverage before release  
  - Update tests when logic or UI changes  
  - Avoid relying on external APIs—use mocks instead  
  - **[New Rule: Theme Tests]**  
    - Add snapshot tests for light/dark mode (button, textfield, toast) to ensure no regressions when tokens are updated.

## 7. App Configuration Files (`lib/core/config`)

To make managing constants and settings across your app more organized, separate your config file into three main sections:

### 📁 lib/core/config/app_color.dart
- Include the same color values ​​as the app, such as the main, accent, background, and buttons.
- ThemeData and general styling.
- **[New Rule: Semantic Tokens]**  
  - Define tokens for surfaces, text, buttons, textfields, toast/snackbar, dividers, and state colors.  
  - Provide `AppTheme.light` and `AppTheme.dark` mapped to `AppColors.light` and `AppColors.dark`.  
  - Default values should be **neutral black/white/gray** until hi-fi wireframes are available.  
  - Future updates should change only token values, not widget code.

### 📁 lib/core/config/app_image.dart
- Includes the path or URL of all images used in the app.
- Used for systematically accessing assets or network images.

### 📁 lib/core/config/app_config.dart
- Includes common constants and settings such as API endpoints, timeout durations, and more. 
- Used for app-wide settings.

--- **Note:** 
- Keep dependencies up to date and minimal. 
- Encourage code reviews and collaboration. 
- Integrate analytics for user behavior and app performance. 
- Regularly update documentation and README files.
