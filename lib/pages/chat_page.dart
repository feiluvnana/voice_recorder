import "package:flutter/material.dart";
import "package:my_crash_course/models/chat_page_model.dart";
import "package:provider/provider.dart";
import "../themes/text_style.dart";

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.purple,
            ),
          ),
          title: Row(children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/avatar.jpg"),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bi Con",
                  style: TextStyles.name,
                ),
                Text(
                  "Hoạt động 5 phút trước",
                  style: TextStyles.action,
                )
              ],
            )
          ]),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                  color: Colors.purple,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.video_call,
                  color: Colors.purple,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.info,
                  color: Colors.purple,
                ))
          ],
        ),
        bottomSheet: const BottomSheet(),
        body: ChatBox());
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatPageModel>(
        create: (_) => ChatPageModel(),
        child: Consumer<ChatPageModel>(
          builder: (context, model, child) {
            return SizedBox(
              height: 50,
              child: Row(
                  children: (model.isRecording)
                      ? [
                          IconButton(
                              onPressed: () {
                                model.closeRecord();
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.purple,
                              )),
                          const Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: RecorderWidget(),
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.send,
                                color: Colors.purple,
                              )),
                        ]
                      : [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.apps,
                                color: Colors.purple,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.purple,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.photo_size_select_actual_rounded,
                                color: Colors.purple,
                              )),
                          IconButton(
                              onPressed: () {
                                model.startRecord();
                              },
                              icon: const Icon(
                                Icons.keyboard_voice_sharp,
                                color: Colors.purple,
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  hintText: "Nhắn tin",
                                  suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.tag_faces_rounded,
                                        color: Colors.purple,
                                      )),
                                ),
                              ),
                            ),
                          )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.thumb_up,
                                color: Colors.purple,
                              )),
                        ]),
            );
          },
        ));
  }
}

class RecorderWidget extends StatelessWidget {
  const RecorderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<ChatPageModel>(context);
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100), color: Colors.purple),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: GestureDetector(
                onTap: () async {
                  model.pauseRecord();
                  showModalBottomSheet(
                          elevation: 8,
                          context: context,
                          builder: (_) {
                            return ChangeNotifierProvider.value(
                              value: model,
                              child: Consumer<ChatPageModel>(
                                builder: (context, model, child) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                          "Ấn vào nút play để chơi.\nChạm hoặc kéo để phát tại bất cứ chỗ nào."),
                                      SizedBox(
                                        height: 65,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                      color: Colors.purple,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(5),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          5))),
                                                  child: Row(children: [
                                                    (model.isRecording)
                                                        ? Container()
                                                        : GestureDetector(
                                                            onTap: () {
                                                              if (model
                                                                  .isPlaying) {
                                                                model
                                                                    .pausePlay();
                                                              } else {
                                                                model
                                                                    .resumePlay();
                                                              }
                                                            },
                                                            child: Icon((model
                                                                    .isPlaying)
                                                                ? Icons.pause
                                                                : Icons
                                                                    .play_arrow),
                                                          ),
                                                    (model.isRecording)
                                                        ? const Spacer()
                                                        : Expanded(
                                                            child: Slider(
                                                              value: model
                                                                  .sliderValue,
                                                              max: model
                                                                  .maxSliderValue,
                                                              min: 0,
                                                              onChanged:
                                                                  (value) {
                                                                model.seekPlay(
                                                                    value);
                                                              },
                                                            ),
                                                          ),
                                                    Text(
                                                        (!model.isRecording)
                                                            ? model.playTxt
                                                            : model.recordTxt,
                                                        style: TextStyles.time),
                                                  ]),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Container(
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                    color: Colors.purple,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            topLeft:
                                                                Radius.circular(
                                                                    5),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    5))),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (model
                                                        .recorder.isPaused) {
                                                      model.closePlay();
                                                      model.resumeRecord();
                                                    } else {
                                                      model.pauseRecord();
                                                      model.startPlay();
                                                    }
                                                  },
                                                  child: Icon(
                                                      model.recorder.isPaused
                                                          ? Icons.keyboard_voice
                                                          : Icons.pause),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(_);
                                              },
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.purple)),
                                          IconButton(
                                              onPressed: () async {
                                                await model.closePlay();
                                                await model.closeRecord();
                                                await model.startRecord();
                                              },
                                              icon: const Icon(
                                                  Icons.restart_alt,
                                                  color: Colors.purple)),
                                          const Expanded(child: Text("")),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.send,
                                                  color: Colors.purple)),
                                        ],
                                      )
                                    ]),
                              ),
                            );
                          },
                          showDragHandle: true)
                      .then((value) {
                    model
                      ..closePlay()
                      ..closeRecord();
                  });
                },
                child: Icon(
                  (!model.isRecording)
                      ? Icons.settings_sharp
                      : Icons.pause_circle,
                )),
          ),
          const Expanded(child: Text("")),
          Text("${model.recordTxt} ", style: TextStyles.time),
        ],
      ),
    );
  }
}

enum ChatPosi { top, mid, bot, alone }

class ChatBox extends StatelessWidget {
  ChatBox({super.key});

  final List<Map<String, dynamic>> chatInfo = [
    {"content": "Hello!", "isMe": true},
    {"content": "Are you there?", "isMe": true},
    {"content": "Can you hear me?", "isMe": true},
    {"content": "Yes!", "isMe": false},
    {
      "content": "I just want to say that you are an extraordinary cat!",
      "isMe": true
    },
    {"content": "Thanks, appreciate that!", "isMe": false},
    {"content": "But you are a bit naughty.", "isMe": true},
    {"content": "But I'm cute so it's all good, right?", "isMe": false},
    {"content": "Meow~!", "isMe": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(chatInfo.length, (index) {
          print(getPosi(index));
          return ChatBubble(
              content: chatInfo[index]["content"],
              isMe: chatInfo[index]["isMe"],
              posi: getPosi(index));
        }));
  }

  ChatPosi getPosi(int index) {
    if (index == 0) {
      if (chatInfo[1]["isMe"] != chatInfo[0]["isMe"]) {
        return ChatPosi.alone;
      } else {
        return ChatPosi.top;
      }
    }
    if (index == chatInfo.length - 1) {
      if (chatInfo[chatInfo.length - 2]["isMe"] !=
          chatInfo[chatInfo.length - 1]["isMe"]) {
        return ChatPosi.alone;
      } else {
        return ChatPosi.bot;
      }
    }
    if (chatInfo[index]["isMe"] != chatInfo[index - 1]["isMe"] &&
        chatInfo[index]["isMe"] != chatInfo[index + 1]["isMe"]) {
      return ChatPosi.alone;
    } else if (chatInfo[index]["isMe"] == chatInfo[index - 1]["isMe"] &&
        chatInfo[index]["isMe"] != chatInfo[index + 1]["isMe"]) {
      return ChatPosi.bot;
    } else if (chatInfo[index]["isMe"] != chatInfo[index - 1]["isMe"] &&
        chatInfo[index]["isMe"] == chatInfo[index + 1]["isMe"]) {
      return ChatPosi.top;
    }
    return ChatPosi.mid;
  }
}

class ChatBubble extends StatelessWidget {
  final String content;
  final bool isMe;
  final ChatPosi posi;
  const ChatBubble(
      {super.key,
      required this.content,
      required this.isMe,
      required this.posi});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.topRight : Alignment.topLeft,
      child: isMe
          ? Container(
              width: MediaQuery.of(context).size.width / 4 * 3,
              padding: const EdgeInsets.all(10),
              margin: getM(),
              decoration: BoxDecoration(
                  color: isMe ? Colors.purple : Colors.grey[200],
                  borderRadius: getBR()),
              child: Text(
                content,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isMe ? Colors.white : null),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: (posi == ChatPosi.alone || posi == ChatPosi.bot)
                      ? const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("images/avatar.jpg"),
                          ),
                        )
                      : null,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4 * 3,
                  padding: const EdgeInsets.all(10),
                  margin: getM(),
                  decoration: BoxDecoration(
                      color: isMe ? Colors.purple : Colors.grey[200],
                      borderRadius: getBR()),
                  child: Text(
                    content,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isMe ? Colors.white : null),
                  ),
                ),
              ],
            ),
    );
  }

  EdgeInsets getM() {
    switch (posi) {
      case ChatPosi.top:
        return const EdgeInsets.only(top: 5, bottom: 0.5);
      case ChatPosi.bot:
        return const EdgeInsets.only(bottom: 5, top: 0.5);
      case ChatPosi.alone:
        return const EdgeInsets.symmetric(vertical: 5);
      default:
        return const EdgeInsets.symmetric(vertical: 0.5);
    }
  }

  BorderRadius getBR() {
    if (isMe) {
      switch (posi) {
        case ChatPosi.top:
          return const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(5));
        case ChatPosi.alone:
          return BorderRadius.circular(10);
        case ChatPosi.bot:
          return const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10));
        default:
          return const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(5));
      }
    } else {
      switch (posi) {
        case ChatPosi.top:
          return const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(10));
        case ChatPosi.alone:
          return BorderRadius.circular(10);
        case ChatPosi.bot:
          return const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10));
        default:
          return const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(10));
      }
    }
  }
}
