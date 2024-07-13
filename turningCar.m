function [x,y] = turningCar(front_angle, v)
% 根据前内轮转角和速度绘制运动轨迹
    a = 0
    % 后轮运动半径
    R_rear = 2.4/tand(front_angle)
    % 圆心坐标：以初始质心为原点，初始车辆纵轴为y轴
    O = [R_rear+0.92, -1.2];
    R = sqrt(O(1)^2 + O(2)^2);
    R2 = R_rear+1.84;
    R3 = sqrt(R_rear^2 + 2.4^2);
    R4 = sqrt((R_rear+1.84)^2+2.4^2);
    phi = atan(O(2)/O(1));

    i = 0:0.1:5;

    x = O(1)+R* cos(-i*v/R+phi+pi);
    y = O(2)+R* sin(-i*v/R+phi+pi);
    wx1 = O(1)+R_rear* cos(-i*v/R+phi+pi);
    wy1 = O(2)+R_rear* sin(-i*v/R+phi+pi);
    wx2 = O(1)+R2* cos(-i*v/R+phi+pi);
    wy2 = O(2)+R2* sin(-i*v/R+phi+pi);
    wx3 = O(1)+R3* cos(-i*v/R+phi+pi);
    wy3 = O(2)+R3* sin(-i*v/R+phi+pi);
    wx4 = O(1)+R4* cos(-i*v/R+phi+pi);
    wy4 = O(2)+R4* sin(-i*v/R+phi+pi);

    result = [i;x;y];%wx1;wy1;wx2;wy2;wx3;wy3;wx4;wy4];
    
    writematrix(result', 'model_trajectories.csv');
    plot(x, y);% wx1, wy1, wx2, wy2, wx3, wy3, wx4, wy4);
    axis equal;
    legend('汽车质心');% , '后内轮', '后外轮', '前内轮', '前外轮');
end
