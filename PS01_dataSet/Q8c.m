% (c) Using TF-IDF to find min Euclidean distance
clc;clear;
load 'wordVecV.mat'
min_euc_dist = 1000;

for i = 1:9
    w_1 = find_w(i);
    
    for j = (i+1):10
        w_2 = find_w(j);
        curr_euc_dist = norm(w_1-w_2);
        if curr_euc_dist < min_euc_dist
            min_euc_dist = curr_euc_dist;
            min_euc_pair = [i j];
        end
    end
end

disp(min_euc_pair)  % articles 9 and 10 have the closest euclidean distance


%(d) Reason for using the 'inverse document frequency' adjustment

% The inverse adjustment multiplies the normalized vectors by a factor 
% between zero and one. If a word appears in all 10 articles, the factor is
% 0. If a word appears in only 1 article, the factor is 1. 

% If a word appears in different articles, the factor makes its score
% smaller. This way, if a word is unique to an article, it gets a higher
% score, whereas the most common words are given low scores. 

% By looking at the TF-IDF, we can find a set of distinctive words: 
% these words will appear frequently in a given article, while rarely 
% appearing in other articles.

