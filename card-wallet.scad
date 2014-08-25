margin = 2;
//
cutOutDepth = margin;
// Gummi Breite
rubberWidth = 8;

notchR = 10;
notchDepth = margin*1.5;

// Kreditkarte
// 85,60 mm × 53,98mm x 0,762 mm (exakt 0,03 Zoll)
cardLength = 85.6 + margin;
cardWidth =  53.98 + margin;
cardHeight = 0.8;

// Module miniround 
module miniround(size, radius) {
	$fn = 50;
	x = size[0]-radius/2;
	y = size[1]-radius/2;

	minkowski() {
		cube(size=[x,y,size[2]]);
		cylinder(r=radius);
	}
}

// Card basic
module card(){
	 miniround([cardLength,cardWidth,cardHeight], 2.5);
}

// card mit zwei gummi cut outs an Längsseite  
module cardFourCutOuts() {
	difference() {
		card();
	// cut out notch at bottom for pushing cards out
		translate([20, -5, -2])
			cylinder(r=notchR, h=cardHeight+4);
		
		// Cut out for rubber 
		translate([0, (cardWidth/2)-rubberWidth/2, -2]) 
 			rotate(90)
			cube([rubberWidth, cutOutDepth+1, 5]);
		// Cut out for rubber
		translate([cardLength+2, (cardWidth/2)-rubberWidth/2, -2])
			rotate(90)
			cube([rubberWidth, cutOutDepth+1, 5]);
    
 		translate([(cardLength/2-rubberWidth/2), cardWidth-0.5, -2]) 
			cylinder(r=1.2, h=cardHeight+4);
		translate([10, cardWidth-0.5, -2]) 
			cylinder(r=1.2, h=cardHeight+4);
 		translate([(cardLength-20), cardWidth-0.5, -2]) 
			cylinder(r=1.2, h=cardHeight+4);
		// Money / RFID Cad outcut
		translate([0.5,-0.2,0])
			cube([85.6+0.2, 53.98+0.2, 0.77]);
		
	}
}

// mini pocket card wallet
cardFourCutOuts();
//difference() {
//	cardFourCutOuts();
//	translate(20,0,0) 
//		cylinder(r=5, h=2);
//}


