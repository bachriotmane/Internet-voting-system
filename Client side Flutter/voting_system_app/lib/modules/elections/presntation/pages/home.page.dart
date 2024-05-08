// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_system_app/common/services/election.dart';
import 'package:voting_system_app/common/services/auth.service.dart';
import 'package:voting_system_app/modules/authentication/data/datasource/user.datasource.dart';
import 'package:voting_system_app/modules/elections/data/datasource/vote.datasource.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/notifications.page.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/custom.category.widget.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/custom.divison.text.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/custom.searchbar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _getStorage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          serviceLocator<UserDataSource>();
          final voteDataSource = serviceLocatorElection<VoteDataSource>();
          await voteDataSource.getAllVotes();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchBar(),
            const SizedBox(height: 10),
            _buildPhotoBannerBlurtedImage(context),
            CustomDivisionText(divisionName: "Rooms categories", onTap: () {}),
            _buildCategoriesCards(context),
            CustomDivisionText(divisionName: "Popular rooms", onTap: () {}),
            _buildServicesCarousel(),
            //! Top Rated
            CustomDivisionText(divisionName: "Top rated rooms", onTap: () {}),
            _buildServicesCarousel(),
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

  _buildSearchBar() {
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
              onTap: () {},
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
    // return Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Positioned(
    //       top: 16,
    //       left: MediaQuery.of(context).size.width * .67,
    //       child: const Image(
    //         height: 120,
    //         image: AssetImage(
    //           "assets/homepage/vv.png",
    //         ),
    //       ),
    //     ),
    //     const Positioned(
    //       top: 40,
    //       left: 15,
    //       child: Column(
    //         children: [
    //           Text(
    //             "🎉 Exciting Offer Alert! 🎉",
    //             style: TextStyle(
    //               color: Color(0xFFffeb3b),
    //               fontSize: 20,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           Text(
    //             "Only 40% Slots Left",
    //             style: TextStyle(
    //               color: Color(0xFFFFFFFF),
    //               fontSize: 17,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           Text(
    //             "Act Quickly!",
    //             style: TextStyle(
    //               color: Colors.amberAccent,
    //               fontSize: 20,
    //               fontWeight: FontWeight.w800,
    //             ),
    //           ),
    //         ],
    //       ),
    //     )
    //   ],
    // );
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

  _buildServicesCarousel() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: CarouselSlider(
        items: List.generate(
          5,
          (index) => Text("Room Card $index"),
        ),
        options: CarouselOptions(height: 210, autoPlay: true),
      ),
    );
  }
}
