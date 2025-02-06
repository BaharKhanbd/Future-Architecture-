import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF438EB8),
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: const Color(0xFF087DB3),
      leading: onBackTap != null
          ? InkWell(
              onTap: onBackTap,
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24.0.sp,
              ),
            )
          : const SizedBox.shrink(),
      leadingWidth: 40.w,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18.0.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
