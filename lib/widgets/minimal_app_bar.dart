import 'package:flutter/material.dart';
import 'package:pats4u/providers/size_config.dart';

class MinimalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final IconData? leftIcon;
  final VoidCallback? leftAction;
  final IconData? rightIcon;
  final VoidCallback? rightAction;

  const MinimalAppBar({
    this.height = kToolbarHeight,
    this.leftIcon,
    this.leftAction,
    this.rightIcon,
    this.rightAction,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Align(
            alignment: const Alignment(0, 1.8),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width / 5,
              child: Text(
                'Staff',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if ( leftIcon != null && leftAction != null ) Align(
            alignment: const Alignment(-0.9, 0.7),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 10,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  shape: const CircleBorder(),
                ),
                child: IconButton(
                  icon: Icon(leftIcon),
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: leftAction,
                ),
              ),
            ),
          ),
          if ( rightIcon != null && rightAction != null ) Align(
            alignment: const Alignment(0.9, 0.7),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width / 10,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  shape: const CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.chevron_left),
                  color: Theme.of(context).colorScheme.onPrimary,
                  onPressed: rightAction,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
