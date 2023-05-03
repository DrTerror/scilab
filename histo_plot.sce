// ----------------------------------------------------------------------------
//
//  display strobe timings
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

//xdel();
clc();
//figNo = 1;
//clf(figNo);

// ----------------------------------------------------------------------------
//  V A R S

// debug & verbose & tests
isDebug = 0;
isVerbose = 0;
dbgTestNr = 1;

// ----------------------------------------------------------------------------

// delta x bzw t [us]
delta_ts = [18,18,300,200,200,340,18,18];

// x werte [s]
vials=[
        0.39,0.51,0.9675,0.985,1.44,1.46,1.915,2.027; // vial 1
        0.54,0.66,1.1175,1.135,1.59,1.61,2.065,2.177; // vial 2
        0.69,0.81,1.2675,1.285,1.74,1.76,2.215,2.327; // ...
        0.84,0.96,1.4175,1.435,1.89,1.91,2.365,2.477;
        0.99,1.11,1.5675,1.585,2.04,2.06,2.515,2.627;
        1.14,1.26,1.7175,1.735,2.19,2.21,2.665,2.777;
        1.29,1.41,1.8675,1.885,2.34,2.36,2.815,2.927;
        1.44,1.56,2.0175,2.035,2.49,2.51,2.965,3.077;
        1.59,1.71,2.1675,2.185,2.64,2.66,3.115,3.227  // vial 9
      ];

// ----------------------------------------------------------------------------
//  F U N C S
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
//  generate [1x4] x vector
function [retVect] = fnGenXVect(xValIn, dtIn)
    retVect=[xValIn, xValIn, xValIn+dtIn, xValIn+dtIn];
endfunction // fnGenXVect

// ----------------------------------------------------------------------------
//  generate [1x4] y vector
//  [0, index, index, 0]
function [retVect] = fnGenYVect(vIndex)
    retVect=[0, vIndex, vIndex, 0];
endfunction // fnGenYVect

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

// ----------------------------------------------------------------------------
//  T E S T S

if isDebug ~= 0 then
    
    if dbgTestNr == 1 then
        mprintf("len=%d", length(vials));
        [nr, nc] = size(vials);
        mprintf("size: %dx%d", nr,nc);
        abort;
    end
    
    if dbgTestNr == 2 then
        j = 1;
        for i = delta_ts
            disp(j);
            disp(vial1(1,j));
            disp(delta_ts(1,j));
            j = j + 1;
        end
        abort;
    end
    
    if dbgTestNr == 3 then
        x=[0 : 0.1 : 2*%pi];
        plot2d(sin(x), style = 2);
        abort;
    end
    
    if dbgTestNr == 4 then
        t = [0 : 0.1 : 4];
        x = feval(t, fnF1);
        plot2d(x);
        abort;
    end
    
    if dbgTestNr == 5 then
        abort;
    end
    
end // isDebug


// ----------------------------------------------------------------------------
//  P L O T 

//scf(figNo);
title("PHS strobe timings");
xlabel("time [s]");
ylabel("strobe number");


// ----------------------------------------------------------------------------
// generic plotting
[rows, cols] = size(vials);
for vi = 1 : rows
    fnPlot(vials(vi,:), delta_ts, vi);
end
