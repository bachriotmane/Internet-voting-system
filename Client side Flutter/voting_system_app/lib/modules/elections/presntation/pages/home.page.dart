// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';

import 'package:voting_system_app/modules/elections/presntation/pages/notifications.page.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/room.page.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/custom.category.widget.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/custom.divison.text.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/custom.searchbar.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/room.card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchBar(context),
            const SizedBox(height: 10),
            _buildPhotoBannerBlurtedImage(context),
            CustomDivisionText(divisionName: "Rooms categories", onTap: () {}),
            _buildCategoriesCards(context),
            CustomDivisionText(divisionName: "Popular rooms", onTap: () {}),
            _buildServicesCarousel(context),
            //! Top Rated
            CustomDivisionText(divisionName: "Top rated rooms", onTap: () {}),
            _buildServicesCarousel(context),
          ],
        ),
      ),
    );
  }

  _buildHeader(context) {
    TextStyle txtStyle =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!Image + User Name
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/homepage/profile.png"),
                    radius: 23,
                  ),
                  const SizedBox(width: 6),
                  Text("Hey, ", style: txtStyle),
                  Text("${_getStorage.read("loged-user")} 👋",
                      style: txtStyle.copyWith(
                          color: Colors.grey[800], fontSize: 21))
                ],
              ),
              Text("Looking some rooms?",
                  style: txtStyle.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 21))
            ],
          ),
          Stack(
            children: [
              Transform.rotate(
                angle: 0.11,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const NotificationPage()));
                  },
                  icon: Icon(
                    FontAwesomeIcons.bell,
                    color: Theme.of(context).primaryColor.withGreen(50),
                    size: 30,
                  ),
                ),
              ),
              const Positioned(
                  right: 10,
                  top: 9,
                  child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 6,
                  ))
            ],
          )
          //Notifications
        ],
      ),
    );
  }

  _buildSearchBar(context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Expanded(
            flex: 5,
            child: MyCustomSearchBar(),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                _showAlertDialog(context);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 7),
                height: 56,
                decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    border: Border.all(color: Colors.grey[400]!, width: 2),
                    borderRadius: BorderRadius.circular(18)),
                child: Icon(FontAwesomeIcons.sliders,
                    color: Colors.grey[500], size: 26),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildPhotoBannerBlurtedImage(context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          blurRadius: 10,
          spreadRadius: 0,
          color: Colors.grey,
        )
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          "assets/homepage/vote_banner.png",
          width: MediaQuery.of(context).size.width * .9,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildCategoriesCards(context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .254,
        child: const Wrap(direction: Axis.horizontal, children: [
          CustomCategoryWidget(
              categoryName: "Politics and Governance",
              categoryIcon: FontAwesomeIcons.landmark),
          CustomCategoryWidget(
              categoryName: "Social Issues and Advocacy",
              categoryIcon: FontAwesomeIcons.peopleGroup),
          CustomCategoryWidget(
              categoryName: "Health and Wellness",
              categoryIcon: FontAwesomeIcons.userDoctor),
          CustomCategoryWidget(
              categoryName: "Technology and Innovation",
              categoryIcon: FontAwesomeIcons.microchip),
          CustomCategoryWidget(
              categoryName: "Arts and Culture",
              categoryIcon: FontAwesomeIcons.masksTheater),
          CustomCategoryWidget(
              categoryName: "Education and Learning",
              categoryIcon: FontAwesomeIcons.bookOpenReader),
          CustomCategoryWidget(
              categoryName: "Environmental Conservation",
              categoryIcon: FontAwesomeIcons.seedling),
          CustomCategoryWidget(
              categoryName: "Public Safety and Security",
              categoryIcon: FontAwesomeIcons.shieldHalved),
        ]));
  }

  _buildServicesCarousel(context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: CarouselSlider(
        items: List.generate(
          1,
          (index) => RoomCard(
            onClick: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => RoomPage()));
            },
            saveRoom: () {},
          ),
        ),
        options: CarouselOptions(height: 210, autoPlay: true),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: const SizedBox(
            height: 100,
            child: Column(
              children: [
                Text("Filter options"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
