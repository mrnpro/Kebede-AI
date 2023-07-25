import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kebede_ai/modules/Prompt/presentation/PromptBloc/prompt_bloc.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/hex_color.dart';
import '../../../../di/injection_container.dart';
import 'package:rive/rive.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  late PromptBloc _promptBloc;
  @override
  void initState() {
    _promptBloc = getIt();
    super.initState();
  }

  @override
  void dispose() {
    _promptBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _promptBloc,
        child: Scaffold(
          body: _body(),
        ));
  }

  Center _body() {
    return Center(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _topLayer(),
            _kebedeAvatar(),
            _holdSpeak(),
            _bottomLayer(),
          ],
        ),
      ),
    );
  }

  Column _kebedeAvatar() {
    return Column(
      children: [
        Container(
          height: 210,
          width: 210,
          decoration: BoxDecoration(
              color: HexColor('21002C'),
              border: Border.all(width: 8, color: kSecondaryColor),
              borderRadius: BorderRadius.circular(500)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: BlocConsumer<PromptBloc, PromptState>(
                listener: (context, state) {
              if (state is PromptError) {
                // handle the error here , like do a toast.
                Fluttertoast.showToast(
                    msg: state.error ?? "Something went wrong");
              }
            }, builder: (context, state) {
              if (state is KebedeListening) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KebedeAnim(controller: SimpleAnimation('listening')),
                    Text("Listening",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor))
                  ],
                );
              } else if (state is KebedeSpeaking) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KebedeAnim(controller: SimpleAnimation('speaking')),
                    Text("Speaking",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor))
                  ],
                );
              } else if (state is KebedeThinking) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KebedeAnim(controller: SimpleAnimation('loading')),
                    Text("Thinking",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor))
                  ],
                );
              }

              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KebedeAnim(controller: SimpleAnimation('lost in thought')),
                    Text("Lost In Thought ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor))
                  ]);
            }),
          ),
        )
      ],
    );
  }

  GestureDetector _holdSpeak() {
    return GestureDetector(
      onLongPressEnd: (LongPressEndDetails longPressEndDetails) {
        _promptBloc.add(StopSpeakEvent());
      },
      onLongPress: () {
        _promptBloc.add(const SpeakEvent());
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: HexColor('21002C'),
            border: Border.all(width: 2, color: kSecondaryColor),
            borderRadius: BorderRadius.circular(100)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mic, size: 50, color: kSecondaryColor),
            Text("HOLD",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: kSecondaryColor))
          ],
        )),
      ),
    );
  }

  SvgPicture _bottomLayer() =>
      SvgPicture.asset('assets/svg/bottom_br_line.svg');

  Stack _topLayer() {
    return Stack(
      children: [
        Positioned(
            right: 15,
            top: 20,
            child: Icon(
              Icons.settings,
              color: kSecondaryColor,
              size: 40,
            )),
        SvgPicture.asset('assets/svg/top_br_line.svg'),
        Positioned(
            top: 12,
            left: 12,
            child: SizedBox(
              width: 150,
              child: SvgPicture.asset('assets/svg/kebede_ai_text.svg'),
            )),
      ],
    );
  }
}

class KebedeAnim extends StatelessWidget {
  const KebedeAnim({
    super.key,
    required RiveAnimationController controller,
  }) : _controller = controller;

  final RiveAnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: RiveAnimation.asset(
          'assets/animations/kebede_animation.riv',
          controllers: [_controller],
        ));
  }
}
