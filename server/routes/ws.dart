import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

List<dynamic> clients = <dynamic>[];

Handler get onRequest {
  return webSocketHandler((channel, protocol) {
    print('connected');

    clients.add(channel);
    print(clients);

    // final otherClients = clients.where((element) => element != channel);

    for (final client in clients) {
      final coso = client as WebSocketChannel;
      if (coso != channel) {
        coso.sink.add("holaaaaa");
      }

      // client.stream.listen();
    }

    channel.stream.listen(
      (message) {
        final coso = message as String;
        // Handle incoming client messages.
        for (final element in clients) {
          (element as WebSocketChannel).sink.add(coso);
        }
      },
      onDone: () {
        print('disconnected');
        clients.remove(channel);
      },
    );

    // Send a message back to the client.
  });
}
