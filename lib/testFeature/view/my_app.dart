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
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            print("PRINTEO ESTADO ${state.messages}");
            return Stack(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ListView(
                    children:
                        state.messages.map((message) => Text(message)).toList(),
                  ),
                )
                // const SizedBox(height: 24),
                ,
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Form(
                            child: TextFormField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                  labelText: 'Send a message'),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => context
                              .read<ChatCubit>()
                              .sendMessage(_controller.text),
                          color: Colors.black,
                          iconSize: 30,
                          // child: Text("Send")),
                        ),
                        // ElevatedButton(
                        //     onPressed: () => context
                        //         .read<ChatCubit>()
                        //         .sendMessage(_controller.text),
                        //     child: Text('asdsd'))
                      ],
                    ),
                  ),
                ),
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
