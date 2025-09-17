---
applyTo: '**'
---

# 📱 Project Development Instructions

## 1. Core Architecture & Technologies

- **Project Structure:**  
  - Use Clean Architecture: separate `presentation`, `domain`, and `data` layers.  
  - Organize folders: `lib`, `assets`, `test`, etc.  
  - Each **Controller** must be placed in its own folder.  
    - Example: `lib/presentation/controller/profile/`  
    - The folder may contain both the controller and its binding file.  
    - If a controller is created as a sub-controller of another, it must reside in the same folder as the main controller.

- **Frameworks & Libraries:**  
  - Use the latest stable versions of Flutter and Dart.  
  - **State Management:**  
    - Use GetX exclusively for state, navigation, and dependency injection (DI).  
    - Always call `Get.put(Controller())` before using a new controller.  
    - Access controllers via `Get.find<Controller>()`.  
    - Every controller must have a corresponding **Binding file** to define its injection.  
      - This helps identify which controllers are available for use in each route or module.  
  - **Reactive Updates:**  
    - Use `Rx` types for real-time value updates, such as `RxBool`, `RxList`, `RxInt`, etc.  
    - Use `RxStatus` to represent and manage response states (e.g., loading, success, error).  
  - **Localization:** Use GetX for multi-language support.  
  - **Theming:**  
    - Implement light and dark themes with GetX.  
    - **Project Color Theme:**  
      - **Primary color:** White & Blue  
      - **Button color:** Blue (#2196F3)  
      - **Dark mode button color:** Light Grey (#E0E0E0)  
      - **Background:** White (light mode), very light grey or dark blue (dark mode)  
    - **Font:**  
      - Use a custom font ('Kanit' or similar) for all text.  
      - **Header:** Font size 24–32, bold  
      - **Content:** Font size 16–18, regular  
      - **Button:** Font size 18–20, medium/bold  
      - Set the font and size in ThemeData and on every page.  
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

- Every time a new **Page** is created, a corresponding **Controller** must be created.  
- Pages must extend `GetView<Controller>` only.  
  - Do not use `StatelessWidget` or `StatefulWidget` directly for pages.  
  - Controller must be injected using `Get.put(Controller())`.  
  - Access controller only via `controller` property in `GetView`.

- If a page requires **multiple controllers**:  
  - Use `Get.find<OtherController>()` **inside the main controller only**.  
  - Do not call `Get.find` or `Get.put` inside the page.  
  - The page should only interact with the controller bound via `GetView`.

- Every controller must have a **Binding file** to define its injection logic.  
  - Binding and controller may reside in the same folder.

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

## 5. File Organization Guidelines

- **Widget Components:**  
  - Store reusable widgets in `lib/presentation/widget`

- **Navigation:**  
  - Store navigation-related files in `lib/presentation/nav`

- **Utility Functions:**  
  - Store helper functions in `lib/presentation/util`

- **Controller & Binding:**  
  - Each controller must be placed in its own folder.  
  - Binding file should be placed alongside the controller.  
  - Sub-controllers must reside in the same folder as their parent controller.

- **Enums:**  
  - Store all enums in `lib/core/enum`

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

## 7. App Configuration Files (`lib/core/config`)

To make managing constants and settings across your app more organized, separate your config file into three main sections:

### 📁 lib/core/config/app_color.dart
- Include the same color values ​​as the app, such as the main, accent, background, and buttons.
- ThemeData and general styling.

### 📁 lib/core/config/app_image.dart
- Includes the path or URL of all images used in the app.
- Used for systematically accessing assets or network images.

### 📁 lib/core/config/app_config
- Includes common constants and settings such as API endpoints, timeout durations, and more. 
- Used for app-wide settings.

--- 
**Note:** 
- Keep dependencies up to date and minimal. 
- Encourage code reviews and collaboration. 
- Integrate analytics for user behavior and app performance. 
- Regularly update documentation and README files.