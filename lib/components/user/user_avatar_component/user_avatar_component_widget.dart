import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'user_avatar_component_model.dart';
export 'user_avatar_component_model.dart';

class UserAvatarComponentWidget extends StatefulWidget {
  const UserAvatarComponentWidget({
    super.key,
    required this.uid,
    this.size,
    double? radius,
  }) : radius = radius ?? 100.0;

  final String? uid;
  final double? size;
  final double radius;

  @override
  State<UserAvatarComponentWidget> createState() =>
      _UserAvatarComponentWidgetState();
}

class _UserAvatarComponentWidgetState extends State<UserAvatarComponentWidget> {
  late UserAvatarComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserAvatarComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(valueOrDefault<double>(
        widget.radius,
        0.0,
      )),
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(valueOrDefault<double>(
            widget.radius,
            0.0,
          )),
        ),
        child: SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            children: [
              Container(
                width: widget.size,
                height: widget.size,
                decoration: const BoxDecoration(),
                child: custom_widgets.UserAvatar(
                  width: 50.0,
                  height: 50.0,
                  uid: widget.uid!,
                  radius: widget.radius,
                ),
              ),
              if (false)
                ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.asset(
                    'assets/images/woman_model.jpg',
                    width: widget.size,
                    height: widget.size,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
