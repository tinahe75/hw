clc;clear;
[time_pos, sq_wave, B_unnorm] = generate_data;
% a) plot the square wave
figure
hold on
plot(time_pos,sq_wave,'LineWidth',2)
hold off
pbaspect([1 1 1])
xlabel('time')
title('Plot of square wave signal')

% b) plot the basis vectors
figure
subplot(7,1,1)
plot(time_pos,B_unnorm(1,:))
title('Plot of 1st basis vector')
xlabel('time')

subplot(7,1,2)
plot(time_pos,B_unnorm(2,:))
title('Plot of 2nd basis vector')
xlabel('time')

subplot(7,1,3)
plot(time_pos,B_unnorm(3,:))
title('Plot of 3rd basis vector')
xlabel('time')

subplot(7,1,4)
plot(time_pos,B_unnorm(4,:))
title('Plot of 4rd basis vector')
xlabel('time')

subplot(7,1,5)
plot(time_pos,B_unnorm(5,:))
title('Plot of 5th basis vector')
xlabel('time')

subplot(7,1,6)
plot(time_pos,B_unnorm(6,:))
title('Plot of 6th basis vector')
xlabel('time')

subplot(7,1,7)
plot(time_pos,B_unnorm(30,:))
xlabel('time')
title('Plot of 30th basis vector')

% test orthogonality
res = 0;
for i=(1:29)
    for j = (i+1:30)
        if abs(dot(B_unnorm(i,:),B_unnorm(j,:))) > 1e-9 
            % this accounts for rounding errors          
            res = res +1;
        end
    end
end
if res ==0  
    disp('all basis vectors are orthogonal')
end
 

% c) Orthonormal basis

B_norm = zeros(size(B_unnorm));
C = zeros(30,1);  % vector containing coefficients
for k = (1:30)
    vect_normalized = B_unnorm(k,:)/norm(B_unnorm(k,:));
    C(k,1) = dot(sq_wave,vect_normalized)/ norm(B_unnorm(k,:));
    B_norm(k,:)=  C(k,1)* B_unnorm(k,:);
end

% Projection coefficients are already in descending order

% plot approximations
figure()
subplot(7,1,1)
plot_approx(1,time_pos,sq_wave,B_norm,C);

subplot(7,1,2)
plot_approx(2,time_pos,sq_wave,B_norm,C);

subplot(7,1,3)
plot_approx(3,time_pos,sq_wave,B_norm,C);

subplot(7,1,4)
plot_approx(4,time_pos,sq_wave,B_norm,C);

subplot(7,1,5)
plot_approx(5,time_pos,sq_wave,B_norm,C);

subplot(7,1,6)
plot_approx(6,time_pos,sq_wave,B_norm,C);

subplot(7,1,7)
plot_approx(30,time_pos,sq_wave,B_norm,C);

legend('approximation','square wave signal')