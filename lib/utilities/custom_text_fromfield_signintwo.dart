import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFromfieldSignintwo extends StatelessWidget {
  const CustomTextFromfieldSignintwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: SizedBox(
        height: 45.h,
        child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            hintText: "Personal",
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.black),
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(width: 0.5.w, color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(width: 0.5.w, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(width: 0.5.w, color: Colors.grey),
            ),
          ),
          readOnly: true,
        ),
      ),
    );
  }
}
