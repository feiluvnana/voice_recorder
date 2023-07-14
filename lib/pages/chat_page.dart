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
    );
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
                                                      borderRadius: BorderRadius
                                                          .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  child: Row(children: [
                                                    (model.isRecording)
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              model
                                                                  .pauseRecord();
                                                            },
                                                            child: const Icon(
                                                                Icons.pause))
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
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.all(3.0),
                                            //   child: Container(
                                            //     width: 30,
                                            //     decoration: const BoxDecoration(
                                            //         color: Colors.purple,
                                            //         borderRadius:
                                            //             BorderRadius.only(
                                            //                 topRight:
                                            //                     Radius.circular(
                                            //                         10),
                                            //                 bottomRight:
                                            //                     Radius.circular(
                                            //                         10),
                                            //                 topLeft:
                                            //                     Radius.circular(
                                            //                         5),
                                            //                 bottomLeft:
                                            //                     Radius.circular(
                                            //                         5))),
                                            //     child: GestureDetector(
                                            //       onTap: () {
                                            //         if (model
                                            //             .recorder.isPaused) {
                                            //           model.closePlay();
                                            //           model.resumeRecord();
                                            //         } else {
                                            //           model.pauseRecord();
                                            //           model.startPlay();
                                            //         }
                                            //       },
                                            //       child: const Icon(
                                            //           Icons.keyboard_voice),
                                            //     ),
                                            //   ),
                                            // ),
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
