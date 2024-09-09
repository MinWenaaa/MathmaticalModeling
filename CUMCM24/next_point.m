function [v2, point2] = next_point(d, v1, point1, b)
% 根据前一点坐标与速度与板凳的长度，计算下一点的坐标与速度

    theta0 = sqrt(point1(1)^2 + point1(2)^2) / b;
    theta = theta0 + 0.00001;
    point2 = b*theta*[cos(theta), sin(theta)];
    distance = sqrt((point1(1)-point2(1))^2 + (point1(2)-point2(2))^2);

    while distance<d

        theta = theta + 0.00001;
        point2 = b*theta*[cos(theta), sin(theta)]; 
        distance = sqrt((point1(1)-point2(1))^2 + (point1(2)-point2(2))^2);

    end

    v2 = v1 * theta0^2 * sqrt(theta^2+1) / theta^2 / sqrt(theta0^2+1);

end