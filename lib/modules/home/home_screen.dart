import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:figma_task/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../cubit/states.dart';
import '../../shared/colors.dart';

class HomeScreen extends StatefulWidget
{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  var carouselController = CarouselController();
  var pageController = PageController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/img.png'),
                      Text('Hey, Ahmed'),
                      Image.asset('assets/images/img_1.png'),
                    ],
                  ),
                  SizedBox(height: 2.h,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Multi-Services for Your Real Estate Needs',
                      style: TextStyle(fontSize: 14.sp),
                      ),
                      SizedBox(height: 1.h,),
                      Text(
                      'Explore diverse real estate services for all your needs:',
                        style: TextStyle(color: darkGrey, fontSize: 10.sp),
                        ),
                      Text(
                          ' property management, construction, insurance and',
                        style: TextStyle(color: darkGrey, fontSize: 10.sp),
                        ),
                      Text(
                          ' more in one place.',
                        style: TextStyle(color: darkGrey, fontSize: 10.sp),
                        ),
                    ],
                  ),
                  SizedBox(height: 1.h,),
                  SizedBox(
                    height: 20.h,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        viewportFraction: 20,
                        aspectRatio: 7/3,
                        onPageChanged: (index, reason) {
                          setState(() {
                            carouselIndex = index;
                          });
                        },
                      ),
                      carouselController: carouselController,
                      items: [
                        carouselBuilder(),
                        carouselBuilder(),
                        carouselBuilder(),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  AnimatedSmoothIndicator(
                    activeIndex: carouselIndex,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      activeDotColor: red,
                      dotColor: grey,
                      expansionFactor: 5,
                      dotWidth: 9,
                      dotHeight: 9,
                      spacing: 4,
                    ),
                    onDotClicked:  (index) {
                      setState(() {
                        carouselController.animateToPage(index);
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: white,
              child: Column(
                children: [
                  // Tab bar view for users, services, and orders
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 300.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: white,
                        shape: BoxShape.rectangle,
                        border: Border.all(width: 1,color: grey,),
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ButtonBar(
                                  children: [
                                    textButton(0, 'Users'),
                                    textButton(1, 'Services'),
                                    textButton(2, 'Orders(0)'),
                                  ]
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Rest of Screen content according to tab bar view
                  SizedBox(
                    height: 50.h,
                    child: currentIndex == 0 ?
                        // Users content
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Users View',
                                  style: TextStyle(fontSize: 11.sp),
                                ),
                                Text(
                                  'see all',
                                  style: TextStyle(color: Colors.grey,
                                      decoration: TextDecoration.underline,
                                    decorationColor: Colors.grey
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h,),
                            SizedBox(
                              height: 30.h,
                              child: BlocConsumer<AppCubit, AppStates>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    var cubit = AppCubit.get(context);
                                    return cubit.users.isEmpty? Center(child: CircularProgressIndicator()):
                                    ListView.builder(
                                        itemCount: cubit.users.length,
                                        itemBuilder: (context, index) =>
                                            listViewBuilder(cubit.users[index]));
                                  }
                              ),
                            ),
                          ],
                        ),
                      )
                    :
                        // Another content (services or orders)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset('assets/images/img_3.png',scale: 2.4,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  'No orders found',
                                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50.0),
                              child: Text(
                                  'you can place your needed orders'
                                      ' to let serve you.',
                                style: TextStyle(fontSize:14.sp,color: darkGrey),
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
int currentIndex = 0;
  Widget textButton(int index, String title)
  {
    return TextButton(
      onPressed: (){
        setState(() {
          currentIndex = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 14.sp,),
      ),
      style: ButtonStyle(
        backgroundColor:
        MaterialStatePropertyAll(
            currentIndex ==index?
            red:grey
        ),
        foregroundColor:
        MaterialStatePropertyAll(Colors.black),
      ),
    );
  }
  
int carouselIndex = 0;
  Widget carouselBuilder(){
    return SizedBox(
      width: 300,
        child: Image.asset('assets/images/img_2.png', fit: BoxFit.fill));
  }

  Widget listViewBuilder(var user)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: lightGrey,
                offset: Offset.fromDirection(1,2),
                blurStyle: BlurStyle.solid
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${user['id']}'),
            ),
            Text(user['name']),
            Spacer(),
            Icon(Icons.arrow_forward, color: Colors.grey,),
          ],
        ),

      ),
    );
  }
}