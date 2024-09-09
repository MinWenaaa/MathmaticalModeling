function [theta1, margin_ex1, theta2, margin_ex2] = margin_ex(d, point1, b)% theta2, margin_ex2,
% 给定螺距与第一个把手点，给出最远的距离与相应的theta

    [~, point2] = next_point(d, 0, point1, b);

    center = [(point1(1)+point2(1))/2, (point1(2)+point2(2))/2];
    rotation = atan2(point1(2)-point2(2), point1(1)-point2(1));
    axises = [cos(rotation), sin(rotation); -sin(rotation), cos(rotation)];

    points = [
        center(1,:) + axises(1,:)*(d+0.55)/2 + axises(2,:)*0.3/2;
        center(1,:) + axises(1,:)*(d+0.55)/2 - axises(2,:)*0.3/2;
        center(1,:) - axises(1,:)*(d+0.55)/2 - axises(2,:)*0.3/2;
        center(1,:) - axises(1,:)*(d+0.55)/2 + axises(2,:)*0.3/2;
        ];

    
    th = [sqrt(point1(1)^2+point1(2)^2)/b, sqrt(point2(1)^2+point2(2)^2)/b];

    % 外边距
    
    theta1 = my_minSearch(th(1)-0.2, th(1)+0.2, points(1,:), b);
    margin_ex1 = distancetoPoint(theta1, points(1,:), b);

    theta2 = my_minSearch(th(2)-0.2, th(2)+0.2, points(4,:), b);
    margin_ex2 = distancetoPoint(theta2, points(4,:), b);

end



function theta = my_minSearch(min, max, P, b)

    while abs(max-min)>0.001
        new_th = (max+min)/2;
        distance1 = distancetoPoint(min, P, b);
        distance2 = distancetoPoint(max, P, b);
        if distance2<distance1
            min = new_th;
        else
            max = new_th;
        end
    end

    theta = (max+min)/2;
    
end



function distance = distancetoPoint(theta, P, b)
    x = b*theta*cos(theta);
    y = b*theta*sin(theta);
    distance = sqrt((x-P(1))^2 + (y-P(2))^2);

end