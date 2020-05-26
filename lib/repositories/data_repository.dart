import 'dart:async';

import 'package:web_socket_channel/io.dart';

class DataRepository {
  //I was wondering about putting the connection to the web socket in a separate file.
  static const _serverAddress = 'ws://192.168.0.104:8080';

  Stream<String> dataStream() {
    return IOWebSocketChannel.connect(_serverAddress).stream.cast<String>();
  }
}
