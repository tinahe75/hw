x=[3;2];
v0=[-2;-4];
v=[-2;5];
% (d) verify y(2) calculated in part (b)
[y2, r2] = proj_cvx (x, v0 , v, 2); 
disp(y2) %% output [-3.3793; -0.5517] matches answer in (b)

%(e) find y(1) and y(?)
[y1, r1] = proj_cvx (x, v0 , v, 1); 
disp(y1)  %% output is [-4.4000;2.0000]

[y_inf, r_inf] = proj_cvx (x, v0 , v, Inf); 
disp(y_inf)  %% output is [-2.2857;-3.2857]




