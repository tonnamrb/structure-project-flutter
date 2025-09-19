import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/controllers/profile_controller.dart';
import '../../../presentation/util/manifest_widget_renderer.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile.header'.tr),
      ),
      body: SafeArea(
        child: Obx(
          () {
            final currentIndex = controller.tabIndex.value;
            return Column(
              children: [
                const SizedBox(height: 16),
                _TabSelector(
                  currentIndex: currentIndex,
                  onChanged: controller.switchTab,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: currentIndex == 0
                        ? _ProfileTabBasic(controller: controller)
                        : _ProfileTabExtra(controller: controller),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TabSelector extends StatelessWidget {
  const _TabSelector({required this.currentIndex, required this.onChanged});

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: colors.primary.withValues(alpha: 0.2), width: 2),
      ),
      child: Row(
        children: [
          _buildTabChip(context, 0, 'profile.tab.basic'.tr),
          _buildTabChip(context, 1, 'profile.tab.extra'.tr),
        ],
      ),
    );
  }

  Expanded _buildTabChip(BuildContext context, int index, String label) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isSelected = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? colors.primary : colors.surface,
            borderRadius: BorderRadius.circular(28),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isSelected ? colors.onPrimary : colors.primary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileTabBasic extends StatelessWidget {
  const _ProfileTabBasic({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      key: const ValueKey('tab-basic'),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown: Faculty
          Text('profile.faculty'.tr, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Obx(
            () => DropdownButtonFormField<String>(
              initialValue: controller.selectedFaculty.value,
              items: controller.faculties
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => controller.selectedFaculty.value = v,
            ),
          ),
          const SizedBox(height: 16),

          // Dropdown: Batch (Graduation Year)
          Text('profile.graduationYear'.tr, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Obx(
            () => DropdownButtonFormField<String>(
              initialValue: controller.selectedBatch.value,
              items: controller.batches
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => controller.selectedBatch.value = v,
            ),
          ),
          const SizedBox(height: 16),

          // Dropdown: Group
          Text('profile.group'.tr, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Obx(
            () => DropdownButtonFormField<String>(
              initialValue: controller.selectedGroup.value,
              items: controller.groups
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => controller.selectedGroup.value = v,
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: controller.fullNameController,
            decoration: InputDecoration(labelText: 'profile.fullName'.tr),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.lastNameController,
            decoration: InputDecoration(labelText: 'profile.lastName'.tr),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.nickNameController,
            decoration: InputDecoration(labelText: 'profile.nickName'.tr),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'profile.email'.tr),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => ManifestWidgetRenderer.show('WG-17'),
              child: Text('profile.verifyEmail'.tr, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(labelText: 'profile.phone'.tr),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => ManifestWidgetRenderer.show('WG-13'),
              child: Text('profile.verifyPhone'.tr, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.resetTab1,
                  child: Text('profile.reset'.tr),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isSaving.value ? null : controller.saveTab1,
                    child: controller.isSaving.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('profile.next'.tr),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileTabExtra extends StatelessWidget {
  const _ProfileTabExtra({required this.controller});

  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      key: const ValueKey('tab-extra'),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DOB field styled like a regular input
          Text('profile.birthDate'.tr, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Obx(
            () => InkWell(
              onTap: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(
                  context: context,
                  initialDate: controller.birthDate.value ?? now.subtract(const Duration(days: 3650)),
                  firstDate: DateTime(1900),
                  lastDate: now,
                );
                if (picked != null) {
                  controller.onSelectBirthDate(picked);
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: InputDecorator(
                decoration: const InputDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.birthDate.value != null
                          ? _formatDate(controller.birthDate.value!)
                          : 'profile.birthDateHint'.tr,
                      style: controller.birthDate.value == null
                          ? theme.textTheme.bodyMedium?.copyWith(color: Theme.of(context).hintColor)
                          : theme.textTheme.bodyMedium,
                    ),
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: controller.addressController,
            maxLines: 2,
            decoration: InputDecoration(labelText: 'profile.address'.tr),
          ),
          const SizedBox(height: 16),

          // Province
          Text('profile.province'.tr, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Obx(
            () => DropdownButtonFormField<String>(
              initialValue: controller.selectedProvince.value,
              items: controller.provinces
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: controller.onSelectProvince,
            ),
          ),
          const SizedBox(height: 16),

          // District
          Text('profile.district'.tr, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Obx(
            () => DropdownButtonFormField<String>(
              initialValue: controller.selectedDistrict.value,
              items: controller.districtsForProvince
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: controller.onSelectDistrict,
            ),
          ),
          const SizedBox(height: 16),

          // Subdistrict
          Text('profile.subdistrict'.tr, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Obx(
            () => DropdownButtonFormField<String>(
              initialValue: controller.selectedSubdistrict.value,
              items: controller.subdistrictsForDistrict
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: controller.onSelectSubdistrict,
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: controller.postalCodeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'profile.postalCode'.tr),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: controller.workplaceController,
            decoration: InputDecoration(labelText: 'profile.workplace'.tr),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.jobTitleController,
            decoration: InputDecoration(labelText: 'profile.jobTitle'.tr),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.facebookController,
            decoration: InputDecoration(labelText: 'profile.facebook'.tr),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.instagramController,
            decoration: InputDecoration(labelText: 'profile.instagram'.tr),
          ),
          const SizedBox(height: 16),

          Text('profile.status'.tr, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          Obx(
            () => DropdownButtonFormField<String>(
              initialValue: controller.selectedStatus.value,
              items: controller.statuses
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => controller.selectedStatus.value = v,
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: controller.notesController,
            maxLines: 4,
            decoration: InputDecoration(labelText: 'profile.additionalNotes'.tr),
          ),
          const SizedBox(height: 16),
          Text('profile.uploadImages'.tr, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 12),
          Obx(
            () => Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ...controller.gallery.map(
                  (ref) => Chip(
                    label: Text(ref),
                    deleteIcon: const Icon(Icons.close),
                    onDeleted: () => controller.onRemoveImage(ref),
                  ),
                ),
                if (controller.gallery.length < 10)
                  OutlinedButton.icon(
                    onPressed: () {
                      final newIndex = controller.gallery.length + 1;
                      final ref = 'image_$newIndex.png';
                      controller.onAddImage(ref);
                    },
                    icon: const Icon(Icons.upload),
                    label: Text('profile.addImage'.tr),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: controller.resetTab2,
                  child: Text('profile.reset'.tr),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    onPressed: (controller.isSaving.value || !controller.tab1Completed.value) ? null : controller.saveTab2,
                    child: controller.isSaving.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('profile.submit'.tr),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
