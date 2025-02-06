import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_architecture/ui/screens/login_screen.dart';
import 'package:future_architecture/utilities/custom_loading.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../provider/product_provider.dart';
import '../widgets/product_card.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.teal.shade800,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        leadingWidth: 60.w,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.menu,
            size: 28.sp,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        backgroundColor: const Color(0xFF126172),
        titleSpacing: 0.0,
        title: Row(
          children: [
            // Image.asset(
            //   color: Colors.white,
            //   "assets/icons/dlc_icon.png",
            //   height: 35.h,
            //   width: 40.w,
            // ),
            // SizedBox(width: 8.w),
            Text(
              "Future Architecture",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              QuickAlert.show(
                context: context,
                type: QuickAlertType.confirm,
                title: 'Logout Confirmation',
                text: 'Are you sure you want to log out?',
                confirmBtnText: 'Yes',
                cancelBtnText: 'No',
                onConfirmBtnTap: () async {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                    (route) => false,
                  );
                },
              );
            },
            child: Icon(
              Icons.logout,
              size: 28.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: productProvider.isLoading
          ? CustomLoading()
          : ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return ProductCard(product: product);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productProvider.fetchProducts();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
