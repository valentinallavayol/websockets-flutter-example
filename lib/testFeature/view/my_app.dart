import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websockets_example/testFeature/bloc/message_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            print("PRINTEO ESTADO ${state.messages}");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  child: TextFormField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(labelText: 'Send a message'),
                  ),
                ),
                const SizedBox(height: 24),
                ...state.messages.map((message) => Text(message)),
                // BlocBuilder<MessageCubit, MessageState>(
                //   builder: (context, state) {
                //     return Text(state);
                //   },
                // ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<ChatCubit>().sendMessage(_controller.text),
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
