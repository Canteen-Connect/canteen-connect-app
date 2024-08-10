import 'package:either_dart/either.dart';
import 'package:foodies/core/secrets/constants/constant.dart';
import 'package:http/http.dart' as http;

class CanteenProvider {
  Future<Either<Exception, http.Response>> getCanteenList() async {
    try {
      final response = await http
          .get(
            Uri.parse('$URL/users/get-all-vendors'),
          )
          .timeout(const Duration(seconds: 10));
      return Right(response);
    } catch (e) {
      throw Left(e);
    }
  }
}
