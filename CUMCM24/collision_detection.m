function flag = collision_detection(bench1, bench2, length1, length2, width)
% 判断两个板凳是否碰撞

    center = [(bench1(1,1)+bench1(2,1))/2, (bench1(1,2)+bench1(2,2))/2;
        (bench2(1,1)+bench2(2,1))/2, (bench2(1,2)+bench2(2,2))/2;
        ];

    rotation1 = atan2(bench1(1,2)-bench1(2,2), bench1(1,1)-bench1(2,1));
    rotation2 = atan2(bench2(1,2)-bench2(2,2), bench2(1,1)-bench2(2,1));
    
    axises = [cos(rotation1), sin(rotation1); -sin(rotation1), cos(rotation1);
        cos(rotation2), sin(rotation2); -sin(rotation2), cos(rotation2)];

    points1 = [
        center(1,:) + axises(1,:)*length1/2 + axises(2,:)*width/2;
        center(1,:) + axises(1,:)*length1/2 - axises(2,:)*width/2;
        center(1,:) - axises(1,:)*length1/2 - axises(2,:)*width/2;
        center(1,:) - axises(1,:)*length1/2 + axises(2,:)*width/2;
        ];

    points2 = [
        center(2,:) + axises(3,:)*length2/2 + axises(4,:)*width/2;
        center(2,:) + axises(3,:)*length2/2 - axises(4,:)*width/2;
        center(2,:) - axises(3,:)*length2/2 - axises(4,:)*width/2;
        center(2,:) - axises(3,:)*length2/2 + axises(4,:)*width/2;
        ];

    for i=1:4

        min1 = min([dot(points1(1,:), axises(i,:)), dot(points1(2,:), axises(i,:)), dot(points1(3,:), axises(i,:)), dot(points1(4,:), axises(i,:))]);
        max1 = max([dot(points1(1,:), axises(i,:)), dot(points1(2,:), axises(i,:)), dot(points1(3,:), axises(i,:)), dot(points1(4,:), axises(i,:))]);
        min2 = min([dot(points2(1,:), axises(i,:)), dot(points2(2,:), axises(i,:)), dot(points2(3,:), axises(i,:)), dot(points2(4,:), axises(i,:))]);
        max2 = max([dot(points2(1,:), axises(i,:)), dot(points2(2,:), axises(i,:)), dot(points2(3,:), axises(i,:)), dot(points2(4,:), axises(i,:))]);

        if min1<max2 && max1>min2
            flag = false;
            return
        end

    end

    flag = true;

end



function result = dot(vector1, vector2)
% vector1在vector2上的投影
    result = vector1(1)*vector2(1) + vector1(1)*vector2(1);
end