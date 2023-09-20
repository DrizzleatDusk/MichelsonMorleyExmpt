import animation;
import graph;

size(800);
settings.outformat="gif";
real framerate = 24;
real t;
real velocity = 1.5;
real r = .15;
real yellow_x = -2;
real blue_x = 9.5;
real red_y = 1.5;
animation A;

void draw_spliter(pair pstart, pair pend){
    draw(pstart -- pend, white+2.5pt);
}

void draw_mirror(pair pstart, pair pend, int ndash, real ldash, bool isreal=true){
    pen thispen;
    if (isreal)
        thispen = white+1.5pt;
    else
        thispen = white+dashed+1pt;
    draw(pstart -- pend, p=thispen);

    pair dashstart, dashend;
    pair direction = pend - pstart;
    pair dash_direction = rotate(45) * direction;
    dash_direction = dash_direction / length(dash_direction) * ldash;
    for(int i = 0; i < ndash; ++i){
        pair dashstart = pstart + .05*direction + i * .95 * direction / ndash;
        pair dashend = dashstart + dash_direction;
        draw(dashstart -- dashend, thispen);
    }
}

real red_y_;
real blue_x_, blue_y_ = 1.5 + velocity/framerate, image_blue_y_;

for (int i = 24*0; i < 24*23; ++i){
    t = i / 24.;
    save();
    fill(box((-2.5,-2), (20,12)), black);

    if (yellow_x < 9.5){
        fill(circle((yellow_x, 1.5), r), yellow);
        yellow_x += velocity  / framerate;
    }
    else{
        // draw red ball.
        if (red_y <= 10)
            red_y_ = red_y;
        else
            red_y_ =  20 - red_y;

        if (red_y_ > -1)
            fill(circle((9.5,red_y_), r), red);
        red_y += velocity / framerate;
        // draw blue ball.
        if (blue_x <= 19)
            blue_x_ = blue_x;
        else if (blue_x > 19 && blue_x <= 28.5)
            blue_x_ = 38 - blue_x;
        else{
            blue_x_ = 9.5;
            blue_y_ -= velocity / framerate;
        }
        
        if (blue_y_ > -1)
            fill(circle((blue_x_,blue_y_), r), blue);
        blue_x += velocity / framerate;
        // draw image of blue ball.
        if (t > 13){
            if (blue_x <= 28.5){
                image_blue_y_ = 1.5 + blue_x_ - 9.5;
                draw(circle((9.5,image_blue_y_), r), blue+dashed+1.2pt);
            }
            
            draw_mirror((8,11), (11,11), 15, .2, false);
        }
    }

    draw_spliter((8,0), (11,3));
    draw_mirror((19,3), (19,0), 15, .2);
    draw_mirror((8,10), (11,10), 15, .2);
    draw((8,-1.1) -- (11,-1.1), white+1.2pt);

    A.add();
    restore();
}

A.movie(loops=0,
        delay=1000./framerate,
        options="-density 128x128"
);