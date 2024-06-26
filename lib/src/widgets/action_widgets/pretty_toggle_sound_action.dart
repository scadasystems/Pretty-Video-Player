import 'package:flutter/material.dart';
import 'package:pretty_video_player/pretty_video_player.dart';
import 'package:provider/provider.dart';

/// GestureDetector that calls [prettyControlManager.toggleMute] onTap of opaque area/child.
class PrettyToggleSoundAction extends StatelessWidget {
  const PrettyToggleSoundAction({Key? key, this.child, this.behavior = HitTestBehavior.opaque, this.toggleMute})
      : super(key: key);
  final Widget? child;
  final HitTestBehavior behavior;

  /// Function called onTap of the opaque area/child.
  ///
  /// Default action -
  /// ``` dart
  ///    controlManager.toggleMute();
  /// ```
  final Function? toggleMute;

  @override
  Widget build(BuildContext context) {
    PrettyControlManager controlManager = Provider.of<PrettyControlManager>(context);
    return Container(
      child: GestureDetector(
        key: key,
        child: child,
        behavior: behavior,
        onTap: () {
          if (toggleMute != null) {
            toggleMute!();
          } else {
            controlManager.toggleMute();
          }
        },
      ),
    );
  }
}
