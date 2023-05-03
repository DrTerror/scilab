// ----------------------------------------------------------------------------
//
//  
//
//  @author afi
//  @date 2022.04.06
//
//  @version
//  20220406 / afi / first release.
//
//  @todo
//  [] 
//
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//  C L E A R

xdel();
clc();

// ----------------------------------------------------------------------------
//  V A R S

// debug&verbose
__IS_DEBUG = 0;
__IS_VERBOSE = 0;

conc_min = 0;
conc_max = 22;
conc_std = 20.95;

len_meas = 32.7;
len_offset = 8.5;
len_tot = len_meas+len_offset;
len_wo_v = 41.7;
len_w_v = 42.22;
len_avg = (len_wo_v+len_w_v)/2;

// ----------------------------------------------------------------------------
//  F U N C S
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//  linear function
function f = fnGenLinear(m,x,b)
    f = m*x+b;
endfunction // fnGenLinear

// ----------------------------------------------------------------------------
//  plot function
function retVal = fnPlot(xVectIn, dtIn, styleNr)
    yvi = 1;
    lenVect = length(xVectIn);
    lenDt = length(dtIn);
    
    if lenVect ~= lenDt then
        // ERROR
        mprintf("ERROR: length of vectIn (%d) is not equal to dtIn (%d)", lenVect, lenDt);
        retVal = 0;
        return;
    end

    for i = 1 : lenVect;
        xv = fnGenXVect(xVectIn(1, i), dtIn(1, i)/1000000);
        yv = fnGenYVect(i);
        plot2d(xv,yv,style=styleNr);
    end
    
    retVal = 1;
    
endfunction // fnPlot


// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------
//  M A I N
// ----------------------------------------------------------------------------
// ----------------------------------------------------------------------------

xgrid;

title("hsa calibration");
xlabel("conc [%]");
ylabel("len [mm]");

//legend('without vial','with vial','average');

if __IS_VERBOSE ~= 0 then
    mprintf("\n");
    mprintf("conc_min=%g\n", conc_min);
    mprintf("conc_max=%g\n", conc_max);
    mprintf("conc_std=%g\n", conc_std);
    mprintf("len_tot=%g (meas=%g, offset=%g)\n", len_tot, len_meas, len_meas);
    mprintf("len_wo_v=%g\n", len_wo_v);
    mprintf("len_w_v=%g\n", len_w_v);
    mprintf("len_avg=%g\n", len_avg);
end

// gen values
//x = [conc_min:1.0:conc_max];
x = linspace(conc_min,conc_max,10);
b = 0;
m_wo_v = len_wo_v/conc_std;
m_w_v = len_w_v/conc_std;
m_avg = len_avg/conc_std;

y_wo_v = fnGenLinear(m_wo_v,x,b);
y_w_v = fnGenLinear(m_w_v,x,b);
y_avg = fnGenLinear(m_avg,x,b);


// plot
plot(x,y_wo_v,'r');
plot(x,y_w_v,'g');
plot(x,y_avg,'b');

