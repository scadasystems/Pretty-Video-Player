import 'package:example/animation_player/data_manager.dart';
import 'package:pretty_video_player/pretty_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimationPlayerPortraitVideoControls extends StatelessWidget {
  const AnimationPlayerPortraitVideoControls({
    Key? key,
    this.pauseOnTap,
    this.dataManager,
  }) : super(key: key);
  final bool? pauseOnTap;
  final AnimationPlayerDataManager? dataManager;

  @override
  Widget build(BuildContext context) {
    PrettyVideoManager flickVideoManager = Provider.of<PrettyVideoManager>(context);

    return Container(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          Animation<Offset> animationOffset;
          Animation<Offset> inAnimation =
              Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation);
          Animation<Offset> outAnimation =
              Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation);

          animationOffset =
              child.key == ObjectKey(flickVideoManager.videoPlayerController) ? inAnimation : outAnimation;

          return SlideTransition(
            position: animationOffset,
            child: child,
          );
        },
        child: Container(
          key: ObjectKey(
            flickVideoManager.videoPlayerController,
          ),
          margin: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: PrettyVideoWithControls(
              willVideoPlayerControllerChange: false,
              playerLoadingFallback: Positioned.fill(
                child: Image.asset(
                  dataManager!.getCurrentPoster(),
                  fit: BoxFit.cover,
                ),
              ),
              controls: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: IconTheme(
                  data: IconThemeData(color: Colors.white, size: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: pauseOnTap!
                            ? PrettyTogglePlayAction(
                                child: PrettySeekVideoAction(
                                  child: Center(child: PrettyVideoBuffer()),
                                ),
                              )
                            : PrettyToggleSoundAction(
                                child: PrettySeekVideoAction(
                                  child: Center(child: PrettyVideoBuffer()),
                                ),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          PrettyAutoHideChild(
                            autoHide: false,
                            showIfVideoNotInitialized: false,
                            child: PrettySoundToggle(),
                          ),
                          PrettyAutoHideChild(
                            autoHide: false,
                            showIfVideoNotInitialized: false,
                            child: PrettyFullScreenToggle(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
