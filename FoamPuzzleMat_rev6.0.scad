$fn=1000;


/*********************************************************************************
                                Parameters
*********************************************************************************/
trapezoidHeight                 =     20.0;  //mm
trapezoidTopEdge              =     25.0;  //mm
trapezoidBottomEdge          =     35.0;  //mm
distanceFirstTrapezoid          =     20.0;  //mm
distanceFirstTrapazoidLongerPartFomEdge = 15; //mm
distanceFirstTrapazoidShorterPartFomEdge = 20; //mm
matThickness                    =      9.0;  //mm
matInnerRectangleLengthA    =   275.0;  //mm
matInnerRectangleLengthB    =   275.0;  //mm
        positionX = 0.0;
        positionY = 0.0;
        
        
numberOfMaleConnectors =  5;
    


//*******************************************************************************



/******************************************************************************
                                    MAIN
*******************************************************************************/

linear_extrude(height = 10, center = true, convexity = 0, twist = 0)

 //minkowski(){
 union(){   
        translate([0,0,0]) innerMatRectangle(matInnerRectangleLengthA,matInnerRectangleLengthB,true);
        trapezoidFringe();
        //trapezoid_rows();
        //        translate([-trapezoid_height-distance_first_trapezoid,distance_first_trapezoid+trapezoid_height,0]) rotate([0,180,270]) //trapezoid_rows();
    translate([-1.3,-1,0]) roundCorner();

}

//}









module roundCorner(){

 difference(){
     translate([distanceFirstTrapazoidLongerPartFomEdge+3,-3]) square(size=[trapezoidBottomEdge/8,trapezoidHeight/4],center=false);
 union(){
    //union(){
        translate([0,0,0]) innerMatRectangle(matInnerRectangleLengthA,matInnerRectangleLengthB,false);
        trapezoidFringe(false);
        //trapezoid_rows();
        //        translate([-trapezoid_height-distance_first_trapezoid,distance_first_trapezoid+trapezoid_height,0]) rotate([0,180,270]) //trapezoid_rows();
//}




intersection(){
translate([2.2,1.55,0]) roundPoly();
translate([3,-trapezoidHeight-1.6]) square(size=[trapezoidBottomEdge/2,trapezoidHeight+2],center=false);
}


}
}
}











/************************************************************************************************
            Creates the geometry of the inner foam volume
************************************************************************************************/




module innerMatRectangle(x,y,minkowskiParameter=true){
          //linear_extrude(height = 10, center = true, convexity = 0, twist = 0)
    if(minkowskiParameter){
    minkowski(){ 
    square([x,y]);
        circle(1);
    }
}
else{
        square([x,y]);
}

}




//roundPoly();

module roundPoly(minkowskiParameter=true){
    //linear_extrude(height = 10, center = true, convexity = 0, twist = 0)
    translate([-trapezoidBottomEdge/2-1,-2.5,0])
    mirror([0,1,0])
    
    
    
    
    if(minkowskiParameter){
    minkowski(){
        polygon(points=[[(trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,   trapezoidHeight],
                            [0,0],
                            [trapezoidBottomEdge  ,   0],
                            [trapezoidBottomEdge - (trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,  trapezoidHeight]]); 
        circle(1);
    }
}

else{
    polygon(points=[[(trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,   trapezoidHeight],
                            [0,0],
                            [trapezoidBottomEdge  ,   0],
                            [trapezoidBottomEdge - (trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,  trapezoidHeight]]); 
    
    }
}





/************************************************************************************************
            Creates the geometry of the male and female connectors
************************************************************************************************/


module trapazoid(minkowskiParameter=true){
     
     //linear_extrude(height = 10, center = true, convexity = 0, twist = 0)
  
    //linear_extrude(height = 10, center = true, convexity = 0, twist = 0)
     
    
    
    if(minkowskiParameter){

        
    minkowski(){   
    polygon(points=[[(trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,   trapezoidHeight],
                            [0,0],
                            [trapezoidBottomEdge  ,   0],
                            [trapezoidBottomEdge - (trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,  trapezoidHeight]]);         
        
        
        
 circle(1);

}
}
else{

    
    
        polygon(points=[[(trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,   trapezoidHeight],
                            [0,0],
                            [trapezoidBottomEdge  ,   0],
                            [trapezoidBottomEdge - (trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,  trapezoidHeight]]);     
}
}


/************************************************************************************************
            Creates the geometry of special male connectors
************************************************************************************************/
  
    
 module cornerPolygon(minkowskiParameter){  
     
    if(minkowskiParameter){
        minkowski(){
         polygon(points=[[(trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,   trapezoidHeight],
                            [0,0],
                            [21 ,   0],
                            [21+10 ,10],
                            [21,trapezoidHeight]
                            ]);
        
        circle(1);
        } 
        } 
    else{    
        
    //linear_extrude(height = 10, center = true, convexity = 0, twist = 0)
     polygon(points=[[(trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,   trapezoidHeight],
                            [0,0],
                            [21 ,   0],
                            [21+10 ,10],
                            [21,trapezoidHeight]
                            ]);
    }   
}



/************************************************************************************************
            Creates a series of male and female trapeziods
************************************************************************************************/

module trapezoidRows(minkowskiParameter=true) {
    color([0.15,0.15,0.15]);
    for (i=[0:numberOfMaleConnectors-1]){
        
    if(i<numberOfMaleConnectors-1){ 
    translate([i*(trapezoidBottomEdge+trapezoidTopEdge),0,0])
        //minkowski(){ 
        trapazoid(minkowskiParameter);
        }
        //circle(1);
    //}
     
       else {
           //TESTSetting
           minkowskiParameter=true;
           #translate([i*(trapezoidBottomEdge+trapezoidTopEdge),0,0]) cornerPolygon(minkowskiParameter);   
          }
   }
}
 

/************************************************************************************************
            Creates the outer frindge with male and female trapezoidial interfaces
************************************************************************************************/

module trapezoidFringe(minkowskiParameter=true){
    
      translate([distanceFirstTrapazoidLongerPartFomEdge,0-trapezoidHeight,0.0]) trapezoidRows(minkowskiParameter); 
      translate([distanceFirstTrapazoidLongerPartFomEdge+matInnerRectangleLengthA,distanceFirstTrapazoidLongerPartFomEdge,0.0])  rotate([0,0,90])trapezoidRows(minkowskiParameter); 
      translate([matInnerRectangleLengthA-distanceFirstTrapazoidLongerPartFomEdge,matInnerRectangleLengthA+trapezoidHeight,0.0])  rotate([0,0,180])trapezoidRows(minkowskiParameter); 
      translate([0-trapezoidHeight,matInnerRectangleLengthA-distanceFirstTrapazoidLongerPartFomEdge,0]) rotate([0,0,270])trapezoidRows(minkowskiParameter); 
    }
  
//    
//    
//  
//
//
// difference() {
// minkowski(){
//    union(){
//        translate([0,0,0]) innerMatRectangle(matInnerRectangleLengthA,matInnerRectangleLengthB);
//        trapezoidFringe();
//        //trapezoid_rows();
//        //        translate([-trapezoid_height-distance_first_trapezoid,distance_first_trapezoid+trapezoid_height,0]) rotate([0,180,270]) //trapezoid_rows();
//}
//    circle(1);
//}
//
//!translate([-trapezoidBottomEdge+6,-trapezoidHeight,0]) mirror([0,1,0]) intersection() {
// minkowski(){
//    union(){
//        translate([0,0,0]) innerMatRectangle(matInnerRectangleLengthA,matInnerRectangleLengthB);
//        trapezoidFringe();
//        //trapezoid_rows();
//        //        translate([-trapezoid_height-distance_first_trapezoid,distance_first_trapezoid+trapezoid_height,0]) rotate([0,180,270]) //trapezoid_rows();
//}
//    circle(1);
//}
//
//translate([0,-trapezoidHeight+1,0]) square([matInnerRectangleLengthA ,trapezoidHeight], center=false);
//
// }
//
//}









































/*****************************************************************************************************
                                                ...Possibilities...  
******************************************************************************************************/




//********************
//*** Variant II:
//********************
////polygon(points = [ [x, y], ... ], paths = [ [p1, p2, p3..], ...], convexity = N);
//difference(){
//polygon(points=[[(trapezoid_bottom_edge - trapezoid_top_edge)/2.0 ,   trapezoid_height],
//                [0,0],
//                [trapezoid_bottom_edge  ,   0],
//                [trapezoid_bottom_edge - (trapezoid_bottom_edge - trapezoid_top_edge)/2.0 ,   trapezoid_height]]);
//
//difference(){
// translate([0,0]) square([1.15,0.8]);                 
// intersection(){               
//   resize([2,1.5]) translate([1.24,1,0]) circle(1);                        
// }     
// }
//translate([0,-1+0.01]) square([2,1]);   
// }
// 


//polygon(points = [ [x, y], ... ], paths = [ [p1, p2, p3..], ...], convexity = N);



//********************
//*** Variant III:
//********************


//translate([-38,0,0])
//hull()
//{
//#translate([0,0,0])
//resize([1.15,0.8,0]) cylinder(r=2,h=2);
//#translate([(trapezoid_bottom_edge - trapezoid_top_edge)/2.0 ,   trapezoid_height])
//resize([1.15,0.8,0]) cylinder(r=2,h=2);
//#translate([trapezoid_bottom_edge  ,   0])
//resize([1.15,0.8,0]) cylinder(r=2,h=2);
//#translate([trapezoid_bottom_edge - (trapezoid_bottom_edge - trapezoid_top_edge)/2.0 ,   trapezoid_height])
//resize([1.15,0.8,0]) cylinder(r=2,h=2);}

