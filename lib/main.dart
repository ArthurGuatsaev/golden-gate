import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../firebase_options.dart';
import '../notes/import.dart';
import '../error/domain/bloc/error_bloc.dart';
import '../loading/import.dart';
import '../nav_manager.dart';
import '../home/domain/bloc/home_bloc.dart';
import '../const/import.dart';
import '../pages/import.dart';
import '../car/import.dart';
import '../valute/domain/repository/valute_repository.dart';
import '../valute/domain/bloc/valute_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final appDir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([VNotesIssarSchema, CarModelSchema],
      directory: appDir.path);
  final StreamController<String> errorController = StreamController();
  final error = ErrorBloc(errorController: errorController);
  final ValuteRepository valuteRepository =
      ValuteRepository(errorController: errorController, isar: isar);
  final NoteRepository noteRepository =
      NoteRepository(errorController: errorController, isar: isar);
  final ServRepo services = ServRepo();
  final CarRepository carRepository =
      CarRepository(isar: isar, errorController: errorController);
  final CheckRepo checkRepo = CheckRepo(errorController: errorController);
  final MyLoadRepo onbordRepo = MyLoadRepo(errorController: errorController);
  final RemoteRepo firebaseRemote =
      RemoteRepo(errorController: errorController);
  final navi = MyNavigatorManager.instance;
  final load = LoadBloc(
    servicesRepo: services,
    noteRepository: noteRepository,
    loadingRepo: onbordRepo,
    checkRepo: checkRepo,
    carRepository: carRepository,
    firebaseRemote: firebaseRemote,
  )
    ..add(NoteRepoInitEvent())
    ..add(NFTRepoInitEvent())
    ..add(FirebaseRemoteInitEvent());
  runApp(
    MyApp(
      navi: navi,
      load: load,
      carRepository: carRepository,
      noteRepository: noteRepository,
      checkRepo: checkRepo,
      valuteRepository: valuteRepository,
      firebaseRemote: firebaseRemote,
      onbordRepo: onbordRepo,
      error: error,
    ),
  );
}

class MyApp extends StatelessWidget {
  final CheckRepo checkRepo;
  final MyLoadRepo onbordRepo;
  final RemoteRepo firebaseRemote;
  final CarRepository carRepository;
  final MyNavigatorManager navi;
  final NoteRepository noteRepository;
  final ValuteRepository valuteRepository;
  final LoadBloc load;
  final ErrorBloc error;
  const MyApp({
    super.key,
    required this.navi,
    required this.valuteRepository,
    required this.load,
    required this.carRepository,
    required this.noteRepository,
    required this.error,
    required this.checkRepo,
    required this.onbordRepo,
    required this.firebaseRemote,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => checkRepo,
        ),
        RepositoryProvider(
          create: (context) => onbordRepo,
        ),
        RepositoryProvider(
          create: (context) => firebaseRemote,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoadBloc>(
            create: (context) => load,
          ),
          BlocProvider<ErrorBloc>(
            create: (context) => error,
          ),
          BlocProvider<ValuteBloc>(
            lazy: false,
            create: (context) => ValuteBloc(repository: valuteRepository)
              ..add(GetValutePriceEvent()),
          ),
          BlocProvider<NoteBloc>(
            create: (context) =>
                NoteBloc(noteRepo: noteRepository)..add(GetNotesEvent()),
          ),
          BlocProvider<CarBloc>(
            create: (context) =>
                CarBloc(nftRepository: carRepository)..add(GetSaveNFTEvent()),
          ),
          BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navi.key,
          theme: ThemeData(
            primaryColor: primary,
            appBarTheme: const AppBarTheme(
                backgroundColor: backgroundColor, elevation: 0),
            scaffoldBackgroundColor: backgroundColor,
            iconTheme: const IconThemeData(color: Colors.white),
            textTheme: const TextTheme(
              bodySmall: TextStyle(fontSize: 10),
              bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              labelSmall: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
              displaySmall: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
              displayMedium: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w700),
              labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          onGenerateRoute: navi.onGenerateRoute,
          initialRoute: SplashPage.routeName,
        ),
      ),
    );
  }
}
