// bream break sensor
beambreakx = 8 / 25.4;
beambreaky = 10.1 / 25.4;
beambreakz = 20.2 / 25.4;
// shifted offset from center of tube
beambreakoffset = 0.1;

// cube through body
tubed = 1.0;
tuber = tubed / 2.;

// main body
cubex = tubed + beambreakx * 2;
cubey = tubed; // + beambreaky * 2;
cubez = beambreakz + 0.75;

// tube clearance
cutoutx = tuber;

// screws
screwd = 0.13;  // 4-40 free fit
screwr = screwd / 2;
screwspacingx = 1.25 / 2;
screwspacingy = 1.25 / 2;

difference() {
    cube(size=[cubex, cubey, cubez], center=true);
    // tube
    cylinder(cubez*2, r=tuber, center=true, $fn=100);
    // beam breaks
    translate([0, beambreakoffset, 0]) {
        cube(size=[cubex*2, beambreaky, beambreakz], center=true);
    };
    
    // tube clearance
    cube(size=[cutoutx, cubey*2, cubez*2], center=true);
    
    // screw holes
    for (x=[-screwspacingx, screwspacingx]) {
        for (y=[-screwspacingy, screwspacingy]) {
            
            
            rotate([90, 0, 0])
            translate([x, y, 0])
            cylinder(cubey*2, r=screwr, center=true, $fn=100);
        };
    };
    
    // select only 1
    translate([-cubex, 0, 0]) cube(size=[cubex*2, cubey*2, cubez*2], center=true);
};