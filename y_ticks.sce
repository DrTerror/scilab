clf(2);
scf(2);


YL=[0;1];
TL=["zero";"one"];

//colorbar(cmin,cmax,,fmt="%.0f");

cb = gce();
cb.font_size = 4;
cb.auto_ticks(2)="off";
cb.y_ticks = tlist(["ticks","locations","labels"], YL, TL);
