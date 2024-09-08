import 'package:cooking_friend/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class GradientBackground extends StatefulWidget {
  final Widget scaffold;
  const GradientBackground(this.scaffold, {super.key});

  @override
  State<GradientBackground> createState() => _GradientBackgroundState();
}

class _GradientBackgroundState extends State<GradientBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.decal,
          colors: [CustomTheme.backgroundColor, CustomTheme.navbar],
        ),
      ),
      child: widget.scaffold,
    );
  }
}
