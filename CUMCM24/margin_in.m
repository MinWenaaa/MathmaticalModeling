function [theta, margin] = margin_in(d, point1, b)

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

    o = (sqrt(point1(1)^2+point1(2)^2)/b+sqrt(point2(1)^2+point2(2)^2)/b)/2;
    th = [o-0.005, o+0.005];

    target = point1(2)-point2(2)/point1(1)-point2(1);
    new_th = (th(1)+th(2))/2;
    k = ((new_th-0.01)*sin(new_th-0.01) - (new_th+0.01)*sin(new_th+0.01)) / ((new_th-0.01)*cos(new_th-0.01) - (new_th+0.01)*cos(new_th+0.01));

    while abs(th(1)-th(2)) * abs(k-target) > 0.00001

        new_th = (th(1)+th(2))/2;
        
        k = ((new_th-0.01)*sin(new_th-0.01) - (new_th+0.01)*sin(new_th+0.01)) / ((new_th-0.01)*cos(new_th-0.01) - (new_th+0.01)*cos(new_th+0.01));

        if k > target
            th = [th(1), new_th];
        else
            th = [new_th, th(2)];
        end

    end

    theta = (th(1)+th(2))/2;
    A = points(2,2)-points(3,2);
    B = points(3,1)-points(2,1);
    C = points(2,1)*points(3,2) - points(3,1)*points(2,2);
    margin = abs(A*b*theta*cos(theta) + B*b*theta*sin(theta) + C) / sqrt(A^2+B^2);
    
end