//--inputs--
n=6;
r=10;
h=15;
twist=1.0*-360/n; //twist angle

nSections=3;
//--inputs--

//needs fixed: face normals point in different directions, causing union() to not work

step=360/n;

bPoints=[
    for (j=[0:1])
        for (i=[0:n-1])
            [r*sin(i*step+(twist*j)),r*cos(i*step+(twist*j)),j*h]
    ];
bFaces=[for (i=[n-1:-1:0])i];
tFaces=[for (i=[n:2*n-1])i];
sideFaces=[for (i=[0:n-1])[i,(i+1)%n,i+n]];
tSideFaces= [for (i=[0:n-1])[i+n,n+(n+i-1)%n,i]];

module section(){
polyhedron(points=bPoints,faces=concat([bFaces],[tFaces],sideFaces,tSideFaces));
}

module sectionMirrored(){
mirror([0,1,0]) section();
}

/*
module stackOfSections(nSections,direction){
    union(){
        for (i = [0:nSections-1]){
            if(direction){
                rotate([0,0,-twist*i]) translate([0,0,i*h]) section();
            }else{
                rotate([0,0,twist*i]) translate([0,0,i*h]) sectionMirrored();
            }
        }
    }
}
*/

module stackOfSectionsAlternating(nSections){
    union(){
        for (i = [0:nSections-1]){
            if(i%2==0){
                rotate([0,0,0]) translate([0,0,i*h]) section();
            }else{
                rotate([0,0,-twist]) translate([0,0,i*h]) sectionMirrored();
            }
        }
    }
}

stackOfSectionsAlternating(nSections);

//0-5
//6-11
