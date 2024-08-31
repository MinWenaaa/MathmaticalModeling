function diff_sum = diff_sum(targets, monitors)
    num_1 = size(targets, 1);
    num_2 = size(monitors, 1);

    diff_sum = zeros(num_1, 1);

    for i=1:num_1
        for j=1:num_2
            diff_sum(i) = diff_sum(i) + diff_sq(targets(i, :), monitors(j, :));
        end
    end

    return 

end

function diff_sq = diff_sq(target, monitor)
% 根据音爆位置和监视器位置求出时间差的平方
    d = sqrt(((target(1)-monitor(1))*97304)^2 + ((target(2)-monitor(2))*111263)^2 + (target(3)-monitor(3))^2);
    diff_sq = (d/340 + target(4) - monitor(4))^2;
    return 

end