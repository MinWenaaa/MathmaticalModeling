function [max,min] = max_angle(start)
% 根据初始位置计算最大转角与最小转角
    syms x
    eqn = sqrt((2.4/tand(x)+1.92)^2+3.2^2)-1.2 == 6.8-start;
    max = double(solve(eqn, x));
    if start>=2
        min = 90;
    else
        syms x
        eqn = (2.4/tand(x)+0.92-1.4)^2 + (start-1.2)^2 == (2.4/tand(x)+0.92-1)^2 + (0.8)^2;
        min = double(solve(eqn, x));
    end
end