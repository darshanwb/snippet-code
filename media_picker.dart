//----------------------- dependencies: --------------------//

  image_picker: ^1.1.2
  permission_handler: ^11.3.1
  file_picker: ^8.3.3
  device_info: ^2.0.3



//----------------------- in Manifest --------------------//

// <uses-feature
//         android:name="android.hardware.camera"
//         android:required="false" />

//     <uses-permission android:name="android.permission.WRITE_CALENDAR" />
//     <uses-permission android:name="android.permission.READ_CALENDAR" />
//     <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
//     <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
//     <uses-permission android:name="android.permission.CAMERA"/>
//     <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
//     <uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>
//     <uses-permission android:name="android.permission.READ_MEDIA_VISUAL_USER_SELECTED"/>


// ------------------ iOS side -----------------------------------//
//info or info.plist


<key>NSCameraUsageDescription</key>
	<string>We need access to your camera to take pictures.</string>
<key>NSMicrophoneUsageDescription</key>
	<string>We need access to your microphone for videos.</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>We need access to your gallery to upload images.</string>


// -> Pods/Podfile

platform :ios, '11.0'

# Add these for permission_handler
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    target.build_configurations.each do |config|
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= [
        '$(inherited)',
        'PERMISSION_PHOTOS=1',
        'PERMISSION_CAMERA=1'
      ]
    end
  end
end


// ------------------- Global Dart File ----------------------------//

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rpo/utils/logger_helper.dart';

final ImagePicker _picker = ImagePicker();

/// 📂 Pick PDF File
Future<String?> pickPDFGlobal(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  LoggerHelper.i("✅ Selected PDF: ${result?.files.single.path}");
  return result?.files.single.path;
}

/// 🖼 Pick Image from Gallery
Future<String?> pickImageGlobal(BuildContext context) async {
  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var sdkInt = androidInfo.version.sdkInt;
    LoggerHelper.d('Android SDK $sdkInt');
    if(sdkInt>=33){
      if (!await _requestPermission(Permission.photos)) return null;
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      LoggerHelper.i("✅ Selected Image: ${image?.path}");
      return image?.path;
    } else{
      if (!await _requestPermission(Permission.storage)) return null;
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      LoggerHelper.i("✅ Selected Image: ${image?.path}");
      return image?.path;
    }
  } else {
    if (!await _requestPermission(Permission.photos)) return null;
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    LoggerHelper.i("✅ Selected Image: ${image?.path}");
    return image?.path;
  }
}

/// 📷 Capture Image from Camera
Future<String?> captureImageGlobal(BuildContext context) async {
  if (!await _requestPermission(Permission.camera)) return null;

  XFile? image = await _picker.pickImage(source: ImageSource.camera);
  LoggerHelper.i("✅ Selected Captured Image: ${image?.path}");
  return image?.path;
}

/// ✅ Handle Permissions
Future<bool> _requestPermission(Permission permission) async {
  PermissionStatus status = await permission.status;

  if (status.isGranted) {
    return true;
  }

  if (status.isDenied || status.isLimited) {
    status = await permission.request();
    return status.isGranted;
  }

  if (status.isPermanentlyDenied) {
    // Guide user to app settings for manual enable
    openAppSettings();
    return false;
  }

  return false;
}





// -------------    How to USE in Controller --------------------//

var selectedImage = Rx<File?>(null); 

Future<void> selectProfile(BuildContext context) async {
    if (kIsWeb) {
      // Web file picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null && result.files.single.bytes != null) {
        webImage.value = result.files.single.bytes!;
      }
    } else {
        var result = await pickImageGlobal(context);
        if (result!= null) {
        selectedImage.value = File(result);
      }
  }
}



// -------------- IN View PART -------------------------//

Obx(() => ClipRRect(
                                      borderRadius: BorderRadius.circular(50.0),
                                      child: kIsWeb
                                          ? (controller.webImage.value != null
                                          ? Image.memory(
                                        controller.webImage.value!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                          : Image.asset(
                                        AppAssets.personPlaceHolder,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ))
                                          : (controller.selectedImage.value != null
                                          ? Image.file(
                                        controller.selectedImage.value!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                          : Image.asset(
                                        AppAssets.personPlaceHolder,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )),
                                    )),
