clc;clear;
syms x
e = sym(zeros(6,1)); % orthonormal basis
v = [1,x,x^2,x^3,x^4,x^5]; % given basis
e(1) = sym(1/sqrt(2*pi));

% (a) Compute the orthonormal basis
disp(strcat('e(0) is ',string(e(1))))
for i = (2:6)
    U = v(i);
    for j = 1:(i-1)
        U = U - int(sym(e(j)*v(i)),[-pi pi])*e(j);
    end
    e(i)= U/ sqrt(int(U^2,[-pi pi]));
    disp(strcat('e(',string(i-1),') is',string(e(i))))
end

mat = sym(zeros(6,6));
for k = (1:6)
    for h = (1:6)
        mat(k,h) = int(v(k)*v(h),[-pi pi]);
    end
end

res = sym(zeros(6,1));
for k = (1:6)
    res(k) = int(sin(x)*v(k),[-pi pi]);
end

alpha = double(mat\res) % (b) find alpha coefficients

% (c) Because the even coefficients are equal to zero,
% the even functions x^0, x^2, x^4 are eliminated
% this makes sense intuitively because sine is an odd function


% (d) Compare approximations 
figure
x = linspace(-2*pi,2*pi,1000);
y1 = sin(x);
y2 = x - x.^3/factorial(3)+x.^5/factorial(5);
y3 = alpha(2)*x+alpha(4)*x.^3+alpha(6)*x.^5;

plot(x,y1,'LineWidth',2);
hold on;
plot(x,y2,'LineWidth',2);
plot(x,y3,'LineWidth',2);
legend('sin(x)','5th degree Taylor approximation','Approximation via projection','FontSize',12)
axis([-2*pi 2*pi -2 2])
xlabel('x','FontSize',12)
xticks(linspace(-2*pi,2*pi,9))
xticklabels({'-2pi','-1.5pi','-pi','-0.5pi','0','0.5pi','pi','1.5pi','2pi'})
grid on
