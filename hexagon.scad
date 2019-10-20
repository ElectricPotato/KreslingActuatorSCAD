//--inputs--
n=6;
r=10;
h=15;
twist=-360/n; //twist angle

nSections=1;
//--inputs--

//needs fixed: face normals point in different directions, causing union() to not work

step=360/n;

bPoints=[
    for (j=[0:1])
        for (i=[0:n-1])
            [r*sin(i*step+(twist*j)),r*cos(i*step+(twist*j)),j*h]
    ];
echo(bPoints);
bFaces=[for (i=[0:n-1])i];
tFaces=[for (i=[n:2*n-1])i];
sideFaces=[for (i=[0:n-1])[i,(i+1)%n,i+n]];
tSideFaces= [for (i=[0:n-1])[i+n,(i+n+1)%(2*n),i+1]];


module section(){
polyhedron(points=bPoints,faces=concat([bFaces],[tFaces],sideFaces,tSideFaces));
}
union(){
    for (i = [0:nSections-1]){
        if(i%2==0){
            translate([0,0,i*h*0.9]) section();
        }else{
            translate([0,0,i*h*0.9]) mirror([1,0,0]) section();
        }
    }
}

//0-5
//6-11
