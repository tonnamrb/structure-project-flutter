import '../../core/enum/widget_placement.dart';
import '../../core/enum/widget_type.dart';
import 'manifest_widget_spec.dart';

class ManifestWidgetRegistry {
  ManifestWidgetRegistry._();

  static final Map<String, ManifestWidgetSpec> _registry = {
    'WG-01': ManifestWidgetSpec(
      id: 'WG-01',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.enterEmail',
    ),
    'WG-02': ManifestWidgetSpec(
      id: 'WG-02',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.invalidEmailFormat',
    ),
    'WG-03': ManifestWidgetSpec(
      id: 'WG-03',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.duplicateAccount',
    ),
    'WG-04': ManifestWidgetSpec(
      id: 'WG-04',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.genericError',
    ),
    'WG-05': ManifestWidgetSpec(
      id: 'WG-05',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.invalidOtp',
    ),
    'WG-06': ManifestWidgetSpec(
      id: 'WG-06',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.enterPhone',
    ),
    'WG-07': ManifestWidgetSpec(
      id: 'WG-07',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.phoneMustBe10Digits',
    ),
    'WG-08': ManifestWidgetSpec(
      id: 'WG-08',
      type: ManifestWidgetType.popup,
      placement: ManifestWidgetPlacement.centerModal,
      messageKey: 'wg.popup.pdpa',
      actions: [
        ManifestWidgetAction(id: 'btn-accept', labelKey: 'wg.action.accept'),
        ManifestWidgetAction(id: 'btn-decline', labelKey: 'wg.action.decline'),
      ],
    ),
    'WG-09': ManifestWidgetSpec(
      id: 'WG-09',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.acceptPrivacy',
    ),
    'WG-10': ManifestWidgetSpec(
      id: 'WG-10',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.weakPassword',
    ),
    'WG-11': ManifestWidgetSpec(
      id: 'WG-11',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.passwordMismatch',
    ),
    'WG-12': ManifestWidgetSpec(
      id: 'WG-12',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.duplicatePhone',
    ),
    'WG-13': ManifestWidgetSpec(
      id: 'WG-13',
      type: ManifestWidgetType.popup,
      placement: ManifestWidgetPlacement.centerModal,
      messageKey: 'wg.popup.smsOtp',
      actions: [
        ManifestWidgetAction(id: 'btn-confirm', labelKey: 'wg.action.confirm'),
        ManifestWidgetAction(id: 'btn-cancel', labelKey: 'wg.action.cancel'),
      ],
    ),
    'WG-14': ManifestWidgetSpec(
      id: 'WG-14',
      type: ManifestWidgetType.popup,
      placement: ManifestWidgetPlacement.centerModal,
      messageKey: 'wg.popup.smsOtp',
      actions: [
        ManifestWidgetAction(id: 'btn-resend', labelKey: 'wg.action.resend'),
        ManifestWidgetAction(id: 'btn-close', labelKey: 'wg.action.close'),
      ],
    ),
    'WG-15': ManifestWidgetSpec(
      id: 'WG-15',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.duplicateEmail',
    ),
    'WG-16': ManifestWidgetSpec(
      id: 'WG-16',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.uploadFormat',
    ),
    'WG-17': ManifestWidgetSpec(
      id: 'WG-17',
      type: ManifestWidgetType.popup,
      placement: ManifestWidgetPlacement.centerModal,
      messageKey: 'wg.popup.emailOtp',
      actions: [
        ManifestWidgetAction(id: 'btn-confirm', labelKey: 'wg.action.confirm'),
        ManifestWidgetAction(id: 'btn-cancel', labelKey: 'wg.action.cancel'),
      ],
    ),
    'WG-18': ManifestWidgetSpec(
      id: 'WG-18',
      type: ManifestWidgetType.popup,
      placement: ManifestWidgetPlacement.centerModal,
      messageKey: 'wg.popup.emailOtp',
      actions: [
        ManifestWidgetAction(id: 'btn-resend', labelKey: 'wg.action.resend'),
        ManifestWidgetAction(id: 'btn-close', labelKey: 'wg.action.close'),
      ],
    ),
    'WG-19': ManifestWidgetSpec(
      id: 'WG-19',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.saveSuccess',
    ),
    'WG-20': ManifestWidgetSpec(
      id: 'WG-20',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.duplicateProfile',
    ),
    'WG-21': ManifestWidgetSpec(
      id: 'WG-21',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.missingRequired',
    ),
    'WG-22': ManifestWidgetSpec(
      id: 'WG-22',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.birthDatePast',
    ),
    'WG-23': ManifestWidgetSpec(
      id: 'WG-23',
      type: ManifestWidgetType.toast,
      placement: ManifestWidgetPlacement.top,
      messageKey: 'wg.toast.maxImages',
    ),
  };

  static ManifestWidgetSpec? find(String id) => _registry[id];

  static List<ManifestWidgetSpec> get all =>
      _registry.values.toList(growable: false);
}
