import 'package:flutter/material.dart';
import 'package:pats4u/models/lunch_menu_item.dart';
import 'package:pats4u/providers/menu_image_cache_manager.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/widgets/image_container.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';

class MenuDetailView extends StatefulWidget {
  final LunchMenuItem item;
  final bool lunch;

  const MenuDetailView({
    required this.item,
    required this.lunch,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MenuDetailViewState();
  }
}

class _MenuDetailViewState extends State<MenuDetailView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: MinimalAppBar(
        title: '',
        height: 65,
        leftIcon: Icons.chevron_left,
        leftAction: () {
          Navigator.of(context).pop();
        },
        leftIconColor: widget.item.image != ''
            ? null
            : Theme.of(context).colorScheme.secondary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    // Display the lunch/breakfast details
    List<Widget> items = [];
    items.add(
      Row(
        children: [
          Icon(
            widget.lunch ? Icons.dinner_dining : Icons.breakfast_dining,
            size: 40,
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Text(
              widget.item.main,
              maxLines: 3,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 2.2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
    items.add(
      const SizedBox(
        height: 10,
      ),
    );
    items.add(
      Row(
        children: [
          const SizedBox(
            width: 70,
          ),
          Expanded(
            child: Text(
              widget.item.day.toUpperCase(),
              maxLines: 3,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 1.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
    if (widget.item.desert != '') {
      items.add(
        const SizedBox(
          height: 15,
        ),
      );
      items.add(
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: const Icon(Icons.cake),
                title: Text(widget.item.desert),
                subtitle: const Text('Desert'),
              ),
            ),
          ],
        ),
      );
    }
    if (widget.item.sides.isNotEmpty) {
      items.add(
        const SizedBox(
          height: 25,
        ),
      );
      items.add(
        Row(
          children: [
            Text(
              'Sides',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.5,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      );
      items.addAll(
        List.generate(
          widget.item.sides.length,
          (index) => Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.vertical_split),
                  title: Text(widget.item.sides[index]),
                ),
              ),
            ],
          ),
        ),
      );
    }
    if (widget.item.extras.isNotEmpty) {
      items.add(
        const SizedBox(
          height: 25,
        ),
      );
      items.add(
        Row(
          children: [
            Text(
              'Extras',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2.5,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      );
      items.addAll(
        List.generate(
          widget.item.extras.length,
          (index) => Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.add_circle_outline),
                  title: Text(widget.item.extras[index]),
                ),
              ),
            ],
          ),
        ),
      );
    }
    // Create a Stack of widgets to allow for placing hierarchy
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        buildImage(widget.item, SizeConfig.screenWidth),
        Padding(
          padding: const EdgeInsets.only(
            top: 270,
          ),
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                right: 25,
                left: 25,
              ),
              child: Column(
                children: items,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImage(LunchMenuItem item, double width) {
    // Build an image container with image or shortened text of day name
    if (item.image != '') {
      return ImageContainer(
        image: item.image,
        imageCacheProvider: MenuImageCacheManager().getSingleFile(item.image),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
          bottom: Radius.zero,
        ),
        isShadow: false,
        width: width,
        height: 300,
      );
    } else {
      return Container(
        width: width,
        height: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(40),
            bottom: Radius.zero,
          ),
        ),
        child: Center(
          child: Text(
            item.day.toUpperCase().substring(0, 3),
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 5,
              color:
                  Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }
}
