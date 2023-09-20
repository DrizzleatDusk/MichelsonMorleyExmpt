import animation;
import graph;

size(800);
settings.outformat="gif";
animation A;
real framerate = 24;
real t;
real r = .15;
real T = 6;
real L = 14;
real l = 8.5;
real v = L / T;
real c = (l + sqrt(l*l + T*T*v*v)) / T;

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

real draw_ifo(pair pbase){
    pair pstart = pbase;
    pair pend = pbase + (3, 3);
    draw_spliter(pstart, pend);

    pair pstart1 = pstart + (l + 1.5, 3);
    pair pend1 = pstart1 - (0, 3);
    draw_mirror(pstart1, pend1, 15, .2);

    pair pstart2 = pstart + (0, l + 1.5);
    pair pend2 = pstart2 + (3, 0);
    draw_mirror(pstart2, pend2, 15, .2);
    return pstart1.x;
}

pair pbase;
real xball = 15.5;
bool collision = false;

for (int i = 24*0; i < 24*16; ++i){
    t = i / 24.;
    save();
    fill(box((-2,-2), (25,11)), black);
    if (t < 6){
        pbase = (14, 0);
        xball = 15.5;
    }
    else 
        pbase = (14 - (t - 6) * v, 0);
    if (pbase.x < 0)
        pbase = (0, 0);
    if (xball > draw_ifo(pbase))
        collision = true;
    fill(circle((xball, 1.5), r), blue);
    if (! collision)
        xball += c / framerate;
    else
        xball -= c / framerate;
    if (xball < 1.5)
        xball = 1.5;

    A.add();
    restore();
}

A.movie(loops=0,
        delay=1000./framerate,
        options="-density 128x128"
);