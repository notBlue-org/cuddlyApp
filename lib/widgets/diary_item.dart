import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/models/Prod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class diaryItem extends StatelessWidget {
  final Prod prod;
  diaryItem(this.prod);

  @override
  Widget build(BuildContext context) {
    return Container(
        height:110,
        decoration: BoxDecoration(
          color:Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(20),


        ),

        child: Row(
          children: [
            Container(
                padding: EdgeInsets.all(5),
                width: 110,
                height: 110,
                child:Image.asset(prod.imgUrl, fit:BoxFit.fitHeight)
            ),
            Expanded(
                child:Container(
                  padding: EdgeInsets.only(top:20,left:10,right:10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:[
                            Text(prod.name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height:1.5,
                              ),),
                            Icon(Icons.arrow_forward_ios_outlined,
                                size:15
                            ),
                          ],
                        ),

                        Text(prod.desc,
                            style:TextStyle(
                                color:kPrimaryColor,
                                height: 1.5
                            )),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text('\$',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text('${prod.price}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                              SizedBox(height:30),
                              Align(
                               alignment: Alignment(0.1,0),
                               child: Container(
                                 height: 25,
                                 width: 100,
                                 decoration: BoxDecoration(
                                   color: kPrimaryColor,
                                   borderRadius: BorderRadius.circular(10),
                                 ),
                                 child:Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     Text('-',
                                     style: TextStyle(
                                       fontSize: 20,
                                       fontWeight: FontWeight.bold,
                                     ),),
                                     Container(
                                       padding: EdgeInsets.all(12),
                                       decoration: BoxDecoration(
                                         shape: BoxShape.circle,
                                         color: Colors.pinkAccent,
                                       ),
                                       child: Text(prod.quantity.toString(),
                                       style: TextStyle(
                                         color: Colors.white,
                                         fontWeight: FontWeight.bold,

                                       ),),
                                     ),
                                     Text('+',
                                       style: TextStyle(
                                         fontSize: 20,
                                         fontWeight: FontWeight.bold,
                                       ),)
                                   ],
                                 ) ,
                               ),
                              )
                          ],
                        )
                      ]
                  ),
                )
            )
          ],
        )
    );
  }
}
