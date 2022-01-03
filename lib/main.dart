import 'package:encrypted_messaging/models/user_model.dart';
import 'package:encrypted_messaging/screens/auth/register/register.dart';
import 'package:encrypted_messaging/screens/contacts/contacts.dart';
import 'package:encrypted_messaging/screens/home/home.dart';
import 'package:encrypted_messaging/services/providers/providers.dart';
import 'package:encrypted_messaging/services/theme/theme_index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(Vars.userBox);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IsLoginPage()),
        ChangeNotifierProvider(create: (_) => LoadingState()),
        ChangeNotifierProvider(create: (_) => SearchQuery()),
        ChangeNotifierProvider(create: (_) => DeleteContact()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Gilroy',
        ),
        home: Wrapper(),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser != null ? Home() : Register();
  }
}

class PageGate extends StatelessWidget {
  const PageGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context, listen: false);
    if (pageProvider.page == 0) {
      return Home();
    } else if (pageProvider.page == 1) {
      return Contacts();
    } else {
      return Home();
    }
  }
}
