 //<>//
/*problem met:
 
 resolve: replace all the graphic with Pgrapihc and set a white background for each frame
 */
import TUIO.*;

import spacebrew.*;

// declare a TuioProcessing client

TuioProcessing tuioClient;

String b5 ;

PGraphics ellipse, line1, line2, line3, bgrect;

String server="188.166.209.56";
String name="Interface";
String description ="Client that sends and receives range messages. Range values go from 0 to 1023.";

Spacebrew sb;

/*-------drawing ripple-----------*/
int numRipple = 50;
int currentRipple = 0;
float stroke;
float diameter;
int index;
/*-----------*/

// these are some helper variables which are used
// to create scalable graphical feedback
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
PFont font;

int ax;
int ay;
float ax1;
float ay1;
int bx;
int by;
int cx;
int cy;

String b1, b2, b3;
int B1, B2, B3;
int PB1, PB2, PB3;

boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks

boolean state1 = false;
boolean state2 = false;
boolean buttonPressed1=false, buttonPressed2=false, buttonPressed3=false;

// Keep track of our current place in the range
int local_slider_val = 512;
int remote_slider_val = 512;


void setup()
{
  //Pgraphhics setting
  ellipse = createGraphics(width, height);
  line1 = createGraphics(width, height);
  line2 = createGraphics(width, height);
  line3 = createGraphics(width, height);
  bgrect = createGraphics(width, height);
  // GUI setup
  noCursor();
  fullScreen();
  //size(displayWidth, displayHeight);
  noStroke();
  fill(0);

  // periodic updates
  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); // or callback updates 

  font = createFont("Arial", 18);
  scale_factor = height/table_size;

  // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuioClient  = new TuioProcessing(this);


  sb = new Spacebrew( this );
  sb.addSubscribe( "b1", "string" );
  sb.addSubscribe( "b2", "string" );
  sb.addSubscribe( "b3", "string" );
  sb.addSubscribe("buttonpress1", "boolean");
  sb.addSubscribe("buttonpress2", "boolean");
  sb.addSubscribe("buttonpress3", "boolean");
  //sb.addPublish( "ax", "string", ax ); 
  //sb.addPublish( "ay", "string", ay );
  //sb.addPublish( "bx", "string", bx ); 
  //sb.addPublish( "by", "string", by );

  sb.connect(server, name, description );
}

// within the draw method we retrieve an ArrayList of type <TuioObject>, <TuioCursor> or <TuioBlob>
// from the TuioProcessing client and then loops over all lists to draw the graphical feedback.
void draw()
{
  background(34, 37, 42, 28);
  textFont(font, 18*scale_factor);
  float obj_size = object_size*scale_factor; 
  float cur_size = cursor_size*scale_factor; 

  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0; i<tuioObjectList.size (); i++) {
    TuioObject tobj = tuioObjectList.get(i);

    //    stroke(0);

    /*--------the code below is for draw line---------*/
    if (
      (dist(ax, ay, bx, by)<1500||
      dist(ax, ay, cx, cy)<1500||
      dist(bx, by, cx, cy)<1500
      )) {
      /*-------------------------------------------*/


      pushMatrix();
      stroke(155);

      if ((cx==0&&bx==0)||(bx==0&&ax==0)||(ax==0&&cx==0)) {
        noStroke();
        println("Success!Debug");
      } else if (tobj.getSymbolID()!=39&&cx==0&&cy==0) {
        if (B2 == 1||B1 == 1) {
          pushMatrix();

          stroke(255, 86, 86);
          if (B1 == B2) {
           strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 2, 5));
          } else {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
          }
          line(ax, ay, bx, by);

          popMatrix();
        } 
        if (B2 == 2||B1 == 2) {
          pushMatrix();
          stroke(80, 239, 224);
          if (B1 == B2) {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 2, 5));
          } else {
           strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
          }
          line(ax, ay, bx, by);
          popMatrix();
        } 
        if (B2 == 3||B1 == 3) {
          pushMatrix();
          stroke(13, 238, 102);
          if (B1 == B2) {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 2, 5));
          } else {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
          }
          line(ax, ay, bx, by);
          popMatrix();
        }
        if (b2==null && b1 ==null) {
          pushMatrix();
          stroke(255, 20);     
          strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));        
          line(ax, ay, bx, by);
          popMatrix();
        }
        println("Success!A");
      } else if (tobj.getSymbolID()!=27&&bx==0&&by==0) {
        if (B3 == 1||B1 == 1) {
          pushMatrix();
          stroke(255, 86, 86);
          if (B1 == B3) {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 2, 5));
          } else {
           strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
          }
          line(ax, ay, cx, cy);
          popMatrix();
        } 
        if (B3 == 2||B1 == 2) {
          pushMatrix();
          stroke(80, 239, 224);
          if (B1 == B3) {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 2, 5));
          } else {
           strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
          }
          line(ax, ay, cx, cy);
          popMatrix();
        } 
        if (B3 == 3||B1 == 3) {
          pushMatrix();
          stroke(13, 238, 102);
          if (B1 == B3) {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 2, 5));
          } else {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
          }
          line(ax, ay, cx, cy);
          popMatrix();
        }
        if (b1==null && b3 ==null) {
          pushMatrix();
          stroke(255, 20);
          strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
          line(ax, ay, cx, cy);
          popMatrix();
        }

        println("Success!B");
      } else if (tobj.getSymbolID()!=26&&ax==0&&ay==0) {
        if (B2 == 1||B3 == 1) {
          pushMatrix();
          stroke(255, 86, 86);
          if (B3 == B2) {
             strokeWeight(map(dist(bx, by, cx, cy), 2500, 500, 2, 5));
          } else {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
          }
          line(bx, by, cx, cy);
          popMatrix();
        } 
        if (B2 == 2||B3 == 2) {
          pushMatrix();
          stroke(80, 239, 224);
          ;
          if (B3 == B2) {
             strokeWeight(map(dist(bx, by, cx, cy), 2500, 500, 2, 5));
          } else {
             strokeWeight(map(dist(bx, by, cx, cy), 2500, 500, 0, 3));
          }
          line(bx, by, cx, cy);
          popMatrix();
        } 
        if (B2 == 3||B3 == 3) {
          pushMatrix();
          stroke(13, 238, 102);
          if (B3 == B2) {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 2, 5));
          } else {
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
          }
          line(bx, by, cx, cy);
          popMatrix();
        }
        //the code below is for drawing the line with out any touch
        if (b2==null && b3 ==null) {
          pushMatrix();
          stroke(255, 20);     
          strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));        
          line(bx, by, cx, cy);
          popMatrix();
        }
        println("Success!C");

        //println("27 ax: "+ax+" ay: "+ay);
        //println("27 bx: "+bx+" by: "+by);
        //println("27 cx: "+cx+" cy: "+cy);
      } 
      /*this line below need modify--------------------------------------------------------------------*/
      else if (cx!=0&&ax!=0&&bx!=0) {
        /////////////////////////////////////////
        if (B1 ==1||B2==1||B3==1) {
          println("All==1");
          /*---------------*/
          if (B1 == 1) {
            pushMatrix();
            stroke(255, 86, 86);
            if (B3 == B2 || B3 ==B1) {
              strokeWeight(3);
            } else {
              strokeWeight(1);
            }
            line(bx, by, ax, ay);
            line(cx, cy, ax, ay);

            popMatrix();

            pushMatrix();
            stroke(144);
            line(cx, cy, bx, by);
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
            popMatrix();
          }
          /*-----------------------*/
          if (B2 == 1) {
            pushMatrix();
            stroke(255, 86, 86);
            if (B3 == B2 || B3 ==B1) {
              strokeWeight(3);
            } else {
              strokeWeight(1);
            }
            line(bx, by, ax, ay);
            line(cx, cy, bx, by);

            popMatrix();

            pushMatrix();
            stroke(144);
            line(cx, cy, ax, ay);
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
            popMatrix();
          }
          /*-----------------------*/
          if (B3 == 1) {
            pushMatrix();
            stroke(255, 86, 86);
            if (B3 == B2 || B3 ==B1) {
              strokeWeight(3);
            } else {
              strokeWeight(1);
            }
            line(cx, cy, ax, ay);
            line(cx, cy, bx, by);

            popMatrix();

            pushMatrix();
            stroke(144);
            line(bx, by, ax, ay);
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
            popMatrix();
          }
          /*------------------------------*/
        } else if (B2 == 2||B3 == 2||B1==2) {
          /*---------------*/
          if (B1 == 2) {
            pushMatrix();
            stroke(80, 239, 224);
            ;
            if (B3 == B1||B1 == B2) {
              strokeWeight(3);
            } else {
              strokeWeight(1);
            }
            line(bx, by, ax, ay);
            line(cx, cy, ax, ay);

            popMatrix();
            stroke(144);
            line(cx, cy, bx, by);
            pushMatrix();
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
            popMatrix();
          }
          /*-----------------------*/
          if (B2 == 2) {
            pushMatrix();
            stroke(80, 239, 224);
            ;
            if (B3 == B2 || B2 ==B1) {
              strokeWeight(3);
            } else {
              strokeWeight(1);
            }
            line(bx, by, ax, ay);
            line(cx, cy, bx, by);

            popMatrix();
            stroke(144);
            line(cx, cy, ax, ay);
            pushMatrix();
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
            popMatrix();
          }
          /*-----------------------*/
          if (B3 == 2) {
            pushMatrix();
            stroke(80, 239, 224);
            ;
            if (B3 == B2 || B3 ==B1) {
              strokeWeight(3);
            } else {
              strokeWeight(1);
            }
            line(cx, cy, ax, ay);
            line(cx, cy, bx, by);

            popMatrix();
            stroke(144);
            line(bx, by, ax, ay);
            pushMatrix();
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
            popMatrix();
          }
          /*------------------------------*/
        } else if (B2 == 3||B3 == 3||B1==3) {
          /*---------------*/
          if (B1 == 3) {
            pushMatrix();
            stroke(13, 238, 102);
            if (B3 == B1||B1 == B2) {
              strokeWeight(5);
            } else {
              strokeWeight(1);
            }
            line(bx, by, ax, ay);
            line(cx, cy, ax, ay);

            popMatrix();
            stroke(144);
            line(cx, cy, bx, by);
            pushMatrix();
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
            popMatrix();
          }
          /*-----------------------*/
          if (B2 == 3) {
            pushMatrix();
            stroke(13, 238, 102);
            if (B3 == B2 || B2 ==B1) {
              strokeWeight(5);
            } else {
              strokeWeight(1);
            }
            line(bx, by, ax, ay);
            line(cx, cy, bx, by);

            popMatrix();
            stroke(144);
            line(cx, cy, ax, ay);
            pushMatrix();
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
            popMatrix();
          }
          /*-----------------------*/
          if (B3 == 3) {
            pushMatrix();
            stroke(13, 238, 102);
            if (B3 == B2 || B3 ==B1) {
              strokeWeight(5);
            } else {
              strokeWeight(1);
            }
            line(cx, cy, ax, ay);
            line(cx, cy, bx, by);

            popMatrix();
            stroke(144);
            line(bx, by, ax, ay);
            pushMatrix();
            strokeWeight(map(dist(ax, ay, cx, cy), 2500, 500, 0, 3));
            popMatrix();
          }
          /*------------------------------*/
        } else {
          line(bx, by, cx, cy);
          line(ax, ay, cx, cy);
          line(ax, ay, bx, by);
        }
      }
      /*----------------------------------------------------------------------------------------------*/
      popMatrix();
      println("Success!");
    }
    /*----The code below is for vanish of the users--------*/
    if (

      ax<150||ax>(width-150)||ay<150||ay>(height-150)) {
      ax=0;
      ay=0;  
      B1=0;
      println("Success!");
    } 
    if (
      bx<150||bx>(width-150)||by<150||by>(height-150)) {
      bx=0;
      by=0;
      B2=0;
      println("Success!");
    } 
    if (
      cx<150||cx>(width-150)||cy<150||cy>(height-150)
      ) {
      //strokeWeight(0);
      cx=0;
      cy=0;
      B3=0;
      println("Success!");
    }
    /*-------------------------------------------*/
    //}


    /*----------------------------------------------------------------------------------
     
     
     The code below is for drawing the ellipse
     
     -----------------*/
    if (tobj.getSymbolID()==26) {
      pushMatrix();   
      if (b1==null) {
        noFill();
        stroke(255);
        strokeWeight(3);
      } else if (B1==2) {

        // Ripple(8, 8, 2);
        stroke(80, 239, 224);
        strokeWeight(3);
        if (B2 ==2 ||B3==2) {
          fill(80, 239, 224);
        } else {
          noFill();
        }
      } else if (B1==3) {

        //Ripple(8, 8, 2);
        stroke(13, 238, 102);
        strokeWeight(3);
        if (B2 ==3 ||B3==3) {
          fill(13, 238, 102);
        } else {
          noFill();
        }
      } else if (B1==1) {
        stroke(255, 86, 86);
        strokeWeight(3);
        if (B2 ==1 ||B3==1) {
          fill(255, 86, 102);
        } else {
          noFill();
        }
        println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      }else if (B1==0){
        stroke(255);
        strokeWeight(3);
        noFill();
      }
      
      
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      ellipse(0, 0, 150, 150);
      popMatrix();
      
      if (B1!=B2&&B1!=B3||B1==0) {
        pushMatrix();
        noStroke();
        fill(61);
        translate(tobj.getScreenX(width), tobj.getScreenY(height));
        ellipse(0, 0, 130, 130);
        popMatrix();
      }

      if (B1==1&&buttonPressed1 ==true) {
        Ripple(tobj.getScreenX(width), tobj.getScreenY(height), 1);
      } else if (B1==3&&buttonPressed1 ==true) {
        Ripple(tobj.getScreenX(width), tobj.getScreenY(height), 1);
      } else if (B1==2&&buttonPressed1 ==true) {
        Ripple(tobj.getScreenX(width), tobj.getScreenY(height), 1);
      } else {
      }

      pushMatrix();
      fill(255);
      textSize(25);
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      textAlign(CENTER, CENTER);
      text("MZ", 0, 0);

      popMatrix();

      //point for ID 26     
      ax=tobj.getScreenX(width);
      ay=tobj.getScreenY(height);
    } else {
      state1=false;
    }
    /*--------------------------*/
    if (tobj.getSymbolID()==39) {
      pushMatrix();   

      if (b3==null) {
        noFill();
        stroke(255);
        strokeWeight(3);
      } else if (B3==2) {

        // Ripple(8, 8, 2);
        stroke(80, 239, 224);
        strokeWeight(3);
         if (B1 ==2 ||B2==2) {
          fill(80, 239, 224);
        } else {
          noFill();
        }
      } else if (B3==3) {

        //Ripple(8, 8, 2);
        stroke(13, 238, 102);
        strokeWeight(3);
         if (B1 ==3 ||B2==3) {
          fill(13, 238, 102);
        } else {
          noFill();
        }
      } else if (B3==1) {

        stroke(255, 86, 86);
        strokeWeight(3);
           if (B1 ==1 ||B2==1) {
          fill(255, 86, 86);
        } else {
          noFill();
        }
        println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      }else if (B3==0){
        stroke(255);
        strokeWeight(3);
        noFill();
      }
      
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      ellipse(0, 0, 150, 150);
      popMatrix();
      
      if(B3!=B1&&B3!=B2||B3==0){
      pushMatrix();
      noStroke();
      fill(61);
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      ellipse(0, 0, 130, 130);
      popMatrix();
      }


      if (B3==1&&buttonPressed3 ==true) {
        Ripple(tobj.getScreenX(width), tobj.getScreenY(height), 1);
      } else if (B3==3&&buttonPressed3 ==true) {
        Ripple(tobj.getScreenX(width), tobj.getScreenY(height), 1);
      } else if (B3==2&&buttonPressed3 ==true) {
        Ripple(tobj.getScreenX(width), tobj.getScreenY(height), 1);
      } else {
      }

      pushMatrix();
      fill(255);
      textSize(25);
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      textAlign(CENTER, CENTER);
      text("DLF", 0, 0);

      popMatrix();

      //point for ID 26     
      cx=tobj.getScreenX(width);
      cy=tobj.getScreenY(height);
    } else {
      state1=false;
    }
    /*----------------------------*/
    if (tobj.getSymbolID()==27) {
      pushMatrix();   
      //ellipse1.beginDraw();

      if (b2==null) {
        noFill();
        stroke(255);
        strokeWeight(3);
      } else if (B2==2) {

        // Ripple(8, 8, 2);
        stroke(80, 239, 224);
        strokeWeight(3);
        if (B1 ==2 ||B3==2) {
          fill(80, 239, 224);
        } else {
          noFill();
        }
      } else if (B2==3) {

        //Ripple(8, 8, 2);
        stroke(13, 238, 102);
        strokeWeight(3);
        if (B1 ==3 ||B3==3) {
          fill(13, 238, 102);
        } else {
          noFill();
        }
      } else if (B2==1) {

        stroke(255, 86, 86);
        strokeWeight(3);
        if (B1 ==1 ||B3==1) {
          fill(255, 86, 86);
        } else {
          noFill();
        }
        println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
      }else if (B2==0){
        stroke(255);
        strokeWeight(3);
        noFill();
      }
      
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      ellipse(0, 0, 150, 150);
      popMatrix();
      
      if(B2!=B1&&B2!=B3||B2==0){
      pushMatrix();
      noStroke();
      fill(61);
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      ellipse(0, 0, 130, 130);
      popMatrix();
      }


      if (B2==1&&buttonPressed2 ==true) {
        Ripple(tobj.getScreenX(width), tobj.getScreenY(height), 1);
      } else if (B2==3&&buttonPressed2 ==true) {
        Ripple(tobj.getScreenX(width), tobj.getScreenY(height), 1);
      } else if (B2==2&&buttonPressed2 ==true) {
        Ripple(tobj.getScreenX(width), tobj.getScreenY(height), 1);
      } else {
      }

      pushMatrix();
      fill(255);
      textSize(25);
      translate(tobj.getScreenX(width), tobj.getScreenY(height));
      rotate(tobj.getAngle());
      textAlign(CENTER, CENTER);
      text("YNL", 0, 0);

      popMatrix();
      //point for ID 27     
      bx=tobj.getScreenX(width);
      by=tobj.getScreenY(height);
    } else if (tobj.getSymbolID()!=27) {
      state2 = false;
    }
  }

  ArrayList<TuioCursor> tuioCursorList = tuioClient.getTuioCursorList();
  for (int i=0; i<tuioCursorList.size (); i++) {
    TuioCursor tcur = tuioCursorList.get(i);
    ArrayList<TuioPoint> pointList = tcur.getPath();

    if (pointList.size()>0) {
      stroke(0, 0, 255);
      TuioPoint start_point = pointList.get(0);
      for (int j=0; j<pointList.size (); j++) {
        TuioPoint end_point = pointList.get(j);
        line(start_point.getScreenX(width), start_point.getScreenY(height), end_point.getScreenX(width), end_point.getScreenY(height));
        start_point = end_point;
      }

      stroke(192, 192, 192);
      fill(192, 192, 192);
      ellipse( tcur.getScreenX(width), tcur.getScreenY(height), cur_size, cur_size);
      fill(0);
      text(""+ tcur.getCursorID(), tcur.getScreenX(width)-5, tcur.getScreenY(height)+5);
    }
  }

  ArrayList<TuioBlob> tuioBlobList = tuioClient.getTuioBlobList();
  for (int i=0; i<tuioBlobList.size (); i++) {
    TuioBlob tblb = tuioBlobList.get(i);
    stroke(0);
    fill(0);
    pushMatrix();
    translate(tblb.getScreenX(width), tblb.getScreenY(height));
    rotate(tblb.getAngle());
    ellipse(-1*tblb.getScreenWidth(width)/2, -1*tblb.getScreenHeight(height)/2, tblb.getScreenWidth(width), tblb.getScreenWidth(width));
    popMatrix();
    fill(255);
    text(""+tblb.getBlobID(), tblb.getScreenX(width), tblb.getScreenX(width));
  }
}

/*This is for drawing click effect*/
void Ripple(int x, int y, int i) {
  //background(0);
  // translate(width/2, height/2);
  pushMatrix();
  stroke(255, 255, 255, 900-diameter*5);
  ellipse(x, y, diameter/i, diameter/i);
  diameter+=20;
  stroke = map(diameter, 0, width/3, 65, 0);
  if (stroke>0) {
    strokeWeight(stroke);
  } else if (stroke==0) {
    noStroke();
  }

  if (diameter>=180) {
    diameter = 0;
  } else if (diameter ==0) {
    ;
  }
  popMatrix();
}

/*----------receiving from spacebrew--------------*/
void onStringMessage( String name, String value ) {
  println("got string message" +" : "+ name + " : " + value);
  println(name);
  if (name.equals("b1")) {
    b1 = value;
    if (b1.equals("b1")) {
      B1 = 1;
    } else if (b1.equals("b2")) {
      B1 = 2;
    } else if (b1.equals("b3")) {
      B1 = 3;
    }

    PB1 = 1;
    PB2 = 0;
    PB3=0;
    println("b1 " + b1);
    println("PB1 " + PB1);
  } else if (name.equals("b2")) {
    b2 = value;
    if (b2.equals("b1")) {
      B2 = 1;
    } else if (b2.equals("b2")) {
      B2 = 2;
    } else if (b2.equals("b3")) {
      B2 = 3;
    }
    // B2 = parseInt(b2);
    PB2 = 2;
    PB1 = 0;
    PB3=0;
    println("b1 " + b2);
    println("PB2 " + PB2);
  } else if (name.equals("b3")) {
    b3 = value;
    if (b3.equals("b1")) {
      B3 = 1;
    } else if (b3.equals("b2")) {
      B3 = 2;
    } else if (b3.equals("b3")) {
      B3 = 3;
    }
    // B3 = parseInt(b3);
    PB3 = 3;
    PB1 = 0;
    PB2=0;
    println("b3 " + b3);
    println("PB3 " + PB3);
  }
}///

void onBooleanMessage(String name, boolean value) {
  println("Got booleanmessage"+":"+name+":"+value);
  if (name.equals("buttonpress1")) {
    buttonPressed1 = value;
  } else if (name.equals("buttonpress2")) {
    buttonPressed2 = value;
  } else if (name.equals("buttonpress3")) {
    buttonPressed3 = value;
  }
}

// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}


void onRangeMessage( String name, int value ) {
  println("got range message " + name + " : " + value);
  remote_slider_val = value;
}