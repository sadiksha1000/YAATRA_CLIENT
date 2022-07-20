import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:yaatra_client/core/config/light_theme.dart';
import 'package:yaatra_client/core/config/route_generator.dart';
import 'package:yaatra_client/core/network/network_info.dart';
import 'package:yaatra_client/core/utils/input_converter.dart';
import 'package:yaatra_client/core/utils/input_validator.dart';
import 'package:yaatra_client/features/app/presentation/blocs/app/app_bloc.dart';
import 'package:yaatra_client/features/authentication/data/datasources/user_remote_datasource.dart';
import 'package:yaatra_client/features/authentication/domain/usecases/refresh_current_user.dart';
import 'package:yaatra_client/features/authentication/domain/usecases/register_user_usecase.dart';
import 'package:yaatra_client/features/authentication/domain/usecases/send_otp_to_phone_usecase.dart';
import 'package:yaatra_client/features/authentication/domain/usecases/switch_user_role_usecase.dart';
import 'package:yaatra_client/features/authentication/presentation/blocs/cubit/auth_cubit.dart';
import 'package:yaatra_client/features/passenger/booking/data/datasources/booking_remote_datasource.dart';
import 'package:yaatra_client/features/passenger/booking/domain/repositories/booking_repository.dart';
import 'package:yaatra_client/features/passenger/booking/domain/usecases/check_seat_availability_usecase.dart';
import 'package:yaatra_client/features/passenger/booking/domain/usecases/create_booking_usecase.dart';
import 'package:yaatra_client/features/passenger/booking/presentation/cubit/booking_cubit.dart';
import 'package:yaatra_client/features/passenger/booking/presentation/cubit/booking_session_cubit.dart';
import 'package:yaatra_client/features/passenger/profile/data/datasources/passenger_profile_remote_datasourse.dart';
import 'package:yaatra_client/features/passenger/profile/data/repositories/profile_repository_impl.dart';
import 'package:yaatra_client/features/passenger/profile/domain/repositories/passenger_profile_repositories.dart';
import 'package:yaatra_client/features/passenger/profile/domain/usecases/create_passenger_profile_usecase.dart';
import 'package:yaatra_client/features/passenger/profile/domain/usecases/get_passenger_usecase.dart';
import 'package:yaatra_client/features/passenger/profile/presentation/cubit/passenger_profile_cubit.dart';
import 'package:yaatra_client/features/bus/data/datasources/bus_remote_datasource.dart';
import 'package:yaatra_client/features/bus/domain/repositories/bus_repository.dart';
import 'package:yaatra_client/features/bus/domain/usecases/fetch_allbuses_usecase.dart';
import 'package:yaatra_client/features/bus/domain/usecases/fetch_stations_usecase.dart';
import 'package:yaatra_client/features/bus/presentation/cubits/search_bus_cubit/search_bus_cubit.dart';
import 'package:yaatra_client/features/passenger/applyasagent/data/datasources/apply_as_agent_remote_datasource.dart';
import 'package:yaatra_client/features/passenger/applyasagent/domain/repositories/apply_as_agent_repository.dart';
import 'package:yaatra_client/features/passenger/applyasagent/domain/usecases/refresh_apply_as_agent_usecase.dart';
import 'package:yaatra_client/features/ticket/fetch_ticket/domain/usecases/fetch_bookings_usecase.dart';
import 'package:yaatra_client/features/trips/domain/usecases/fetch_trip_byid_usecase.dart';

import 'core/config/dark_theme.dart';
import 'features/authentication/data/repositories/user_repository_impl.dart';
import 'features/authentication/domain/repositories/user_repository.dart';
import 'features/authentication/domain/usecases/login_user_usecase.dart';
import 'features/authentication/presentation/screens/login_screen.dart';
import 'features/bus/data/repositories/bus_repository_impl.dart';
import 'features/bus/presentation/cubits/fetch_bus_cubit/fetch_buses_cubit.dart';
import 'features/passenger/applyasagent/data/repositories/apply_as_agent_repository_impl.dart';
import 'features/passenger/applyasagent/domain/usecases/apply_as_agent_usecase.dart';
import 'features/passenger/applyasagent/presentation/cubits/cubit/apply_as_agent_cubit.dart';
import 'features/passenger/booking/data/repositories/booking_repository_impl.dart';
import 'features/shared/image/data/datasources/upload_image_remote_datasource.dart';
import 'features/shared/image/data/repositories/image_repository_impl.dart';
import 'features/shared/image/domain/repositories/image_repository.dart';
import 'features/shared/image/domain/usecases/upload_image_usecase.dart';
import 'features/shared/image/presentation/image_cubit/image_cubit.dart';
import 'features/ticket/fetch_ticket/data/datasources/fetch_ticket_remote_datasource.dart';
import 'features/ticket/fetch_ticket/data/repositories/fetch_ticket_repository_impl.dart';
import 'features/ticket/fetch_ticket/domain/repositories/fetch_ticket_repository.dart';
import 'features/ticket/fetch_ticket/presentation/cubits/tickets/fetch_tickets_cubit.dart';
import 'features/trips/data/datasources/trip_remote_datasource.dart';
import 'features/trips/data/repositories/trip_repository_impl.dart';
import 'features/trips/domain/repositories/trip_repository.dart';
import 'features/trips/domain/usecases/fetch_trips_usecase.dart';
import 'features/trips/presentation/cubits/fetch_station_cubit/fetch_station_cubit.dart';
import 'features/trips/presentation/cubits/fetch_trip_cubit/fetch_trip_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedStorage storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  return HydratedBlocOverrides.runZoned(() async {
    InputValidator inputValidator = InputValidator();
    InputConverter inputConverter = InputConverter();
    DataConnectionChecker dataConnectionChecker = DataConnectionChecker();
    NetworkInfo networkInfo =
        NetworkInfoImpl(connectionChecker: dataConnectionChecker);

    // data sources
    http.Client client = http.Client();
    UserRemoteDataSource userRemoteDataSource =
        UserRemoteDataSourceImpl(client: client);
    BusRemoteDataSource busRemoteDataSource =
        BusRemoteDataSourceImpl(client: client);
    TripRemoteDataSource tripRemoteDataSource =
        TripRemoteDataSourceImpl(client: client);
    FetchTicketRemoteDataSource fetchTicketRemoteDataSource =
        FetchTicketRemoteDataSourceImpl(client: client);
    ApplyAsAgentRemoteDataSource applyAsAgentRemoteDataSource =
        ApplyAsAgentRemoteDataSourceImpl(client: client);
    UploadImageRemoteDataSource imageRemoteDataSource =
        UploadImageRemoteDataSourceImpl(client: client);
    PassengerProfileRemoteDataSource passengerProfileRemoteDataSource =
        PassengerProfileRemoteDataSourceImpl(client: client);
    BookingRemoteDataSource bookingRemoteDataSource =
        BookingRemoteDataSourceImpl(client: client);

    // repositories
    UserRepository userRepository = UserRepositoryImpl(
      remoteDataSource: userRemoteDataSource,
      networkInfo: networkInfo,
    );
    BusRepository busRepository = BusRepositoryImpl(
      remoteDataSource: busRemoteDataSource,
      networkInfo: networkInfo,
    );
    TripRepository tripRepository = TripRepositoryImpl(
      remoteDataSource: tripRemoteDataSource,
      networkInfo: networkInfo,
    );
    FetchTicketRepository fetchTicketRepository = FetchTicketRepositoryImpl(
      remoteDataSource: fetchTicketRemoteDataSource,
      networkInfo: networkInfo,
    );
    ApplyAsAgentRepository applyAsAgentRepository = ApplyAsAgentRepositoryImpl(
      remoteDataSource: applyAsAgentRemoteDataSource,
      networkInfo: networkInfo,
    );

    ImageRepository imageRepository = ImageRepositoryImpl(
        uploadImageRemoteDataSource: imageRemoteDataSource,
        networkInfo: networkInfo);

    PassengerProfileRepository passengerProfileRepository =
        PassengerProfileRepositoryImpl(
            remoteDataSource: passengerProfileRemoteDataSource,
            networkInfo: networkInfo);

    BookingRepository bookingRepository = BookingRepositoryImpl(
      remoteDataSource: bookingRemoteDataSource,
      networkInfo: networkInfo,
    );

    // usecase
    RegisterUserUseCase registerUserUseCase = RegisterUserUseCase(
      userRepository: userRepository,
    );
    SendOTPToPhoneUseCase sendOTPToPhoneUseCase =
        SendOTPToPhoneUseCase(userRepository);
    LoginUserUseCase loginUserUseCase = LoginUserUseCase(userRepository);
    FetchAllBusesUseCase fetchAllBusesUseCase =
        FetchAllBusesUseCase(busRepository);
    FetchAllStationsUseCase fetchAllStationsUseCase =
        FetchAllStationsUseCase(busRepository);
    FetchTripsUseCase fetchTripUseCase = FetchTripsUseCase(tripRepository);
    FetchTripByIdUseCase fetchTripByIdUseCase =
        FetchTripByIdUseCase(tripRepository);
    CreateBookingUseCase createBookingUseCase =
        CreateBookingUseCase(bookingRepository);
    FetchBookingsUseCase fetchBookingsUseCase =
        FetchBookingsUseCase(fetchTicketRepository);
    RefreshCurrentUserUseCase refreshCurrentUserUseCase =
        RefreshCurrentUserUseCase(userRepository);
    SwitchUserRoleUseCase switchUserRoleUseCase =
        SwitchUserRoleUseCase(userRepository);
    ApplyAsAgentUseCase applyAsAgentUseCase =
        ApplyAsAgentUseCase(applyAsAgentRepository);
    RefreshApplyAsAgentUseCase refreshApplyAsAgentUseCase =
        RefreshApplyAsAgentUseCase(applyAsAgentRepository);
    UploadImagesUseCase uploadImagesUseCase =
        UploadImagesUseCase(imageRepository: imageRepository);
    GetCurrentPassengerUsecase currentPassengerUsecase =
        GetCurrentPassengerUsecase(passengerProfileRepository);
    CreateProfileUseCase createProfileUseCase =
        CreateProfileUseCase(profileRepository: passengerProfileRepository);

    CheckSeatAvailabilityUseCase checkSeatAvailabilityUsecase =
        CheckSeatAvailabilityUseCase(bookingRepository);

    // cubits
    AuthCubit registerCubit = AuthCubit(
      registerUseCase: registerUserUseCase,
      sendOTPUseCase: sendOTPToPhoneUseCase,
      inputConverter: inputConverter,
      inputValidator: inputValidator,
      loginUseCase: loginUserUseCase,
      refreshCurrentUser: refreshCurrentUserUseCase,
      switchUserRole: switchUserRoleUseCase,
    );

    AppBloc appBloc = AppBloc(authRepository: userRepository);

    FetchAllBusesCubit busCubit = FetchAllBusesCubit(
      fetchBusesCase: fetchAllBusesUseCase,
      network: networkInfo,
    );

    FetchStationCubit stationCubit = FetchStationCubit(
      fetchStationsCase: fetchAllStationsUseCase,
      network: networkInfo,
    );

    SearchBusCubit searchBusCubit = SearchBusCubit(
        network: networkInfo, fetchBusesCase: fetchAllBusesUseCase);

    FetchTripCubit tripCubit =
        FetchTripCubit(network: networkInfo, fetchTripsCase: fetchTripUseCase);

    FetchTicketsCubit fetchTicketCubit = FetchTicketsCubit(
        network: networkInfo, fetchBookingCase: fetchBookingsUseCase);

    ApplyAsAgentCubit applyAsAgentCubit = ApplyAsAgentCubit(
      networkInfo: networkInfo,
      applyAsAgentUseCase: applyAsAgentUseCase,
      refreshApplyAsAgentUseCase: refreshApplyAsAgentUseCase,
    );

    ImageCubit imageCubit = ImageCubit(upImageUseCase: uploadImagesUseCase);

    PassengerProfileCubit passengerProfileCubit = PassengerProfileCubit(
        networkInfo: networkInfo,
        getCurrentPassenger: currentPassengerUsecase,
        createProfileUseCase: createProfileUseCase);

    BookingCubit bookingCubit = BookingCubit(
      fetchTripById: fetchTripByIdUseCase,
      createBooking: createBookingUseCase,
    );

    BookingSessionCubit bookingSessionCubit = BookingSessionCubit(
      checkSeatAvailability: checkSeatAvailabilityUsecase,
    );

    runApp(MyApp(
      registerCubit: registerCubit,
      appBloc: appBloc,
      userRepository: userRepository,
      busCubit: busCubit,
      stationCubit: stationCubit,
      searchBusCubit: searchBusCubit,
      fetchTripCubit: tripCubit,
      fetchTicketCubit: fetchTicketCubit,
      applyAsAgentCubit: applyAsAgentCubit,
      imageCubit: imageCubit,
      passengerProfileCubit: passengerProfileCubit,
      bookingCubit: bookingCubit,
      bookingSessionCubit: bookingSessionCubit,
    ));
  }, storage: storage);
}

class MyApp extends StatelessWidget {
  AuthCubit registerCubit;
  AppBloc appBloc;
  UserRepository userRepository;
  FetchAllBusesCubit busCubit;
  FetchStationCubit stationCubit;
  SearchBusCubit searchBusCubit;
  FetchTripCubit fetchTripCubit;
  FetchTicketsCubit fetchTicketCubit;
  ApplyAsAgentCubit applyAsAgentCubit;
  ImageCubit imageCubit;
  PassengerProfileCubit passengerProfileCubit;
  BookingCubit bookingCubit;
  BookingSessionCubit bookingSessionCubit;
  MyApp({
    Key? key,
    required this.registerCubit,
    required this.appBloc,
    required this.userRepository,
    required this.busCubit,
    required this.stationCubit,
    required this.searchBusCubit,
    required this.fetchTripCubit,
    required this.fetchTicketCubit,
    required this.applyAsAgentCubit,
    required this.imageCubit,
    required this.passengerProfileCubit,
    required this.bookingCubit,
    required this.bookingSessionCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AppBloc>(
        create: (context) => AppBloc(
          authRepository: userRepository,
        ),
      ),
      BlocProvider<AuthCubit>(
        create: (context) => registerCubit,
      ),
      BlocProvider<FetchAllBusesCubit>(
        create: (context) => busCubit,
      ),
      BlocProvider<FetchStationCubit>(
        create: (context) => stationCubit,
      ),
      BlocProvider<FetchTripCubit>(
        create: (context) => fetchTripCubit,
      ),
      BlocProvider<SearchBusCubit>(
        create: (context) => searchBusCubit,
      ),
      BlocProvider<FetchTicketsCubit>(
        create: (context) => fetchTicketCubit,
      ),
      BlocProvider<ApplyAsAgentCubit>(
        create: (context) => applyAsAgentCubit,
      ),
      BlocProvider<ImageCubit>(
        create: (context) => imageCubit,
      ),
      BlocProvider<PassengerProfileCubit>(
          create: (context) => passengerProfileCubit),
      BlocProvider<BookingCubit>(
        create: (context) => bookingCubit,
      ),
      BlocProvider<BookingSessionCubit>(
        create: (context) => bookingSessionCubit,
      ),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: 'test_public_key_14496a78b9384fffae61e3b8e969a4a8',
      builder: ((context, navigatorKey) => MaterialApp(
            navigatorKey: navigatorKey,
            onGenerateRoute: RouteGenerator.generateRoute,
            title: 'Yaatra Client',
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: ThemeMode.light,
            supportedLocales: const <Locale>[
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            home: const LoginScreen(),
          )),
    );
  }
}
