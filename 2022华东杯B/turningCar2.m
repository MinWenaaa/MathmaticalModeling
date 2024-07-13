function [x,y,wx1,wy1,wx2,wy2,wx3,wx4,wy4] = turningCar2(expr_angle_f, expr_v, time, delta)
% 根据前内轮转角和速度随时间的变化微积分推导运动轨迹
    f1 = str2func(['@(t)' expr_angle_f]);
    f2 = str2func(['@(t)' expr_v]);
    
    t = 0;
    x = [0,0];
    y = [0,0];
    wx1 = [-0.92,0];
    wy1 = [1.2,0];
    wx2 = [0.92,0];
    wy2 = [1.2,0];
    wx3 = [-0.92,0];
    wy3 = [-1.2,0];
    wx4 = [0.92,0];
    wy4 = [-1.2,0];
    angle_car = 0;
    index=1;
    while t<time
        R_rear = 2.4/tand(f1(t));
        R = sqrt((0.92+R_rear)^2+1.2^2);
        R2 = R_rear+1.84;
        R3 = sqrt(R_rear^2 + 2.4^2);
        R4 = sqrt((R_rear+1.84)^2+2.4^2);
        O = [x(index)-1.2*sind(angle_car)+(R_rear+0.92)*cosd(angle_car), y(index)-1.2*cosd(angle_car)-(R_rear+0.92)*sind(angle_car)];
        w = f2(t)*180/(R*3.14);
        angle_car = angle_car+w*delta;
        angle_v = angle_car+atand(1.2/(0.92+R_rear));
        x(index+1) = x(index)+f2(t)*sind(angle_v)*delta;
        y(index+1) = y(index)+f2(t)*cosd(angle_v)*delta;
        wx1(index+1) = x(index+1)+1.2*sind(angle_car)-0.92*cosd(angle_car);
        wy1(index+1) = y(index+1)+1.2*cosd(angle_car)+0.92*sind(angle_car);
        wx2(index+1) = x(index+1)+1.2*sind(angle_car)+0.92*cosd(angle_car);
        wy2(index+1) = y(index+1)+1.2*cosd(angle_car)-0.92*sind(angle_car);
        wx3(index+1) = x(index+1)-1.2*sind(angle_car)+0.92*cosd(angle_car);
        wy3(index+1) = y(index+1)-1.2*cosd(angle_car)-0.92*sind(angle_car);
        wx4(index+1) = x(index+1)-1.2*sind(angle_car)-0.92*cosd(angle_car);
        wy4(index+1) = y(index+1)-1.2*cosd(angle_car)+0.92*sind(angle_car);
        index = index+1;
        t = t + delta;
    end
    i = 0:0.1:5;
    % i,x,y
    % result = [i;x;y];% wx1;wy1;wx2;wy2;wx3;wy3;wx4;wy4];
    
    % writematrix(result', 'verify.csv');
    plot(x,y,'*k',wx1,wy1,'*k',wx2,wy2,'*k',wx3,wy3,'*k',wx4,wy4,'*k');
    axis equal;
end