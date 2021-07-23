import 'package:flutter/material.dart';

import '../models/message_model.dart';

import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart';

class ControlsOverlay extends StatefulWidget {
  final Function exitpage;
  ControlsOverlay({required this.exitpage});
  @override
  ControlsOverlayState createState() => ControlsOverlayState();
}

class ControlsOverlayState extends State<ControlsOverlay> {
  late double height, width;
  bool _controls = false;
  bool _chatbox = false;
  late TextEditingController textController;
  late ScrollController scrollController;
  late Socket socketIO;
  List<MessageModel> _messages = [];
  int _userCount = 0;
  int _limit = 10;

  @override
  void initState() {
    textController = TextEditingController();
    textController.text = '';
    scrollController = ScrollController();
    socketIO = io('https://wschatws.herokuapp.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socketIO.connect();
    socketIO.on('message', (jsonData) {
      try {
        Map<String, dynamic> data = json.decode(jsonData);
        MessageModel msg = MessageModel(
          username: data['username'],
          message: data['message'],
          id: data['id'],
        );
        if (_messages.length >= _limit) {
          _messages.removeAt(0);
        }
        this.setState(() => _messages.add(msg));
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } catch (e) {
        print('error ${e.toString()}');
      }
    });
    socketIO.on('usercount', (count) {
      try {
        this.setState(() => _userCount = count as int);
      } catch (e) {
        print('error2 ${e.toString()} end');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    socketIO.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
      // print('called after build');
    });
    final mq = MediaQuery.of(context).size;
    height = mq.height;
    width = mq.width;
    return Stack(
      children: <Widget>[
        _controls
            ? Container(
                color: Colors.black54,
                child: Stack(
                  children: [
                    Positioned(
                      top: mq.height * 0.75,
                      left: mq.width * 0.4,
                      child: RawMaterialButton(
                        onPressed: () {
                          widget.exitpage();
                        },
                        elevation: 2.0,
                        fillColor: Colors.red,
                        child: Icon(
                          Icons.call_end,
                          size: 25.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                    ),
                    Positioned(
                      top: mq.height * 0.75,
                      left: mq.width * 0.5,
                      child: RawMaterialButton(
                        onPressed: () {
                          this.setState(() {
                            _chatbox = true;
                          });
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          Icons.message_outlined,
                          size: 25.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                    ),
                    _chatbox
                        ? Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(left: mq.width * 0.5),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xedededed),
                              border: Border.all(color: Colors.white),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: width * 0.02),
                                    height: height * 0.84,
                                    width: width,
                                    // color: Colors.black12,
                                    padding: EdgeInsets.only(
                                        top: 8, left: 10, right: 10),
                                    child: ListView.builder(
                                      // reverse: true,
                                      // shrinkWrap: true,
                                      controller: scrollController,
                                      itemCount: _messages.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          alignment: _messages[index].isMe
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                left: 10,
                                                right: 10),
                                            margin: const EdgeInsets.only(
                                                bottom: 10.0),
                                            decoration: BoxDecoration(
                                              color: _messages[index].isMe
                                                  ? Colors.pink[900]
                                                  : Colors.indigo[900],
                                              borderRadius: _messages[index]
                                                      .isMe
                                                  ? BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15),
                                                      // bottomLeft: Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                    )
                                                  : BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15),
                                                      // bottomLeft: Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(12),
                                                    ),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  _messages[index].username,
                                                  style: TextStyle(
                                                      color:
                                                          Colors.blueGrey[100],
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  _messages[index].message,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.37,
                                        // padding: const EdgeInsets.all(2.0),
                                        // margin: const EdgeInsets.only(left: 40.0),
                                        child: TextField(
                                          // autofocus: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.black12,
                                            hintText: 'Send a message...',
                                          ),
                                          controller: textController,
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.014,
                                      ),
                                      FloatingActionButton(
                                        backgroundColor: Colors.orange,
                                        elevation: 2,
                                        onPressed: () {
                                          if (textController.text.isNotEmpty) {
                                            FocusScope.of(context).unfocus();
                                            MessageModel prep = MessageModel(
                                              isMe: true,
                                              username: socketIO.id
                                                  as String, //update here
                                              message: textController.text,
                                              id: socketIO.id as String,
                                            );
                                            socketIO.emit(
                                                'message',
                                                json.encode({
                                                  'id': prep.id,
                                                  'username': prep.username,
                                                  'message': prep.message,
                                                }));
                                            if (_messages.length >= _limit) {
                                              _messages.removeAt(0);
                                            }
                                            this.setState(
                                                () => _messages.add(prep));
                                            textController.text = '';
                                            scrollController.animateTo(
                                              scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeOut,
                                            );
                                          }
                                        },
                                        child: Icon(
                                          Icons.send,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                  //work here
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    _chatbox
                        ? Positioned(
                            top: mq.height * 0.01,
                            left: mq.width * 0.41,
                            child: RawMaterialButton(
                              onPressed: () {
                                this.setState(() {
                                  _chatbox = false;
                                });
                              },
                              elevation: 2.0,
                              fillColor: Colors.white,
                              child: Icon(
                                Icons.cancel_outlined,
                                size: 35.0,
                              ),
                              // padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            : Container(),
        Positioned(
          top: mq.height * 0.04,
          left: mq.width * 0.02,
          child: Card(
            elevation: 1,
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'Live',
                style: TextStyle(
                  color: Colors.white, fontSize: 18,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: mq.height * 0.04,
          left: mq.width * 0.07,
          child: Card(
            elevation: 1,
            color: Colors.grey[400],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    Icons.people,
                    size: 25,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    _userCount.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onDoubleTap: () {
            this.setState(() {
              _controls = !_controls;
            });
          },
        ),
      ],
    );
  }
}
