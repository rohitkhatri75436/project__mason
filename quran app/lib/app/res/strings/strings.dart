///This class is used for app strings.xml
class AppStrings {

  ///General strings
  static const String appName = 'quran app';


  /// Validation Texts
  ///
  static const String areYouSureForLogout = 'Are you sure you want to logout?';
  static const String txtEmailValidation = 'Please enter valid email address.';
  static const String txtEmptyEmailValidation = 'Please enter Email.';
  static const String txtInvalidPassword = 'Please enter Password.';
  static const String txtNameValidation = 'Please enter Name.';
  static const String txtConfirmPasswordValidation = 'Password and Confirm Password does not match.';
  static const String txtPasswordValidation = 'Password must contain at least 8 characters including upper/lowercase, special character and number.';
  static const String sessionExpire =
      'Your last session has been expired, Please login again!';
  static const String logoutDescription =
      'Are you sure, that you want to logout?';
  static const String plsWait = 'Please wait...';
  static const String pleaseAllowLocationPermission =
      'Please allow location permission!';
  static const String allowLocationPermissionFromSettings =
      'Permission denied, Please allow location permission from settings!';
  static const String txtOk = 'Okay';


  /*-------------------Permission Strings-------------------*/
  static const String txtSettings = 'Settings';

  static const String txtCancel = 'Cancel';

  static const String txtStoragePermission = 'Storage Permission';
  static const String txtCameraPermission =
      'Please allow camera permission from settings to apply pictures';
  static const String txtThisAppNeedsGalleryAccess =
      'This app needs Gallery access!';
  static const String txtOpenSettings = 'Open settings';

  static const String txtThisAppNeedsStorageAccess =
      'This app needs Storage access!';
  static const String txtThisAppNeedsCameraAccess =
      'This app needs Camera access!';
  static const String txtGallery = 'Gallery';
  static const String txtCamera = 'Camera';

  static const String txtSelectPhoto = 'Select photo';
  static const String txtPleaseSelectImage =
      'Please select image from the options below.';
  static const String txtGalleryPermission = 'Gallery Permission';


  // Minimum eight characters, at least one letter, one number and one special character:
  static const String passwordRegEx = r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$';

  static const String requestPermission = 'Request permission';
  static const String txtLocationPermissionDenied =
      'Location permission denied';
  static const String txtLocationServiceDisabled = 'Location service disabled';
  static const String txtLocationServiceDisabledDescription =
      'Please enable location service to continue.';
  static const String txtLocationPermissionPermanentlyDenied =
      'Location permission permanently denied';
  static const String txtLocationPermissionDeniedDescription =
      'Please allow location permissions to continue.';
  static const String txtLocationPermanentlyDeniedDescription =
      'Please allow location permissions from app settings.';

  AppStrings._();

}
