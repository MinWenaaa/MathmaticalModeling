function [child1, child2] = hybird(parent1,parent2)
%杂交

    child1 = parent1;
    child2 = parent2;

    % 杂交,交换3个片段
    random = sort(randi([1, 62], 1, 6));
    for i=1:3
        temp = child1(random(i*2-1):random(i*2), :);
        child1(random(i*2-1):random(i*2), :) = child2(random(i*2-1):random(i*2), :);
        child2(random(i*2-1):random(i*2), :) = temp;
    end

    % 变异，随机3个点发生偏移
    random = -50 + 100*rand(1, 6);
    for i=1:3
        random_i = randi([2,30], 1);
        child1(random_i,:) = child1(random_i, :) + random(i*2-1:i*2);
        child1(63-random_i,:) = child1(63-random_i, :) - random(i*2-1:i*2);
        child2(31-random_i,:) = child2(31-random_i, :) + random(i*2-1:i*2);
        child2(31+random_i,:) = child2(31+-random_i, :) - random(i*2-1:i*2);
    end

    return
end