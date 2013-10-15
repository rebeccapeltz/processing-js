//	Processing.js example sketch

int refreshTime = 300;
int maxIterations = 10;

void setup() {
    size(1200, 1200); 
    background(000); 
    stroke(#ffd700);
    noFill();
    smooth();
}
void drawRect(x,y,sidelen){
    rect(x,y,sidelen,sidelen);
}

void drawBez(x1, y1, cx1, cy1, cx2, cy2, x2, y2){
    bezier(x1, y1, cx1, cy1, cx2, cy2, x2, y2);
} 

void drawBezDown(x,y,sidelen){
    drawBez(x, y, x+12 ,y+sidelen ,x+sidelen , y+sidelen,  x+sidelen, y+sidelen);
}
void drawBezRight(x,y,sidelen){
     drawBez(x, y+sidelen, x, y+sidelen, x + sidelen-12,y+sidelen, x+sidelen, y)
}
void drawBezUp(x,y,sideLen){
    drawBez(x+sideLen, y+sideLen, x+sideLen, y+12, x, y, x, y)
}
void drawBezLeft(x, y, sideLen){
    drawBez(x+sideLen, y, x, y+12, x, y+sideLen, x, y+sideLen);
}
int sideLengthFun(scale, n){
    return (scale * phiFun(n));
} 
int phiFun(int n){
    int result = 0;
    if (n == 0){
        result = 0;
    } else if (n <=2){
        result = 1;
    } else {       
        long prev = 1, current = 1, next = 0;
        for (long i = 3; i <= n; i++) {
            next = prev + current;
            prev = current;
            current = next;
        }
        result =  next;
    }
    return result;
}

void draw() {
    int currentTime = millis();
    if (currentTime > 30000) return;
    int iterations = Math.min(maxIterations, (currentTime / refreshTime));
    //console.log("iterations = " + iterations + " currentTime = " + currentTime + " cT%rT= " + (currentTime / refreshTime));

    int SIDE_LENGTH = 9;
    //int iterations = 10;

    int centerX = (int)width/2;
    int centerY = (int)height/2;
    int startX = centerX - (int)SIDE_LENGTH/2;
    int startY = centerY - (int)SIDE_LENGTH/2;

    int x = startX;
    int y = startY;

    
    int maxX = x;
    int maxY = y;
    int minX = x;
    int minY = y;
    

    
    for (int n=1; n<=iterations; n++){
        int direction = n % 4; 
       // console.log(direction);
        if (direction == 1){ 
            //y0 = y;
            int sidelength =sideLengthFun(SIDE_LENGTH,n);
            x = minX;
            y = maxY;
            
            maxX = x + sidelength;
            maxY += sidelength;
            
            drawRect(x, y, sidelength);
            drawBezDown(x, y, sidelength)
            //console.log("D");
        } else if (direction == 2){
            //x0 = x;
            int sidelength = SIDE_LENGTH * phiFun(n);
            x = maxX;
            y = minY;
            
            maxX += sidelength; 
           
            drawRect(x, y, sidelength);
            drawBezRight(x, y, sidelength);
           
                   

            //console.log("R");
        } else if (direction == 3) {

            int sidelength = SIDE_LENGTH *  phiFun(n);
            
            minY -= sidelength;
            
            x= minX
            y = minY;

            drawRect(x, y, sidelength);
            drawBezUp(x, y, sidelength)

            //console.log("U");
        } else if (direction == 0) {
            //console.log("n=" + n + " phi="+phiFun(n));

            int sidelength = SIDE_LENGTH *  phiFun(n);
            
            minX -= sidelength;
            
            x = minX;
            y = minY;
            
            
            drawRect(x, y, sidelength);
            drawBezLeft(x, y, sidelength);

            //console.log("L");
        } else {
            //console.log("error");
        }
        
    }

 
}

