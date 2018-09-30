% (b) Calculate Euclidean distance between articles after normalization
clc;clear;
load 'wordVecV.mat'
min_euc_dist = norm(V(:,1)-V(:,2));
for i = 1:9
    v_1 = V(:,i);
    v_1n = v_1/sum(v_1);
    for j = (i+1):10
        v_2 = V(:,j);
        v_2n = v_2/sum(v_2);
        curr_euc_dist = norm(v_1n-v_2n);
        if curr_euc_dist < min_euc_dist
            min_euc_dist = curr_euc_dist;
            min_euc_pair = [i j];
        end
    end
end

disp(min_euc_pair)  % articles 9 and 10 have the closest euclidean distance

min_ang_dist = acosd(dot(V(:,1),V(:,2))/(norm(V(:,1))*norm(V(:,2))));
for i = 1:9
    v_1 = V(:,i);
    v_1n = v_1/sum(v_1);
    for j = (i+1):10
        v_2 = V(:,j);
        v_2n = v_2/sum(v_2);
        curr_ang_dist = acosd(dot(v_1n,v_2n)/(norm(v_1n)*norm(v_2n)));
        if curr_ang_dist < min_ang_dist
            min_ang_dist = curr_ang_dist;
            min_ang_pair = [i j];
        end
    end
end

disp(min_ang_pair)  % articles 9 and 10 have the closest angle distance

% We get a different answer compared to part (a). Now articles 9 and 10
% have the smallest euclidean distance and the smallest angle distance.
% The normalization divides the term frequency by the article length. This
% way, the normalized term frequencies have much smaller magnitudes, so
% they don't skew the euclidean distance as much. As a result, we get the
% same pair for both smallest distances.