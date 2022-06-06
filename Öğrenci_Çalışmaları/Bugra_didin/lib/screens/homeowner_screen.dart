import 'package:deneme_flutter/screens/aboutus_screen.dart';
import 'package:deneme_flutter/screens/create_service_screen.dart';
import 'package:deneme_flutter/screens/owner_service_screen.dart';
import 'package:deneme_flutter/screens/show_users_screen.dart';
import 'package:deneme_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeOwner extends StatefulWidget {
  const HomeOwner({Key? key}) : super(key: key);

  @override
  _HomeOwnerState createState() => _HomeOwnerState();
}

class _HomeOwnerState extends State<HomeOwner> {
  void navigateToCreateService() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CreateService(),
    ));
  }

  void navigateToServices() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const OwnerService(),
    ));
  }

  void navigateToUsers() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ShowUsers(),
    ));
  }

  void navigateToAboutUs() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const AboutUs(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: size.height * .45,
          decoration: BoxDecoration(
            color: mobileBackgroundColor,
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1551522435-a13afa10f103?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 27,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 180,
                ),
                Text(
                  'Brothers Car Service',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      CategoryCard(
                        title: 'Create Service',
                        svgSrc: 'assets/createservice.svg',
                        press: () => navigateToCreateService,
                      ),
                      CategoryCard(
                        title: 'Services',
                        svgSrc: 'assets/services.svg',
                        press: () => navigateToServices,
                      ),
                      CategoryCard(
                        title: 'Users',
                        svgSrc: 'assets/users.svg',
                        press: () => navigateToUsers,
                      ),
                      CategoryCard(
                        title: 'About Us',
                        svgSrc: 'assets/aboutus.svg',
                        press: () => navigateToAboutUs,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String svgSrc;
  final String title;
  final Function press;
  const CategoryCard({
    Key? key,
    required this.svgSrc,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: press(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  SvgPicture.asset(
                    svgSrc,
                    height: 70,
                  ),
                  Spacer(),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
