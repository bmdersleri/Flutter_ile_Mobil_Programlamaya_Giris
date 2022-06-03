import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<void> main() async {
  // Check internet connection with singleton (no custom values allowed)
  // await execute(InternetConnectionChecker());

}

Future<bool> execute(InternetConnectionChecker internetConnectionChecker) async {

  // Simple check to see if we have Internet
  // ignore: avoid_print
  print('''The statement 'this machine is connected to the Internet' is: ''');
  final bool isConnected = await InternetConnectionChecker().hasConnection;

  return isConnected;

  // ignore: avoid_print
  print(
    isConnected.toString(),
  );
  // returns a bool

  // We can also get an enum instead of a bool
  // ignore: avoid_print
  // print(
  //   'Current status: ${await InternetConnectionChecker().connectionStatus}',
  // );
  // Prints either InternetConnectionStatus.connected
  // or InternetConnectionStatus.disconnected

  // // actively listen for status updates
  // final StreamSubscription<InternetConnectionStatus> listener =
  // InternetConnectionChecker().onStatusChange.listen(
  //       (InternetConnectionStatus status) {
  //     switch (status) {
  //       case InternetConnectionStatus.connected:
  //       // ignore: avoid_print
  //         print('Data connection is available.');
  //         break;
  //       case InternetConnectionStatus.disconnected:
  //       // ignore: avoid_print
  //         print('You are disconnected from the internet.');
  //         break;
  //     }
  //   },
  // );

  // // close listener after 30 seconds, so the program doesn't run forever
  // await Future<void>.delayed(const Duration(seconds: 5));
  // await listener.cancel();

}