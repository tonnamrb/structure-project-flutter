import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/profile_data.dart';
import '../../presentation/util/manifest_widget_renderer.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class ProfileController extends GetxController {
  ProfileController({required this.authService});

  final AuthService authService;

  final tabIndex = 0.obs;

  // Basic info controllers
  final fullNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final nickNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  // Kept legacy text fields for faculty/batch replaced by dropdowns
  // final facultyController = TextEditingController();
  // final graduationYearController = TextEditingController();
  final notesController = TextEditingController();

  // Extra info controllers
  final addressController = TextEditingController();
  final postalCodeController = TextEditingController();
  final workplaceController = TextEditingController();
  final jobTitleController = TextEditingController();
  final facebookController = TextEditingController();
  final instagramController = TextEditingController();

  final formTab1Key = GlobalKey<FormState>();
  final formTab2Key = GlobalKey<FormState>();

  final Rx<DateTime?> birthDate = Rx<DateTime?>(null);
  final RxList<String> gallery = <String>[].obs;

  final isSaving = false.obs;
  final tab1Completed = false.obs;

  // Dropdown data sources (basic)
  final List<String> faculties = const [
    'Engineering',
    'Science',
    'Arts',
    'Business Administration',
    'Education',
  ];
  late final List<String> batches =
      List<String>.generate(40, (i) => (2530 + i).toString());
  final List<String> groups = const ['A', 'B', 'C', 'D'];

  // Dropdown selections (basic)
  final Rxn<String> selectedFaculty = Rxn<String>();
  final Rxn<String> selectedBatch = Rxn<String>();
  final Rxn<String> selectedGroup = Rxn<String>();

  // Location data for dropdowns (extra)
  final Map<String, Map<String, List<String>>> thLocations = {
    'Bangkok': {
      'Phra Nakhon': ['Wat Sam Phraya', 'Bang Khun Phrom'],
      'Bang Rak': ['Si Lom', 'Suriyawong'],
    },
    'Chiang Mai': {
      'Mueang Chiang Mai': ['Si Phum', 'Chang Phueak'],
      'Hang Dong': ['Han Kaeo', 'Hang Dong'],
    },
  };

  List<String> get provinces => thLocations.keys.toList(growable: false);
  List<String> get districtsForProvince =>
      selectedProvince.value == null ? [] : thLocations[selectedProvince.value]!.keys.toList();
  List<String> get subdistrictsForDistrict {
    final prov = selectedProvince.value;
    final dist = selectedDistrict.value;
    if (prov == null || dist == null) return [];
    return thLocations[prov]![dist] ?? [];
  }

  final Rxn<String> selectedProvince = Rxn<String>();
  final Rxn<String> selectedDistrict = Rxn<String>();
  final Rxn<String> selectedSubdistrict = Rxn<String>();

  // Status dropdown
  final List<String> statuses = const ['Single', 'Married', 'Other'];
  final Rxn<String> selectedStatus = Rxn<String>();

  @override
  void onClose() {
    fullNameController.dispose();
    lastNameController.dispose();
    nickNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    postalCodeController.dispose();
    workplaceController.dispose();
    jobTitleController.dispose();
    facebookController.dispose();
    instagramController.dispose();
    notesController.dispose();
    super.onClose();
  }

  void switchTab(int index) {
    tabIndex.value = index;
  }

  Future<void> saveTab1() async {
    if (!_validateTab1()) {
      return;
    }
    isSaving.value = true;
    try {
      final profile = _buildProfile();
      await authService.saveProfile(profile);
      ManifestWidgetRenderer.show('WG-19');
      tab1Completed.value = true;
      tabIndex.value = 1;
    } catch (error) {
      ManifestWidgetRenderer.show('WG-04');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> saveTab2() async {
    // Prevent saving if basic tab not completed
    if (!tab1Completed.value) {
      ManifestWidgetRenderer.show('WG-21');
      return;
    }
    if (!_validateTab2()) {
      return;
    }
    isSaving.value = true;
    try {
      final profile = _buildProfile();
      await authService.saveProfile(profile);
      ManifestWidgetRenderer.show('WG-19');
      Get.offAllNamed(AppRoutes.thankYou);
    } catch (error) {
      ManifestWidgetRenderer.show('WG-04');
    } finally {
      isSaving.value = false;
    }
  }

  bool _validateTab1() {
    final fullName = fullNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final nick = nickNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();

    if (fullName.isEmpty || lastName.isEmpty || nick.isEmpty ||
        selectedFaculty.value == null || selectedBatch.value == null || selectedGroup.value == null ||
        email.isEmpty || phone.isEmpty) {
      ManifestWidgetRenderer.show('WG-21');
      return false;
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      ManifestWidgetRenderer.show('WG-02');
      return false;
    }
      if (!RegExp(r'^\d{10}$').hasMatch(phone)) {
      ManifestWidgetRenderer.show('WG-07');
      return false;
    }
    if (_isDuplicateProfile(fullName, selectedFaculty.value ?? '', selectedBatch.value ?? '')) {
      ManifestWidgetRenderer.show('WG-20');
      return false;
    }
    if (_isDuplicateEmail(email)) {
      ManifestWidgetRenderer.show('WG-15');
      return false;
    }
    if (_isDuplicatePhone(phone)) {
      ManifestWidgetRenderer.show('WG-12');
      return false;
    }
    return true;
  }

  bool _validateTab2() {
    if (gallery.length > 10) {
      ManifestWidgetRenderer.show('WG-23');
      return false;
    }
    final birth = birthDate.value;
    if (birth != null && birth.isAfter(DateTime.now())) {
      ManifestWidgetRenderer.show('WG-22');
      return false;
    }
    return true;
  }

  bool _isDuplicateEmail(String email) {
    return email.toLowerCase() == 'duplicate@example.com';
  }

  bool _isDuplicatePhone(String phone) {
    return phone == '0999999999';
  }

  bool _isDuplicateProfile(String name, String faculty, String batch) {
    final key = '$name|$faculty|$batch'.toLowerCase();
    return key == 'john doe|science|2550';
  }

  ProfileData _buildProfile() {
    return ProfileData(
      fullName: fullNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      nickName: nickNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      faculty: selectedFaculty.value,
      graduationYear: selectedBatch.value,
      group: selectedGroup.value,
      address: addressController.text.trim(),
      province: selectedProvince.value,
      district: selectedDistrict.value,
      subdistrict: selectedSubdistrict.value,
      postalCode: postalCodeController.text.trim(),
      workplace: workplaceController.text.trim(),
      jobTitle: jobTitleController.text.trim(),
      facebook: facebookController.text.trim(),
      instagram: instagramController.text.trim(),
      status: selectedStatus.value,
      birthDate: birthDate.value,
      gallery: List<String>.from(gallery),
      additionalNotes: notesController.text.trim(),
    );
  }

  void onSelectBirthDate(DateTime date) {
    if (date.isAfter(DateTime.now())) {
      ManifestWidgetRenderer.show('WG-22');
      return;
    }
    birthDate.value = date;
  }

  void onAddImage(String reference) {
    final lower = reference.toLowerCase();
    if (!lower.endsWith('.png') && !lower.endsWith('.jpg')) {
      ManifestWidgetRenderer.show('WG-16');
      return;
    }
    if (gallery.length >= 10) {
      ManifestWidgetRenderer.show('WG-23');
      return;
    }
    gallery.add(reference);
  }

  void onRemoveImage(String reference) {
    gallery.remove(reference);
  }

  // Dropdown change handlers for locations
  void onSelectProvince(String? value) {
    selectedProvince.value = value;
    // Reset dependent selections
    selectedDistrict.value = null;
    selectedSubdistrict.value = null;
  }

  void onSelectDistrict(String? value) {
    selectedDistrict.value = value;
    selectedSubdistrict.value = null;
  }

  void onSelectSubdistrict(String? value) {
    selectedSubdistrict.value = value;
  }

  // Resets
  void resetTab1() {
    fullNameController.clear();
    lastNameController.clear();
    nickNameController.clear();
    emailController.clear();
    phoneController.clear();
    selectedFaculty.value = null;
    selectedBatch.value = null;
    selectedGroup.value = null;
    tab1Completed.value = false;
  }

  void resetTab2() {
    birthDate.value = null;
    addressController.clear();
    postalCodeController.clear();
    workplaceController.clear();
    jobTitleController.clear();
    facebookController.clear();
    instagramController.clear();
    notesController.clear();
    selectedProvince.value = null;
    selectedDistrict.value = null;
    selectedSubdistrict.value = null;
    selectedStatus.value = null;
    gallery.clear();
  }
}
