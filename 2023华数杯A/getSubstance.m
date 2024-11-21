function substance = getSubstance(a, b, d, delta, theta_lat, theta_lon)
% 获取二值化材质矩阵
% a.b是方块的长和宽，d是纤维的直径。
% theta是圆心角

    substance = zeros(ceil(2*d/delta), ceil(b/delta), ceil(a/delta));

    k_lat = (d*sin(pi/2+theta_lat)-d/2) / (d*cos(pi/2+theta_lat)-a/4 + a/2);
    k_lon = (d*sin(pi/2+theta_lon)-d/2) / (d*cos(pi/2+theta_lon)-b/4 + b/2);

    for i = 1:ceil(2*d/delta)
        for j = 1:ceil(b/delta)
            for k = 1:ceil(a/delta)
                coord = ([i, j, k]-0.5) * delta - [d, b/2, a/2];
                substance(i, j, k) = getValue(coord, a, b, k_lat, k_lon, d);
            end

        end
    end

end

function value = getValue(coord, a, b, k_lat, k_lon, d)
% 确定目标经线与目标纬线。若距离任意轴线的距离大于d/2，返回0
    dx = abs([coord(3)+a/4, coord(3)-a/4]);
    dy = abs([coord(2)+b/4, coord(2)-b/4]);
    [dx, target_lon] = min(dx);
    [dy, target_lat] = min(dy);
    if dx>d/2 && dy>d/2
        value = 0;
        return
    end

% 确定待求点在轴线截面上的投影到轴线的距离
    % 经线
    if target_lat == 1
        distance = getDistance(coord(3), coord(1), a, d, k_lat);
    else
        distance = getDistance(coord(3), -coord(1), a, d, k_lat);
    end

    if sqrt(distance^2 + dy^2) < d/2
        value = 1;
        return
    end

    % 纬线
    if target_lon == 1
        distance = getDistance(coord(2), -coord(1), b, d, k_lon);
    else
        distance = getDistance(coord(2), coord(1), b, d, k_lon);
    end

    if sqrt(distance^2 + dx^2) < d/2
        value = 1;
    else
        value = 0;
    end

end

function distance = getDistance(x, y, a, d, k)
    if y+d/2+(x+a/4)/k < 0 % 直线1
        distance = abs(y-k*(x+a/2))/sqrt(1+k^2);
    elseif y+d/2-(x+a/4)/k > 0 % 弧1
        distance = abs(sqrt((x+a/4)^2 + (y+d/2)^2) - d);
    elseif y-d/2-(x-a/4)/k > 0 % 直线2
        distance = abs(y+k*x)/sqrt(1+k^2);
    elseif y-d/2+(x-a/4)/k < 0 % 弧2
        distance = abs(sqrt((x-a/4)^2 + (y-d/2)^2) - d);
    else
        distance = abs(y-k*(x-a/2))/sqrt(1+k^2);
    end
    
end