import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'profile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:farmkal/utilities/constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
          appBar: AppBar(
            backgroundColor: Color(0xFFE7FFE5),         //Color(0xFF7AC285),
            centerTitle: true,
            title: Text('FARMKAL',
              style: TextStyle(
                color: Color(0xFF050523),
                  fontWeight: FontWeight.bold
              ),
            ),
            leading: IconButton(
              onPressed: (){},
              icon: Icon(Icons.menu,color: Color(0xFF050523),),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Profile();
                  }));
                },
                icon: Icon(FontAwesomeIcons.user,
                  color: Color(0xFF050523),
                ),)
            ],
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
              children: [
                // Search and Notification
                Row(
                  children: [
                    // Search
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width : 1.5),
                            borderRadius: BorderRadius.circular(6)
                        ),

                        margin: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'Find Tractors, Sprayers and ...',
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.white
                          ),
                        ),
                      ),
                    ),
                    // Notification
                    Container(
                      margin : EdgeInsets.fromLTRB(1,0,15,0),
                      child: Icon(FontAwesomeIcons.bell,color: Color(0xFF050523),),
                    )
                  ],
                ),

                // Categories
                Card(
                  elevation: 6,
                  child: Container(
                    width: double.infinity,
                    padding : EdgeInsets.all(15),
                    color: Color(0xFFFFFFFF),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Categories',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                        Container(
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                  margin : EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(FontAwesomeIcons.tractor, size: 40,color: Color(
                                      0xFF8AFF80),)
                              ),
                              Container(
                                  margin : EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(FontAwesomeIcons.sprayCan, size: 40, color: Color(0xFF8AFF80),)
                              ),
                              Container(
                                  margin : EdgeInsets.symmetric(horizontal: 20),
                                  child: Icon(FontAwesomeIcons.wheatAwn, size: 40, color: Color(0xFF8AFF80),)
                              ),
                              Container(
                                  margin : EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(Icons.supervised_user_circle, size: 40,color: Color(0xFF8AFF80))
                              ),
                              Container(
                                  margin : EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(Icons.supervised_user_circle, size: 40,color: Color(0xFF8AFF80))
                              ),
                              Container(
                                  margin : EdgeInsets.symmetric(horizontal: 15),
                                  child: Icon(Icons.supervised_user_circle, size: 40, color: Color(0xFF8AFF80))
                              )






                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // Banner
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      image:DecorationImage(
                          image: AssetImage('images/banner.jpg'),
                          fit:BoxFit.cover
                      )
                  ),
                ),

                // Products

                // Product Row (2)
                Row(
                  children: [
                    // Product Card
                    ProductCard(
                      image: Image(image: AssetImage('images/camera.jpg'),),
                      price: '50,000',
                      description: 'A latest Sony camera for sell, at best price',
                      location: 'Jaipur',
                    ),
                    ProductCard(
                      image: Image(image: AssetImage('images/camera.jpg'),),
                      price: '50,000',
                      description: 'A latest Sony camera for sell, at best price',
                      location: 'Jaipur',
                    ),


                  ],
                ),
                Row(
                  children: [
                    // Product Card
                    ProductCard(
                      image: Image(image: AssetImage('images/camera.jpg'),),
                      price: '50,000',
                      description: 'A latest Sony camera for sell, at best price',
                      location: 'Jaipur',
                    ),
                    ProductCard(
                      image: Image(image: AssetImage('images/camera.jpg'),),
                      price: '50,000',
                      description: 'A latest Sony camera for sell, at best price',
                      location: 'Jaipur',
                    ),


                  ],
                ),
                Row(
                  children: [
                    // Product Card
                    ProductCard(
                      image: Image(image: AssetImage('images/camera.jpg'),),
                      price: '50,000',
                      description: 'A latest Sony camera for sell, at best price',
                      location: 'Jaipur',
                    ),
                    ProductCard(
                      image: Image(image: AssetImage('images/camera.jpg'),),
                      price: '50,000',
                      description: 'A latest Sony camera for sell, at best price',
                      location: 'Jaipur',
                    ),


                  ],
                ),
                Row(
                  children: [
                    // Product Card
                    ProductCard(
                      image: Image(image: AssetImage('images/camera.jpg'),),
                      price: '50,000',
                      description: 'A latest Sony camera for sell, at best price',
                      location: 'Jaipur',
                    ),
                    ProductCard(
                      image: Image(image: AssetImage('images/camera.jpg'),),
                      price: '50,000',
                      description: 'A latest Sony camera for sell, at best price',
                      location: 'Jaipur',
                    ),


                  ],
                )

              ],
            )
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({required this.image,this.price,this.description,this.location,super.key});

  Image image;
  String? price;
  String? description;
  String? location;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
            border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(6)
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Image
            Container(
              child: Stack(
                alignment: Alignment.center,
                  children: [
                    image,
                    Positioned(
                      top:15,
                        right:15,
                        child:GestureDetector(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                            ),
                              child: Icon(FontAwesomeIcons.heart, size: 15,),
                          ),
                        )
                    )
                  ]
              ),
            ),

            //Price
            Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 7.5),
                child: Text('₹ $price', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7.5),
              child: Text(description.toString(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 7.5),
              child: Row(
                  children : [
                    Icon(Icons.location_pin, color: Color(
                        0xFF565656),),
              Text(location.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                    ]
              ),
            )
          ],
        ),
      ),
    );
  }
}

