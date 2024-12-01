import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/blocs/auth/auth_bloc.dart';
import 'package:ecommerce_app/blocs/categories/categories_bloc.dart';
import 'package:ecommerce_app/blocs/products/products_bloc.dart';
import 'package:ecommerce_app/blocs/profile/profile_cubit.dart';
import 'package:ecommerce_app/blocs/signin/signin_cubit.dart';
import 'package:ecommerce_app/blocs/signup/signup_cubit.dart';
import 'package:ecommerce_app/repositories/auth_repository.dart';
import 'package:ecommerce_app/repositories/categories_repository.dart';
import 'package:ecommerce_app/repositories/products_repository.dart';
import 'package:ecommerce_app/repositories/profile_repository.dart';
import 'package:ecommerce_app/screens/bucket_screen.dart';
import 'package:ecommerce_app/screens/liked_screen.dart';
import 'package:ecommerce_app/screens/registration/signin_screen.dart';
import 'package:ecommerce_app/screens/registration/signup_screen.dart';
import 'package:ecommerce_app/screens/registration/profile_screen.dart';
import 'package:ecommerce_app/screens/search_screen.dart';
import 'package:ecommerce_app/screens/shops_screen.dart';
import 'package:ecommerce_app/screens/splash_screen.dart';
import 'package:ecommerce_app/utils/my_flutter_app_icons.dart';
import 'package:ecommerce_app/screens/for_you_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/catalog/catalog_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseFirestore: FirebaseFirestore.instance,
              firebaseAuth: FirebaseAuth.instance),
        ),
        RepositoryProvider<ProfileRepository>(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<ProductsRepository>(
          create: (context) => ProductsRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
        RepositoryProvider<CategoriesRepository>(
          create: (context) => CategoriesRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal.shade400),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          SignInScreen.routeName: (context) => SignInScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          ProfileScreen.routeName: (context) => ProfileScreen(),
          '/': (context) => MyHomePage(),
          CatalogScreen.routeName: (context) => CatalogScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String routeName = '/';
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double iconSize = 35;
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    ForYouScreen(),
    SearchScreen(),
    FullscreenBackgroundImage(),
    LikedScreen(),
    ShopsScreen()
  ];




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(MyFlutterApp.logo,
                  size: 24,
                  color: _selectedIndex == 0 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(0);
              },
              enableFeedback: false,
              splashRadius: 100,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.search,
                  size: 24,
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(1);
              },
              enableFeedback: false,
              splashRadius: 70,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.shopping_bag_outlined,
                  size: 24,
                  color: _selectedIndex == 2 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(2);
              },
              enableFeedback: false,
              splashRadius: 70,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.favorite_outline,
                  size: 24,
                  color: _selectedIndex == 3 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(3);
              },
              enableFeedback: false,
              splashRadius: 70,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.shop_2_outlined,
                  size: 24,
                  color: _selectedIndex == 4 ? Colors.black : Colors.grey),
              onPressed: () {
                _onItemTapped(4);
              },
              splashRadius: 70,
            ),
          ],
        ),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
