import 'package:equatable/equatable.dart';

class ProfileData extends Equatable {
  const ProfileData({
    required this.fullName,
    this.lastName,
    this.nickName,
    this.email,
    this.phone,
    this.graduationYear,
    this.faculty,
    this.group,
    this.address,
    this.province,
    this.district,
    this.subdistrict,
    this.postalCode,
    this.workplace,
    this.jobTitle,
    this.facebook,
    this.instagram,
    this.status,
    this.birthDate,
    this.gallery,
    this.additionalNotes,
  });

  final String fullName;
  final String? lastName;
  final String? nickName;
  final String? email;
  final String? phone;
  final String? graduationYear;
  final String? faculty;
  final String? group;
  final String? address;
  final String? province;
  final String? district;
  final String? subdistrict;
  final String? postalCode;
  final String? workplace;
  final String? jobTitle;
  final String? facebook;
  final String? instagram;
  final String? status;
  final DateTime? birthDate;
  final List<String>? gallery;
  final String? additionalNotes;

  ProfileData copyWith({
    String? fullName,
    String? lastName,
    String? nickName,
    String? email,
    String? phone,
    String? graduationYear,
    String? faculty,
    String? group,
    String? address,
    String? province,
    String? district,
    String? subdistrict,
    String? postalCode,
    String? workplace,
    String? jobTitle,
    String? facebook,
    String? instagram,
    String? status,
    DateTime? birthDate,
    List<String>? gallery,
    String? additionalNotes,
  }) {
    return ProfileData(
      fullName: fullName ?? this.fullName,
      lastName: lastName ?? this.lastName,
      nickName: nickName ?? this.nickName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      graduationYear: graduationYear ?? this.graduationYear,
      faculty: faculty ?? this.faculty,
      group: group ?? this.group,
      address: address ?? this.address,
      province: province ?? this.province,
      district: district ?? this.district,
      subdistrict: subdistrict ?? this.subdistrict,
      postalCode: postalCode ?? this.postalCode,
      workplace: workplace ?? this.workplace,
      jobTitle: jobTitle ?? this.jobTitle,
      facebook: facebook ?? this.facebook,
      instagram: instagram ?? this.instagram,
      status: status ?? this.status,
      birthDate: birthDate ?? this.birthDate,
      gallery: gallery ?? this.gallery,
      additionalNotes: additionalNotes ?? this.additionalNotes,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        lastName,
        nickName,
        email,
        phone,
        graduationYear,
        faculty,
        group,
        address,
        province,
        district,
        subdistrict,
        postalCode,
        workplace,
        jobTitle,
        facebook,
        instagram,
        status,
        birthDate,
        gallery,
        additionalNotes,
      ];
}
