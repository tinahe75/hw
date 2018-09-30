function [] = plot_approx(num_vect,time_pos,sq_wave,B_norm,C)
% plots approximation using the orthonormal basis
% using the first 'num_vect' vectors
% B_norm is the orthonormal basis, C contains the coefficients
approx = zeros(size(B_norm(1,:)));
for i =(1:num_vect)
    approx = approx + B_norm(i,:);
end
plot(time_pos,approx,'r','LineWidth',2)
hold on;
plot(time_pos,sq_wave,'b--','LineWidth',1)
hold off;
title(strcat('Approx using first ',{' '},string(num_vect),{' '},'basis vector(s)'))
xlabel('time')
end

