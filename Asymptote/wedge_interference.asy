import animation;
import graph;

size(800);
settings.outformat="gif";
real framerate = 24;
animation A;

real theta = 10;
real theta_rad = theta/180*pi;
real lambda = 2;
real lcut = 2, rcut = 17;
real lthick = 1, rthick = 2.5;
real ybottom = -0.02;
real linc = lthick/tan(theta_rad), rinc = 2.5/tan(theta_rad);
real t;
real yref;
real h = 9.3;
real velocity = 1.3;

pair incwave_fun(real y){
    y = h - y;
    pair wave_point = (y, 0.2*sin(2*pi/lambda*(velocity*t-y)));
    return shift(0, h) * rotate(-90) * wave_point;
}

pair refwave_fun(real y){
    real y0 = 2 * yref - y;
    return shift(0, y-y0) * incwave_fun(y0);
}

for (int i = 24*0; i < 24*40; ++i){
    t = i / 24.;
    save();
    fill(box((-1,-1),(19,10)), black);
    draw((lcut,ybottom) -- (rcut,ybottom), white+1.2pt);
    draw((lcut,lcut*tan(theta_rad)) -- (rcut,rcut*tan(theta_rad)), white+1.2pt);

    real bwave_cut = max(h-t*velocity-lambda, 0);
    real uwave_cut = h-t*velocity;
    if (uwave_cut > 0){
        path inc_wave1 = shift(linc, 0) * graph(incwave_fun, bwave_cut, uwave_cut, n=500);
        draw(inc_wave1, yellow+dashed+1.5pt);
    }
    real brefwave_cut = lthick;
    yref = brefwave_cut;
    real urefwave_cut = min(t*velocity - (h - lthick -lambda) + lthick, h);
    if (urefwave_cut > brefwave_cut){
        path ref_wave1 = shift(linc, 0) * graph(refwave_fun, brefwave_cut, urefwave_cut, n=500);
        draw(ref_wave1, red+opacity(.5)+1.5pt);
    }
    real brefwave_cut1 = ybottom;
    yref = brefwave_cut1;
    real urefwave_cut1 = min(t*velocity - (h - ybottom -lambda) + ybottom, h);
    if (urefwave_cut1 > ybottom){
        path ref_wave2 = shift(linc, 0) * graph(refwave_fun, brefwave_cut1, urefwave_cut1, n=500);
        draw(ref_wave2, blue+opacity(.5)+1.5pt);
    }

    if (t > 13){
        real t1 = t - 13;
        bwave_cut = max(h-t1*velocity-lambda, 0);
        uwave_cut = h-t1*velocity;
        if (uwave_cut > 0){
            path inc_wave1 = shift(rinc, 0) * graph(incwave_fun, bwave_cut, uwave_cut, n=500);
            draw(inc_wave1, yellow+dashed+1.5pt);
        }
        brefwave_cut = rthick;
        yref = brefwave_cut;
        urefwave_cut = min(t1*velocity - (h - rthick -lambda) + rthick, h);
        if (urefwave_cut > brefwave_cut){
            path ref_wave1 = shift(rinc, 0) * graph(refwave_fun, brefwave_cut, urefwave_cut, n=500);
            draw(ref_wave1, red+opacity(.5)+1.5pt);
        }
        brefwave_cut1 = ybottom;
        yref = brefwave_cut1;
        urefwave_cut1 = min(t1*velocity - (h - ybottom -lambda) + ybottom, h);
        if (urefwave_cut1 > ybottom){
            path ref_wave2 = shift(rinc, 0) * graph(refwave_fun, brefwave_cut1, urefwave_cut1, n=500);
            draw(ref_wave2, blue+opacity(.5)+1.5pt);
        }
    }

    if (t > 28 && t < 32)
        ybottom = -(t - 28) * .25/2;


    A.add();
    restore();
}

A.movie(loops=0,
        delay=1000./framerate,
        options="-density 128x128"
);