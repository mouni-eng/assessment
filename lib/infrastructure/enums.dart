
import 'package:flutter/foundation.dart';

enum Gender { male, female }

enum UserRole { user, creator, vendor }

enum SocialMedia {facebook, instagram, twitter, other}

enum Status { followed, requested }

enum ChatStatus {online, offline, typing}

enum MessageEnum { text, image, video, gif }

enum LocationType {offline, online}

enum EventType {free, paid}

enum IssueType {issue, improvment, other}

enum PrivacyType {everyone, followers, onlyme,}

extension UserRoleExtension on UserRole {
  String get name => describeEnum(this);
  String get text {
    switch (this) {
      case UserRole.user:
        return 'Event Goer';
      case UserRole.creator:
        return 'Event Creator';
      case UserRole.vendor:
        return 'Vendor';
      default:
        return "Error";
    }
  } }

  extension SocialMediaExtension on SocialMedia {
  String get name => describeEnum(this);
  String get text {
    switch (this) {
      case SocialMedia.facebook:
        return 'assets/icons/Facebook.svg';
      case SocialMedia.instagram:
        return 'assets/icons/Instagram.svg';
      case SocialMedia.twitter:
        return 'assets/icons/twitter.svg';
      case SocialMedia.other:
        return 'assets/icons/link.svg';
      default:
        return "Error";
    }}}

