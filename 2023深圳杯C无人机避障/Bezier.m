function [time, equal_divide_point] = Bezier(points_A, points_B)
% 给定两组控制点，返回轨迹是否合法，与所用时间
    speed_A = 10;
    speed_B = 10;
    equal_divide_point = zeros(2, 80, 2);

% 求出一共十段白塞尔曲线的节点与长度
    t = linspace(0, 1, 61)';
    lengths = zeros(600,2);

    bezier_points = zeros(2, 601, 2);

    for i=1:10
        bezier_points(1, i*60-59:i*60+1, :) = (1-t).^3 .* points_A(3*i-2,:) + 3*(1-t).^2.*t .* points_A(3*i-1,:) + 3*(1-t).*t.^2 .* points_A(3*i,:) + t.^3 .* points_A(3*i+1, :);
        bezier_points(2, i*60-59:i*60+1, :) = (1-t).^3 .* points_B(3*i-2,:) + 3*(1-t).^2.*t .* points_B(3*i-1,:) + 3*(1-t).*t.^2 .* points_B(3*i,:) + t.^3 .* points_B(3*i+1, :);
    end

    % 检查是否碰到圆
    for i=1:601
        if abs(bezier_points(1, i, 1))<500
            if sqrt(bezier_points(1, i ,1)^2 + bezier_points(1, i, 2)^2)<500
                time = [-1, -1];
                return;
            end
        end
        if abs(bezier_points(2, i, 1))<500
            if sqrt(bezier_points(2, i ,1)^2 + bezier_points(2, i, 2)^2)<500
                time = [-1, -1];
                return;
            end
        end
    end

    for i=1:600
        lengths(i, 1) = sqrt((bezier_points(1,i,1)-bezier_points(1,i+1,1))^2 + (bezier_points(1,i,2)-bezier_points(1,i+1,2))^2);
        lengths(i, 2) = sqrt((bezier_points(2,i,1)-bezier_points(2,i+1,1))^2 + (bezier_points(2,i,2)-bezier_points(2,i+1,2))^2);
    end

% 判断无人机是否碰面

    % 取距离均等的100个节点
    minTime = min(sum(lengths(:,1))/speed_A, sum(lengths(:,2))/speed_B)/100;
    distance_A = minTime*speed_A;
    distance_B = minTime*speed_B;
    temp_A = distance_A;
    temp_B = distance_B;
    cur_index_A = 1;
    cur_index_B = 1;

    for i=1:600
        temp_A = temp_A - lengths(i, 1);
        if temp_A>0
            continue;
        elseif -temp_A>lengths(i, 1)/2
            equal_divide_point(1, cur_index_A, :) = bezier_points(1, i, :);
            temp_A = distance_A;
            i = i-1; cur_index_A = cur_index_A+1;
        else 
            equal_divide_point(1, cur_index_A, :) = bezier_points(1, i+1, :);
            temp_A = distance_A; cur_index_A = cur_index_A+1;
        end
    end

    for i=1:600
        temp_B = temp_B - lengths(i, 2);
        if temp_B>0
            continue;
        elseif -temp_B>lengths(i, 2)/2
            equal_divide_point(2, cur_index_B, :) = bezier_points(2, i, :);
            temp_B = distance_B;
            i = i-1; cur_index_B = cur_index_B+1;
        else 
            equal_divide_point(2, cur_index_B, :) = bezier_points(2, i+1, :);
            temp_B = distance_B; cur_index_B = cur_index_B+1;
        end
    end

    for i=1:size(equal_divide_point, 2)
        if intersect_with_circle(equal_divide_point(1, i, :), equal_divide_point(2, i, :))
            continue;
        else
            time = [-1, -1];
            return;
        end
    end

    time = [sum(lengths(:,1))/speed_A, sum(lengths(:,2))/speed_B];
    
end



function flag = intersect_with_circle(point1, point2)
    A = point2(2) - point1(2);  
    B = point1(1) - point2(1);  
    C = point2(1)*point1(2) - point1(1)*point2(2); 
    
    d = abs(C) / sqrt(A^2 + B^2) ;
    
    flag = d<500;
end