
    float myAngle = -90; // degree measurement
    color[] palette = new color[257];
    int chc=0;
    int angle=3;
    int bby = 40;
    int bbx = 100;
    int h=0;
    boolean match=false;
    boolean match1=false;
    int[][][] data2 = new int[bby][bbx][bby];//x.y
    boolean darkness=false;
    void setup() {
        // 3D requires P3D or OPENGL as a parameter to size()
        size(600, 600, P3D);
        int h = color(22, 22, 22);
        for (int x = 0; x < 256; x++) {
            float saturation = x > 96 ? 0 : 1f - x / 128f;
            palette[x] = toRGB(x / 576f, saturation, Math.min(1f, x / 48f));
            if (palette[x] < h) {
                palette[x] = h;
            }
        }
        for (int x = 0; x < bby; x++) {
            for (int z = 0; z < bby; z++) {
                data2[x][bbx - 2][z] = Math.random() > 0.55 ? 0 : 255;
            }
        }
    }

    void draw() {
        // repeated continously
        background(22);
        // switch on lights  
        lights();
        pushMatrix();
        translate(258, 448, -10);
        rotateY(radians(myAngle));
        fill(color(2, 2, 222)); // green
        box(40); // only one parameter: box(size)
        popMatrix();
        pushMatrix();
        translate(258, 408, -10);
        rotateY(radians(myAngle));
        fill(color(2, 2, 222)); // green
        box(40); // only one parameter: box(size)
        popMatrix();
        for (int y = 5; y < bbx - 2; y++) {
            for (int x = 5; x < bby - 2; x++) {
                for (int z = 5; z < bby - 2; z++) {
                    data2[x][y][z] = ((int) ((int) ((data2[x][y][z] + data2[x][y + 1][z] + data2[x - 1][y + 1][z] + data2[x + 1][y + 1][z] + data2[x][y + 2][z]) / 5.045) * 1.01) + (int) ((int) ((data2[x][y][z] + data2[x][y + 1][z] + data2[x][y + 1][z - 1] + data2[x][y + 1][z + 1] + data2[x][y + 2][z]) / 5.045) * 1.01)) / 2;
                }
            }
        }
        
        if (match){
            match=false;
            match1=true;
  
        }
        if (match1){
          palette[256]=color(2,222,0);
         int y1=(bby/2)-15;
                           for (int y = h; y < (40+h); y = y + 2) {
                    for (int x = y1; x < (y1+30); x = x + 2) {
                        for (int z = y1; z <(y1+30); z = z + 2) {
                           
                            data2[x][y][z]=(256); // green
                           
                        }
                    }
                }
                h++;
         if (h>40){
          h=0;
          match1=false;
         }
        }

        
        if (darkness){
          
                  for (int y = 0; y < bbx; y = y + 2) {
            for (int x = 0; x < bby; x = x + 2) {
                for (int z = 0; z < bby; z = z + 2) {
                    pushMatrix();
                    stroke(palette[0]); // green
                    int xy[] = rotateAcross(238 + x, z - 10, 258, 10, -radians(myAngle));
                    point(xy[0], 288 + y, xy[1]);
                    popMatrix();
                }
            }
        }
        } else{
                  for (int y = 0; y < bbx; y = y + 2) {
            for (int x = 0; x < bby; x = x + 2) {
                for (int z = 0; z < bby; z = z + 2) {
                    pushMatrix();
                    stroke(palette[data2[x][y][z]]); // green
                    int xy[] = rotateAcross(238 + x, z - 10, 258, 10, -radians(myAngle));
                    point(xy[0], 288 + y, xy[1]);
                    popMatrix();
                }
            }
        }
    }

        myAngle += angle; // speed
        if (myAngle >= 360) {
            myAngle = 0; // keep in degree
        }
        //
                for (int x = 0; x < bby; x++) {
            for (int z = 0; z < bby; z++) {
                data2[x][bbx - 2][z] = Math.random() > 0.55 ? 0 : 255;
            }
        }
    }

    void keyPressed() {
        if (keyCode == LEFT) {
            myAngle += 3;
        }
        if (keyCode == RIGHT) {
            myAngle -= 3;
        }
    }

    color toRGB(float h, float s, float v) {
        float r = 0;
        float g = 0;
        float b = 0;
        int i = ((int) Math.floor(h * 6));
        float f = h * 6 - i;
        float p = v * (1 - s);
        float q = v * (1 - f * s);
        float t = v * (1 - (1 - f) * s);
        switch (i % 6) {
            case 0:
                r = v;
                g = t;
                b = p;
                break;
            case 1:
                r = q;
                g = v;
                b = p;
                break;
            case 2:
                r = p;
                g = v;
                b = t;
                break;
            case 3:
                r = p;
                g = q;
                b = v;
                break;
            case 4:
                r = t;
                g = p;
                b = v;
                break;
            case 5:
                r = v;
                g = p;
                b = q;
                break;
        }
        return color(Math.round(r * 255), Math.round(g * 255), Math.round(b * 255));
    }
void mouseClicked(){
  chc++;
  if (chc>4){
  chc=0;
  }
  switch(chc){
    case 0: angle=3;darkness=false;break;
    case 1: angle=0;darkness=false;break;
    case 2: angle=3;darkness=true;  break;
    case 3: angle=3;darkness=false; match=true;  break;
  }  
 
}
    int[] rotateAcross(float px, float py, float ox, float oy, float theta) {
        int[] res = new int[2];
        res[0] = (int) (cos(theta) * (px - ox) - sin(theta) * (py - oy) + ox);
        res[1] = (int) (sin(theta) * (px - ox) + cos(theta) * (py - oy) + oy);
        return res;
    }
