import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response httpResponse) {
  final response = httpResponse.statusCode;
  final reasonPhrase = httpResponse.reasonPhrase;

  final String errorMessage =
      'Request Failed \n Status Code : $response \n Reason: $reasonPhrase';

  return errorMessage;
}
