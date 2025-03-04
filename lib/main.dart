import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:krishi/forms/forms_screen.dart';
import 'package:krishi/forms/tools_form.dart';
import 'package:krishi/provider/cat_provider.dart';
import 'package:krishi/provider/product_provider.dart';
import 'package:krishi/screens/authentication/email_auth_screen.dart';
import 'package:krishi/screens/authentication/email_verification_screen.dart';
import 'package:krishi/screens/authentication/reset_password_screen.dart';
import 'package:krishi/screens/categories/category_list.dart';
import 'package:krishi/screens/categories/subCat_screen.dart';
import 'package:krishi/screens/home_screen.dart';
import 'package:krishi/screens/location_screen.dart';
import 'package:krishi/screens/login_screen.dart';
import 'package:krishi/screens/authentication/phoneauth_screen.dart';
import 'package:krishi/screens/main_screen.dart';
import 'package:krishi/screens/playlist_screen.dart';
import 'package:krishi/screens/product_details_screen.dart';
import 'package:krishi/screens/sellitems/seller_category_list.dart';
import 'package:krishi/screens/sellitems/seller_subCat.dart';
import 'package:krishi/screens/splash_screen.dart';
import 'package:krishi/forms/user_review_screen.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType=null;
  runApp(

      MultiProvider(providers:[
        Provider (create: (_) => CategoryProvider()),
        Provider (create: (_) => ProductProvider()),

      ],child:const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
           primaryColor: Colors.indigo,
           fontFamily: 'RobotoSlab-Regular'
       ),
      initialRoute: SplashScreen.id,
      routes:{

        LoginScreen.id: (context) => const LoginScreen(),
        SplashScreen.id: (context) => const SplashScreen(),
        HomeScreen.id:(context)=>const HomeScreen(),
        PhoneAuthScreen.id: (context) => const PhoneAuthScreen(),
        LocationScreen.id: (context) => const LocationScreen(),
        EmailAuthScreen.id: (context) => const EmailAuthScreen(),
        EmailVerificationScreen.id:(context)=>const EmailVerificationScreen(),
        PasswordResetScreen.id:(context)=>const PasswordResetScreen(),
        CategoryListScreen.id:(context)=>const CategoryListScreen(),
        SubCatList.id:(context)=>const SubCatList(),
        MainScreen.id:(context)=>const MainScreen(),
        Playlist.id:(context)=>const Playlist(),
        SellerSubCatList.id:(context)=>const SellerSubCatList(),
        SellerCategory.id :(context)=>const SellerCategory(),
        SellertoolsForm.id :(context)=>const SellertoolsForm(),
        UserReviewScreen.id:(context)=> UserReviewScreen(),
        FormsScreen.id:(context)=>const FormsScreen(),
        ProductDetailsScreen.id:(context)=>const ProductDetailsScreen(),

      },
    )

      /* FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Colors.indigo,
                  fontFamily: 'RobotoSlab-Regular'
              ),
              home: SplashScreen());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Colors.indigo,
                fontFamily: 'RobotoSlab-Regular'
            ),

            home: LoginScreen(),

            routes: {

              LoginScreen.id: (context) => LoginScreen(),
              PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
              LocationScreen.id: (context) => LocationScreen(),
            },
          );
        }
      },
    );*/ ;
  }
}


