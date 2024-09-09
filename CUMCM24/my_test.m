function [points] = my_test(d, point1, b)

    [~, point2] = next_point(d, 0, point1, b);

    center = [(point1(1)+point2(1))/2, (point1(2)+point2(2))/2];
    rotation = atan2(point1(2)-point2(2),point1(1)-point2(1));
    axises = [cos(rotation), sin(rotation); -sin(rotation), cos(rotation)];

    points = [
       center + axises(1,:)*(d+0.55)/2 + axises(2,:)*0.3/2;
        %center + axises(1,:)*(d+0.55)/2 - axises(2,:)*0.3/2;
        %center - axises(1,:)*(d+0.55)/2 - axises(2,:)*0.3/2;
        center - axises(1,:)*(d+0.55)/2 + axises(2,:)*0.3/2;
        ];
end