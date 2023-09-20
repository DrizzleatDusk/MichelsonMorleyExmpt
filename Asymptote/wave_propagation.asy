import animation;
import graph;

size(1000);
settings.outformat="gif";
real framerate = 24;
animation A;

real amp = 2;
real r = .06 * amp;
real T = 2;
real t;
real velocity = 1;
real omega = 2 * pi / T;
real l = 10;
real arrowl = .05 * l;
path stringpath;

real shape(real x){
    real abs_x = abs(x);
    if (abs_x < t*velocity){
        return amp * sin(omega*(t - abs_x/velocity));
    }
    return 0;
}

for (int i = 0; i < 24*10; ++i){
    save();
    t = i / framerate;
    fill(box((-1.2*l,-1.5*amp), (1.2*l,1.5*amp)), black+opacity(0));
    stringpath = graph(shape, -l, l, n=1000);
    draw(stringpath, yellow+2pt);
    fill(circle((0, shape(0)), r), red);
    draw((t*velocity-arrowl,1.1*amp) -- (t*velocity+arrowl,1.1*amp), arrow=Arrow(), white+linewidth(3pt));
    draw((-t*velocity+arrowl,1.1*amp) -- (-t*velocity-arrowl,1.1*amp), arrow=Arrow(), white+linewidth(3pt));
    A.add();
    restore();
}

A.movie(loops=1,
        delay=1000./framerate,
        options="-density 256x256"
);