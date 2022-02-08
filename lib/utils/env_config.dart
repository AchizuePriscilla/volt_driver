import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:volt_driver/utils/utils.dart';

Future<void> loadEnvFile({String path = ".env"}) async {
  try {
    await dotenv.load(fileName: path);
  } catch (e) {
    AppLogger.logger.d(e);
  }
}