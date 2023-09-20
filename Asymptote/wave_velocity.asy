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
real velocity = 1.2;
real ovelocity = 0.8;
real omega = 2 * pi / T;
real llength = 4;
real rlength = 16;
real l = llength + rlength;
real hpar = 4;
path stringpath;

real shape1(real x){
    real abs_x = abs(x);
    if (abs_x < t*velocity){
        return amp * sin(omega*(t - abs_x/velocity)) + hpar;
    }
    return hpar;
}

real shape2(real x){
    real abs_x = abs(x);
    real omega_;
    if (abs_x < t*velocity){
        if (x > t*ovelocity)
            omega_ = omega * velocity / (velocity - ovelocity);
        else
            omega_ = omega * velocity / (velocity + ovelocity);
        if (x < 0 || x > t*ovelocity)
            return amp * sin(omega_*(t - abs_x/velocity)) - hpar;
        else
            return amp * sin(omega_*(t + abs_x/velocity)) - hpar;
    }
    return -hpar;
}

for (int i = 0; i < 24*13; ++i){
    save();
    t = i / framerate;
    fill(box((-1.2*llength,-4*amp), (1.2*rlength,4*amp)), black+opacity(0));
    stringpath = graph(shape1, -llength, rlength, n=1000);
    draw(stringpath, yellow+2pt);
    fill(circle((0, shape1(0)), r), red);
    //draw((t*velocity-arrowl,1.1*amp) -- (t*velocity+arrowl,1.1*amp), arrow=Arrow(), white+linewidth(3pt));
    //draw((-t*velocity+arrowl,1.1*amp) -- (-t*velocity-arrowl,1.1*amp), arrow=Arrow(), white+linewidth(3pt));
    stringpath = graph(shape2, -llength, rlength, n=1000);
    draw(stringpath, yellow+2pt);
    fill(circle((t*ovelocity, amp * sin(omega*(t)) - hpar), r), red);
    if (t > 6){
        fill(circle((0, 1.5*amp - hpar), r), white);
        fill(circle((t*velocity, -1.5*amp - hpar), r), white);
    }
    A.add();
    restore();
}

A.movie(loops=1,
        delay=1000./framerate,
        options="-density 256x256"
);