import 'package:showcase_app/models/response/response_wrapper.dart';

class HttpStatusManager {
  static void handleStatusCode(ResponseWrapper response) {
    switch (response.statusCode) {
      case 200:
      // Handle successful response (HTTP 200)
        print("Successful response: ${response.data}");
        break;
      case 400:
      // Handle bad request (HTTP 400)
        print("Bad request: ${response.message}");
        break;
      case 404:
      // Handle not found (HTTP 404)
        print("Not found: ${response.message}");
        break;
      case 403:
      // Handle forbidden (HTTP 403)
        print("Forbidden: ${response.message}");
        break;
      case 500:
      // Handle internal server error (HTTP 500)
        print("Internal server error: ${response.message}");
        break;
      default:
      // Handle other status codes
        print("Unexpected status code: ${response.statusCode}");
        break;
    }
  }
}
