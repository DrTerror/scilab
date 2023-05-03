// Second example: draw 3 bars (i.e 3 polylines with polyline_style type =6),default style='grouped'

clf(1);
scf(1);

//x=[1  2 3];
//y=[1 -5 6;
//   3 -2 7;
//   4 -3 8];

// plot horizontal bars
//barh(x,y, 'stacked');


Positions=[1,2,3,4];
Gap_Duration=[0,2,5,3,5,3;
              3,5,3,5,3,4;
              9,3,0,0,12,2;
              13,2,2,2,8,3];
              

H = barh(Positions,Gap_Duration,'stacked');

set(H([1 3 5]),'Visible','off');
