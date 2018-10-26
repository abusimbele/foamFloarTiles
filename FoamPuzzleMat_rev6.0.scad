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


 union(){   
    translate([0,0,0]) innerMatRectangle(matInnerRectangleLengthA,matInnerRectangleLengthB,true);
    trapezoidFringe();
     //translate([-1.3,-1,0])
}










//OLD
//module roundCorner(){
//
//     difference(){
//             translate([distanceFirstTrapazoidLongerPartFomEdge+3,-3]) square(size=[trapezoidBottomEdge/8,trapezoidHeight/4],   center=false);
//         
//          union(){
//            translate([0,0,0]) innerMatRectangle(matInnerRectangleLengthA,matInnerRectangleLengthB,false);
//            trapezoidFringe(false);
//             
//            intersection(){
//                translate([2.2,1.55,0]) roundPoly();
//                translate([3,-trapezoidHeight-1.6]) square(size=[trapezoidBottomEdge/2,trapezoidHeight+2],center=false);
//            }
//
//
//        }
//    }
//    
//}
//NEW
module roundCorner(){

     difference(){
             translate([distanceFirstTrapazoidLongerPartFomEdge+3,-3]) square(size=[trapezoidBottomEdge/8,trapezoidHeight/4],   center=false);
         
          union(){
            translate([0,0,0]) innerMatRectangle(matInnerRectangleLengthA,matInnerRectangleLengthB,false);
            translate([distanceFirstTrapazoidLongerPartFomEdge,0-trapezoidHeight,0.0])         
              translate([0,0,0]) 
              trapazoid(false);
             
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






module roundPoly(minkowskiParameter=true){
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
        polygon(points=[    [(trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,
                             trapezoidHeight],[0,0],[trapezoidBottomEdge  ,   0],
                             [trapezoidBottomEdge - (trapezoidBottomEdge - trapezoidTopEdge)/2.0 ,
                             trapezoidHeight]]);     
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
        trapazoid(minkowskiParameter);
        
     
        }

     
       else {
           //TESTSetting
           minkowskiParameter=true;
           translate([i*(trapezoidBottomEdge+trapezoidTopEdge),0,0]) cornerPolygon(minkowskiParameter);   
          }
          
          
         //ROUND corner Left
                     
       translate([i*(trapezoidBottomEdge+trapezoidTopEdge)-distanceFirstTrapazoidLongerPartFomEdge-0.74,trapezoidHeight+1,0]) 
          union(){
          roundCorner();  
           translate([40-0.3,0,0]) mirror([1,0,0]) roundCorner();
          }
          
            if(i<numberOfMaleConnectors-1){
          //ROUND corner Right     
          translate([i*(trapezoidBottomEdge+trapezoidTopEdge)-distanceFirstTrapazoidLongerPartFomEdge-0.74+trapezoidTopEdge+1.8,trapezoidHeight+1,0]) 
          union(){
          roundCorner();  
           translate([40-0.3,0,0]) mirror([1,0,0]) roundCorner();      
              
              }}
    
          
          
}
}
 

/************************************************************************************************
            Creates the outer frindge with male and female trapezoidial interfaces
************************************************************************************************/

module trapezoidFringe(minkowskiParameter=true){
    //ToDo [2 +7 +2  -2] -> look for constants 
      translate([distanceFirstTrapazoidLongerPartFomEdge,0-trapezoidHeight-2,0.0]) trapezoidRows(minkowskiParameter); 
      translate([distanceFirstTrapazoidLongerPartFomEdge+matInnerRectangleLengthA+7,distanceFirstTrapazoidLongerPartFomEdge,0.0])  rotate([0,0,90])trapezoidRows(minkowskiParameter); 
      translate([matInnerRectangleLengthA-distanceFirstTrapazoidLongerPartFomEdge,matInnerRectangleLengthA+trapezoidHeight+2,0.0])  rotate([0,0,180])trapezoidRows(minkowskiParameter); 
      translate([0-trapezoidHeight-2,matInnerRectangleLengthA-distanceFirstTrapazoidLongerPartFomEdge,0]) rotate([0,0,270])trapezoidRows(minkowskiParameter); 
    }
  


