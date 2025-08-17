import 'package:flutter_dotenv/flutter_dotenv.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;

void initSocket() {
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  socket = IO.io(
    baseUrl,
    IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build(),
  );

  socket!.connect();

  socket!.onConnect((_) {
    socket!.emit('user_register', {
      'userId': '689639fea90e56c84c89ab44',
      'role': 'driver',
      'coords': [31.1234, 30.1234],
    });
    socket!.on('register:success', (data) {});
  });
}
