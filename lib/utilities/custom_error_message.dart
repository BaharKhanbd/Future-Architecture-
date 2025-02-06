import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomSnackBar(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(Icons.warning, size: 24.sp, color: Colors.white),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Retry',
        textColor: Colors.yellow,
        onPressed: () {},
      ),
    ),
  );
}
