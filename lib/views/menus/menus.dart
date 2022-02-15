import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pats4u/models/lunch_menu_item.dart';
import 'package:pats4u/models/week_menu.dart';
import 'package:pats4u/providers/backend.dart';
import 'package:pats4u/providers/menu_helpers.dart';
import 'package:pats4u/providers/size_config.dart';
import 'package:pats4u/views/menus/menu_detail_view.dart';
import 'package:pats4u/widgets/image_container.dart';
import 'package:pats4u/widgets/minimal_app_bar.dart';

class Menus extends StatefulWidget {
  const Menus({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MenusState();
  }
}

class _MenusState extends State<Menus> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MinimalAppBar(
        height: 65,
        title: 'Menus',
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(
        future: Backend.getWeekMenu(MenuHelpers.weekNumber(DateTime.now())),
        builder: (BuildContext context, AsyncSnapshot<WeekMenu> snapshot) {
          if (snapshot.data != null) {
            return buildBody(snapshot.data!);
          } else {
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget buildBody(WeekMenu menuItems) {
    List<Widget> items = [];
    if (menuItems.breakfast.isNotEmpty) {
      items.add(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Text(
                'Breakfast',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                ),
              ),
            ),
          ],
        ),
      );
      items.add(
        const SizedBox(
          height: 15,
        ),
      );
      items.add(
        CarouselSlider(
          options: CarouselOptions(
            height: 300,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: .8,
            enableInfiniteScroll: false,
          ),
          items: List.generate(
            menuItems.breakfast.length,
            (index) => buildMenuItem(menuItems.breakfast[index], false),
          ),
        ),
      );
    }
    if (menuItems.breakfast.isNotEmpty && menuItems.lunch.isNotEmpty) {
      items.add(
        const SizedBox(
          height: 25,
        ),
      );
    }
    if (menuItems.lunch.isNotEmpty) {
      items.add(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Text(
                'Lunch',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                ),
              ),
            ),
          ],
        ),
      );
      items.add(
        const SizedBox(
          height: 15,
        ),
      );
      items.add(
        CarouselSlider(
          options: CarouselOptions(
            height: 300,
            enlargeCenterPage: true,
            disableCenter: true,
            viewportFraction: .8,
            enableInfiniteScroll: false,
          ),
          items: List.generate(
            menuItems.lunch.length,
            (index) => buildMenuItem(menuItems.lunch[index], true),
          ),
        ),
      );
      items.add(
        const SizedBox(
          height: 100,
        ),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: items,
      ),
    );
  }

  Widget buildMenuItem(LunchMenuItem item, bool lunch) {
    DateFormat dateFormat = DateFormat('MM/dd/yyyy');
    double width = MediaQuery.of(context).size.width * .8;
    return GestureDetector(
      child: Container(
        width: width,
        height: 300,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.08),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            buildImage(item, width),
            Padding(
              padding: const EdgeInsets.only(
                top: 175,
              ),
              child: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.main,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Icon(
                                lunch
                                    ? Icons.dinner_dining
                                    : Icons.breakfast_dining,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                lunch ? 'Lunch' : 'Breakfast',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          if (lunch && item.desert != '')
                            Row(
                              children: [
                                const Icon(
                                  Icons.cake,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'Desert',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                dateFormat.format(item.date),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuDetailView(
              item: item,
              lunch: lunch,
            ),
          ),
        );
      },
    );
  }

  Widget buildImage(LunchMenuItem item, double width) {
    if (item.image != '') {
      return ImageContainer(
        image: item.image,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
          bottom: Radius.zero,
        ),
        isShadow: false,
        width: width,
        height: 250,
      );
    } else {
      return Container(
        width: width,
        height: 250,
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
