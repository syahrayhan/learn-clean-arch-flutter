// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:number_trivia_cleanarc/core/platform/network_info.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/data/datasources/number_trivia_local_data_course.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_cleanarc/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    NumberTriviaRepository,
    NumberTriviaLocalDataSource,
    NumberTriviaRemoteDataSource,
    NetworkInfo,
    DataConnectionChecker,
    SharedPreferences,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
