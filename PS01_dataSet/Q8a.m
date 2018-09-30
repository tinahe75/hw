% (a) Calculate Euclidean distance between articles
clc;clear;
load 'wordVecV.mat'
min_euc_dist = norm(V(:,1)-V(:,2));
for i = 1:9
    v_1 = V(:,i);
    for j = (i+1):10
        v_2 = V(:,j);
        curr_euc_dist = norm(v_1-v_2);
        if curr_euc_dist < min_euc_dist
            min_euc_dist = curr_euc_dist;
            min_euc_pair = [i j];
        end
    end
end

disp(min_euc_pair)   % articles 7 and 8 have the closest euclidean distance

min_ang_dist = acosd(dot(V(:,1),V(:,2))/(norm(V(:,1))*norm(V(:,2))));
for i = 1:9
    v_1 = V(:,i);
    for j = (i+1):10
        v_2 = V(:,j);
        curr_ang_dist = acosd(dot(v_1,v_2)/(norm(v_1)*norm(v_2)));
        if curr_ang_dist < min_ang_dist
            min_ang_dist = curr_ang_dist;
            min_ang_pair = [i j];
        end
    end
end

disp(min_ang_pair)  % articles 9 and 10 have the closest angle distance

% We get different pairs for closest Euclidean and angle distances, because
% there is no normalization.
% For example, if we have two vectors with a small angle in between, but 
% one of them has a much larger magnitude, the Euclidean distance will be a
% lot larger than the angle distance. 
% This means that out of all the articles, articles 9 and 10 likely have
% the most number of shared words (i.e. a given word appears in both 
% articles).
% The Euclidean distance takes into account the term frequency, 
% so the result is different.