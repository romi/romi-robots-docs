module Frame()
{  
    translate([-20,-20,-80])
        cube(size = [40,40,80], center = false);    
}

module WheelAxis(H)
{  
    translate([0,0,-80])
        cylinder(h=80+71.5, r=8, center=false,$fn=360);
}

module Rover(H)
{
    Frame();
    WheelAxis(H);
}

module MotorAxis()
{  
    translate([0, 0, 2])
        cylinder(h=26, r=6, center=false,$fn=360);
}

module MotorRing()
{  
    translate([0, 0, 0])
        cylinder(h=2, r=32/2, center=false,$fn=360);
}

module MotorGears(L)
{  
    difference() {
        translate([0, 0, -L])
            cylinder(h=L, r=56/2, center=false,$fn=360);
    
        translate([22.5/sqrt(2), 22.5/sqrt(2), -9.9])
            rotate ([0, 0, 0]) 
                cylinder(h=10, r=5/2, center=false,$fn=360);
        translate([-22.5/sqrt(2), 22.5/sqrt(2), -9.9])
            rotate ([0, 0, 0]) 
                cylinder(h=10, r=5/2, center=false,$fn=360);
        translate([22.5/sqrt(2), -22.5/sqrt(2), -9.9])
            rotate ([0, 0, 0]) 
                cylinder(h=10, r=5/2, center=false,$fn=360);
        translate([-22.5/sqrt(2), -22.5/sqrt(2), -9.9])
            rotate ([0, 0, 0]) 
                cylinder(h=10, r=5/2, center=false,$fn=360);
    }
}

module MotorStepper()
{  
    translate([-57/2, -57/2, -56])
        cube(size = [57, 57, 56], center = false);    
}

module Motor()
{
    translate([0, 0, -72])
        MotorStepper();
    MotorGears(72);
    MotorRing();
    MotorAxis();
}

module CouplerRuland(H)
{  
    translate([0, 0, H-15])
        cylinder(h=44.5, r=33/2, center=false,$fn=360);
}
module BottomBracket()
{
    difference() {
        union() {
            // Back
            rotate ([0,0,0]) 
                translate([20,-30,-55])
                    cube(size = [5,60,60], center = false);    
            // Top 
            rotate ([0,0,0]) 
                translate([0.2,-30,0])
                    cube(size = [24.8,60,5], center = false);            
            // Left
            rotate ([0,0,0]) 
                translate([0.2,-30,-55])
                    cube(size = [24.8,9.9,60], center = false);    
            // Right
            rotate ([0,0,0]) 
                translate([0.2,20.1,-55])
                    cube(size = [24.0,9.9,60], center = false);    
        }
        translate([-21,-21,-6])
            cube(size = [42,42,6], center = false);    
        // Top hole
        translate([0,0,-0.1])
            rotate ([0,0,0]) 
                cylinder(h=5.2, r=34/2, center=false,$fn=360);
        // Fixation screw holes
        translate([25.1,-24,-5])
            rotate ([0,-90,0]) 
                cylinder(h=25.2, r=4.2/2, center=false,$fn=360);
        translate([25.1,-24,-45])
            rotate ([0,-90,0]) 
                cylinder(h=25.2, r=4.2/2, center=false,$fn=360);
        translate([25.1, 24, -5])
            rotate ([0, -90, 0]) 
                cylinder(h=25.2, r=4.2/2, center=false,$fn=360);
        translate([25.1, 24, -45])
            rotate ([0,-90,0]) 
                cylinder(h=25.2, r=4.2/2, center=false,$fn=360);        
    }
}

module TopBracket()
{
    difference() {
        translate([-25, -30, 0])
            cube(size = [50, 60, 60], center = false);    
        translate([-20, -20, -0.1])
            cube(size = [40, 50.1, 50.1], center = false);    
        
        // Space for disk of motor
        translate([0, 0, 57.5])
            cylinder(h=2.51, r=32.2/2, center=false,$fn=360);
    
        // Space for motor axis
        translate([0, 0, 49.9])
            cylinder(h=10.2, r=14/2, center=false,$fn=360);
        
        // Motor screw holes: through
        translate([22.5/sqrt(2), 22.5/sqrt(2), 49.9])
            cylinder(h=10.2, r=5.2/2, center=false,$fn=360);
        translate([-22.5/sqrt(2), 22.5/sqrt(2), 49.9])
            cylinder(h=10.2, r=5.2/2, center=false,$fn=360);
        translate([22.5/sqrt(2), -22.5/sqrt(2), 49.9])
            cylinder(h=10.2, r=5.2/2, center=false,$fn=360);
        translate([-22.5/sqrt(2), -22.5/sqrt(2), 49.9])
            cylinder(h=10.2, r=5.2/2, center=false,$fn=360);
        
        // Motor screw holes: head
        translate([22.5/sqrt(2), 22.5/sqrt(2), 0])
            cylinder(h=55, r=8.7/2, center=false,$fn=360);
        translate([-22.5/sqrt(2), 22.5/sqrt(2), 0])
            cylinder(h=55, r=8.7/2, center=false,$fn=360);
        translate([22.5/sqrt(2), -22.5/sqrt(2), 0])
            cylinder(h=55, r=8.7/2, center=false,$fn=360);
        translate([-22.5/sqrt(2), -22.5/sqrt(2), 0])
            cylinder(h=55, r=8.7/2, center=false,$fn=360);
            
        // Fixation screw holes
        translate([25.1, -24, 45])
            rotate ([0,-90,0]) 
                cylinder(h=50.2, r=4.2/2, center=false,$fn=360);
        translate([25.1, -24, 27.5])
            rotate ([0,-90,0]) 
                cylinder(h=50.2, r=4.2/2, center=false,$fn=360);
        translate([25.1, -24, 10])
            rotate ([0,-90,0]) 
                cylinder(h=50.2, r=4.2/2, center=false,$fn=360);
        translate([25.1, 24, 45])
            rotate ([0, -90, 0]) 
                cylinder(h=50.2, r=4.2/2, center=false,$fn=360);
        translate([25.1, 24, 27.5])
            rotate ([0, -90, 0]) 
                cylinder(h=50.2, r=4.2/2, center=false,$fn=360);
        translate([25.1, 24, 10])
            rotate ([0,-90,0]) 
                cylinder(h=50.2, r=4.2/2, center=false,$fn=360);        
    }    
}

module Encoder()
{  
    translate([0, 0, 0])
        cylinder(h=39, r=40/2, center=false,$fn=360);
    translate([0, 0, -5])
        cylinder(h=5, r=20/2, center=false,$fn=360);
    translate([0, 0, -20])
        cylinder(h=15, r=6/2, center=false,$fn=360);
}

module Pulley()
{  
    translate([0, 0, 6])
        cylinder(h=8.3, r=13.5/2, center=false,$fn=360);
    translate([0, 0, 0])
        cylinder(h=6, r=17.5/2, center=false,$fn=360);
}

module EncoderBracket_Opkon_MRV50()
{  
    difference() {
        union () {
            translate([0, 0, 0])
                cylinder(h = 5, r = 50/2, center=false,$fn=360);
            translate([-20, -25, 0])
                cube(size = [40, 25, 5], center = false);    
            translate([-25, -100, 0])
                cube(size = [15, 100, 5], center = false);    
            translate([10, -100, 0])
                cube(size = [15, 100, 5], center = false);    

            translate([-25, -100, -10])
                cube(size = [5, 90, 15], center = false);    
            translate([20, -100, -10])
                cube(size = [5, 90, 15], center = false);    
        }
        // Center hole
        translate([0, 0, -0.1])
            cylinder(h=5.2, r=(30+0.2)/2, center=false,$fn=360);
        // Screw holes
        translate([20, 0, -0.1])
            cylinder(h = 5.2, r=3.1/2, center=false,$fn=360);
        translate([20 * cos(60), 20*sin(60), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([20 * cos(120), 20*sin(120), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([20 * cos(180), 20*sin(180), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([20 * cos(240), 20*sin(240), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([20 * cos(300), 20*sin(300), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        // Slider holes
        translate([-25.1, -95, -7])
            cube(size = [5.2, 30, 3], center = false);    
        translate([-25.1, -45, -7])
            cube(size = [5.2, 30, 3], center = false);    

        translate([19.9, -95, -7])
            cube(size = [5.2, 30, 3], center = false);    
        translate([19.9, -45, -7])
            cube(size = [5.2, 30, 3], center = false);    
    }
}

module EncoderBracket_Omron()
{  
    difference() {
        union () {
            translate([0, 0, 0])
                cylinder(h = 5, r = 20, center=false,$fn=360);
            translate([-20, -25, 0])
                cube(size = [40, 25, 5], center = false);    
            translate([-25, -100, 0])
                cube(size = [15, 100, 5], center = false);    
            translate([10, -100, 0])
                cube(size = [15, 100, 5], center = false);    

            translate([-25, -100, -10])
                cube(size = [5, 90, 15], center = false);    
            translate([20, -100, -10])
                cube(size = [5, 90, 15], center = false);    
        }
        // Center hole
        translate([0, 0, -0.1])
            cylinder(h=5.2, r=10.1, center=false,$fn=360);
        // Screw holes
        translate([15, 0, -0.1])
            cylinder(h = 5.2, r=3.1/2, center=false,$fn=360);
        translate([15 * cos(60), 15*sin(60), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([15 * cos(120), 15*sin(120), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([15 * cos(180), 15*sin(180), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([15 * cos(240), 15*sin(240), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([15 * cos(300), 15*sin(300), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        // Slider holes
        translate([-25.1, -95, -7])
            cube(size = [5.2, 30, 3], center = false);    
        translate([-25.1, -45, -7])
            cube(size = [5.2, 30, 3], center = false);    

        translate([19.9, -95, -7])
            cube(size = [5.2, 30, 3], center = false);    
        translate([19.9, -45, -7])
            cube(size = [5.2, 30, 3], center = false);    
    }
}


module EncoderBracket2()
{  
    difference() {
        union () {
            translate([0, 35, 0])
                scale([1, 0.8, 1])
                    cylinder(h=5, r=25, $fn=360);
            translate([-25, -30, 0])
                cube(size = [15, 65, 5], center = false);    
            translate([10, -30, 0])
                cube(size = [15, 65, 5], center = false);    

            translate([-25, -30, -10])
                cube(size = [5, 60, 15], center = false);    
            translate([20, -30, -10])
                cube(size = [5, 60, 15], center = false);    
        }
        // Center hole
        translate([0, 35, -0.1])
            cylinder(h=5.2, r=10.1, center=false,$fn=360);
        // Screw holes
        translate([15, 35, -0.1])
            cylinder(h = 5.2, r=3.1/2, center=false,$fn=360);
        translate([15 * cos(60), 35 + 15*sin(60), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false, $fn=360);
        translate([15 * cos(120), 35 + 15*sin(120), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([15 * cos(180), 35 + 15*sin(180), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false, $fn=360);
        translate([15 * cos(240), 35 + 15*sin(240), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        translate([15 * cos(300), 35 + 15*sin(300), -0.1])
            cylinder(h = 5.2, r = 3.1/2, center=false,$fn=360);
        // Slider holes
        translate([-25.1, 3, -7])
            cube(size = [5.2, 23, 3], center = false);    
        translate([-25.1, -23-3, -7])
            cube(size = [5.2, 23, 3], center = false);    

        translate([19.9, 3, -7])
            cube(size = [5.2, 23, 3], center = false);    
        translate([19.9, -26, -7])
            cube(size = [5.2, 23, 3], center = false);    
    }
}

module SupportPlate(H)
{  
    color("Silver", 1.0) 
        //cube(size = [5, 60, H], center = false);        
        linear_extrude(height = 5, center = false, convexity = 10)
            import (file = "steering-vertical-2.dxf");
    }

*#Rover(71.5);
*#translate([0, 0, 72.5 + 28 + 44.5-30])
    rotate ([180, 0, 0]) 
    Motor();

*#CouplerRuland(71.5);

*BottomBracket();
    
*rotate ([0,0,180]) 
    BottomBracket();

*translate([0, 0, 72.5 + 28 + 44.5-30 - 60])
    TopBracket();
    
//translate([0, 0, 45])
union () {
    *translate([0, 35, 0]) {
        #Encoder();
        #translate([0, 0, -20])
            Pulley();
    }
    translate([0, 0, -5])
        EncoderBracket_Opkon_MRV50();
}

*translate([25, -30, -55])
rotate([90, 0, 90]) 
    SupportPlate(170);

*translate([-25, 30, -55])
rotate([90, 0, -90]) 
    SupportPlate(170);

