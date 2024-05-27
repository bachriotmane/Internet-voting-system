// ignore_for_file: must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:voting_system_app/common/utils/dummydata/dummy.data.dart';
import 'package:voting_system_app/common/utils/dummydata/room.categories.dart';
import 'package:voting_system_app/modules/elections/domain/entities/room.dart';
import 'package:voting_system_app/modules/elections/presntation/blocs/home_bloc/home_bloc.dart';

import 'package:voting_system_app/modules/elections/presntation/pages/notifications.page.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/rooms.page.dart';
import 'package:voting_system_app/modules/elections/presntation/pages/verfication.page.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/custom.category.widget.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/custom.divison.text.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/custom.searchbar.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/room.card.aramali.dart';
import 'package:voting_system_app/modules/elections/presntation/widgets/room.card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeBloc homeBloc = HomeBloc();
  final _getStorage = GetStorage();

  initialState() {
    homeBloc.add(HomeInitialEvent());
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    initialState();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildSearchBar(context),
            const SizedBox(height: 10),
            BlocConsumer<HomeBloc, HomeState>(
              bloc: homeBloc,
              listenWhen: (prev, current) => current is HomeActionState,
              buildWhen: (prev, current) => current is! HomeActionState,
              listener: (context, state) {
                if (state is HomeNavigateToCategoryRoomsPageActionsState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => RoomsPage(rooms: state.rooms)));
                }
                if (state is HomeRoomSavedSuccesfullyActionState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Room saved !"),
                    backgroundColor: Colors.green,
                  ));
                }
              },
              builder: (context, state) {
                if (state is HomeLoadedSuccessState) {
                  return Column(
                    children: [
                      _buildPhotoBannerBlurtedImage(context),
                      CustomDivisionText(
                          divisionName: "Rooms categories", onTap: () {}),
                      _buildCategoriesCards(context),
                      CustomDivisionText(
                          divisionName: "Popular rooms", onTap: () {}),
                      _buildServicesCarousel(context, state.rooms),
                      //! Top Rated
                      CustomDivisionText(
                          divisionName: "Top rated rooms", onTap: () {}),
                      _buildServicesCarousel(context, state.rooms),
                    ],
                  );
                } else if (state is HomeSearchingState) {
                  return Center(
                    child: Column(
                      children: List.generate(
                        state.rooms.length,
                        (index) => RoomCardBar(
                          room: state.rooms[index],
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => VerificationMemeberPage(
                                        room: state.rooms[index])));
                          },
                        ),
                      ),
                    ),
                  );
                } else if (state is HomeLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is HomeErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                } else {
                  return Text("Unknown State");
                }
              },
            ),
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
          Expanded(
            flex: 5,
            child: MyCustomSearchBar(
              controller: searchController,
              onTapOutside: (event) {
                homeBloc.add(HomeInitialEvent());
                FocusScope.of(context).unfocus();
              },
              onEditingComplete: () {
                homeBloc.add(HomeInitialEvent());
                FocusScope.of(context).unfocus();
              },
              onIsTyping: (value) {
                homeBloc.add(HomeTypingEvent(keyword: value));
              },
            ),
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
      child: Wrap(
        direction: Axis.horizontal,
        children: List.generate(
          categoryList.length,
          (index) => CustomCategoryWidget(
            categoryName: categoryList[index]['categoryName'],
            categoryIcon: categoryList[index]['categoryIcon'],
            onTap: () {
              homeBloc.add(HomeCategoryClickedEvent(
                  category: categoryList[index]['categoryName']));
            },
          ),
        ),
      ),
    );
  }

  _buildServicesCarousel(context, List<Room> rooms) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      child: CarouselSlider(
        items: List.generate(rooms.length, (index) {
          bool isSaved = false;
          for (Room r in TestData.savedRooms) {
            if (r.roomId == rooms[index].roomId) {
              isSaved = true;
            }
          }
          return RoomCard(
            isSaved: isSaved,
            room: rooms[index],
            onClick: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => VerificationMemeberPage(
                            room: rooms[index],
                          )));
            },
            saveRoom: () {
              homeBloc
                  .add(HomeSaveButtonClickedEvent(clickedRoom: rooms[index]));
            },
          );
        }),
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
