% Making a small, artificial system, look at how refpoint optimizer works
clear

grd = cell(2,1);
Vx = grd;
Vy = grd;
Vt = grd;

% XY grid
[grd{1}, grd{2}] = ndgrid(-1:1, -1:1);
% Vector fields
Vx{1} = -grd{2};
Vx{2} = grd{1};
Vy{1} = -grd{2};
Vy{2} = -grd{1};
Vt{1} = grd{1}+.5;
Vt{2} = grd{2}+.5;

% Apply Hodge-Helmholtz
[gradBt, Bt] = helmholtz(grd,Vt);
[gradBx, gradBy, Bx, By] = ref_point_optimizer(grd,Vx,Vy,Vt);


%%% PLOT STUFF %%%
figure(1)
clf
subplot(3,3,1)
quiver(grd{1},grd{2}, Vx{1},Vx{2})
subplot(3,3,2)
quiver(grd{1},grd{2}, gradBx{1},gradBx{2})
subplot(3,3,3)
quiver(grd{1},grd{2}, Vx{1}-gradBx{1},Vx{2}-gradBx{2})
subplot(3,3,4)
quiver(grd{1},grd{2}, Vy{1},Vy{2})
subplot(3,3,5)
quiver(grd{1},grd{2}, gradBy{1},gradBy{2})
subplot(3,3,6)
quiver(grd{1},grd{2}, Vy{1}-gradBy{1},Vy{2}-gradBy{2})
subplot(3,3,7)
quiver(grd{1},grd{2}, Vt{1},Vt{2})
subplot(3,3,8)
quiver(grd{1},grd{2}, gradBt{1},gradBt{2})
subplot(3,3,9)
quiver(grd{1},grd{2}, Vt{1}-gradBt{1},Vt{2}-gradBt{2})

figure(2)
clf
subplot(1,3,1)
h = surf(grd{1},grd{2},Bx)
shading interp
set(h,'edgecolor','k')
subplot(1,3,2)
h = surf(grd{1},grd{2},By)
shading interp
set(h,'edgecolor','k')
subplot(1,3,3)
h = surf(grd{1},grd{2},Bt)
shading interp
set(h,'edgecolor','k')