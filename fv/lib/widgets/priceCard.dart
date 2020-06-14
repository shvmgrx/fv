  import 'package:flutter/material.dart';

priceCard(String imgPath, String coffeeName, String price, ) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: 75.0
              ),
              Positioned(
                top: 75.0,
                child: Container(
                  padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(0xFFDAB68C)
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
              
    
                       
                        Text(
                          coffeeName,
                          style: TextStyle(
                              fontFamily: 'varela',
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
   
                    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              price,
                              style: TextStyle(
                                  fontFamily: 'varela',
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3A4742)),
                            ),
                    
                          ],
                        )
                      ]
                  )
                )
              ),
              Positioned(
                left: 10.0,
                top: 10.0,
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgPath),
                      fit: BoxFit.contain
                    )
                  )
                )
              )
            ]
          ),
        
    
        ],
      )
    );
  }