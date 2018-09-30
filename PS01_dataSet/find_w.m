function [w] = find_w(index)
% find the term frequency-inverse document frequency score
% for article of a given index
load 'wordVecV.mat' V

v_1 = V(:,index);
v_1n = v_1/sum(v_1);
f_doc = zeros(size(v_1));
for i = 1:length(v_1)
    f_doc(i)=0;
    for j = 1:10
        if V(i,j) ~= 0
            f_doc(i)= f_doc(i)+1;
        end
    end
    f_doc(i)=10/f_doc(i);
end
w = v_1n .* sqrt(log(f_doc));
end

