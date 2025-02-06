import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  // Request storage permission
  static Future<bool> requestStoragePermission(BuildContext context) async {
    // Request storage permission
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      // Permission granted, proceed with image picking
      return true;
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // Permission denied, show the alert dialog
      showAlertDialog(context);
      return false;
    } else if (status.isRestricted) {
      // Permission restricted (e.g., parental control, etc.)
      return false;
    }
    return false;
  }

  // Show permission denied alert dialog
  static void showAlertDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Permission Denied'),
        content: const Text('Allow access to gallery and photos'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
