% 常量

length_head = 2.86;
length_body = 1.65;
width = 0.3;
b = 1.7/2/pi;


S = zeros(3000,1);
index = 1;

r = 0.98*4.5;
while true

    r = 0.99999 * r;

    % 圆心坐标
    tangent_theta = r/b;
    tangentPoint = b*tangent_theta*[cos(tangent_theta), sin(tangent_theta); -cos(tangent_theta), -sin(tangent_theta)];
    tangnent_angle = atan2((tangent_theta-0.01)*sin(tangent_theta-0.01) - (tangent_theta+0.01)*sin(tangent_theta+0.01), (tangent_theta-0.01)*cos(tangent_theta-0.01) - (tangent_theta+0.01)*cos(tangent_theta+0.01));
    normal = [-sin(tangnent_angle), cos(tangnent_angle)];
    func = @(r) findCircle(r, tangentPoint, normal);
    r_min = fminbnd(func, 1.4, 3);
    O = [tangentPoint(1,:) - 2*normal*r_min; tangentPoint(2,:) + normal*r_min];

    circle1_start = atan2(tangentPoint(1,2)-O(1,2), tangentPoint(1,1)-O(1,1));
    circle1_end = atan2(O(2,2)-O(1,2), O(2,1)-O(1,1));
    circle2_start = circle1_end - pi;
    circle2_edn = atan2(tangentPoint(2,2)-O(2,2), tangentPoint(2,1)-O(2,1));

    S(index) = abs(circle2_start-circle2_edn)*r_min + abs(circle1_start-circle1_end)*2*r_min;
    index = index+1;

    % 相距最远的平行切线
    tempTangent = tangentPoint(2,:);
    temptheta = -tangent_theta;
    temp_tangent_angle = atan2((temptheta-0.01)*sin(temptheta-0.01) - (temptheta+0.01)*sin(temptheta+0.01), (temptheta-0.01)*cos(temptheta-0.01) - (temptheta+0.01)*cos(temptheta+0.01));
    temp_normal = [-sin(temp_tangent_angle), cos(temp_tangent_angle)];
    tangent_point_circle = O(1,:) + 2 * r_min * temp_normal;
    distance = sqrt((tangent_point_circle(1)-tempTangent(1))^2 + (tangent_point_circle(2)-tempTangent(2))^2);
    while true
        newtheta = temptheta - 0.0001;
        newTangent = b*newtheta*[cos(newtheta), sin(newtheta)];
        newTangent_angle =  atan2((newtheta-0.01)*sin(newtheta-0.01) - (newtheta+0.01)*sin(newtheta+0.01), (newtheta-0.01)*cos(newtheta-0.01) - (newtheta+0.01)*cos(newtheta+0.01));
        new_normal = [-sin(newTangent_angle), cos(newTangent_angle)];
        new_point_circle = O(2,:) + r_min * new_normal;
        new_distance = sqrt((new_point_circle(1)-newTangent(1))^2 + (new_point_circle(2)-newTangent(2))^2);
        if new_distance<distance
            break;
        else
            temptheta = newtheta;
            distance = new_distance;
        end
    end

    if distance<length_head
        break;
    end

end

r = r/0.99999

r = 4.5


tangent_theta = r/b;
tangentPoint = b*tangent_theta*[cos(tangent_theta), sin(tangent_theta); -cos(tangent_theta), -sin(tangent_theta)];
tangnent_angle = atan2((tangent_theta-0.01)*sin(tangent_theta-0.01) - (tangent_theta+0.01)*sin(tangent_theta+0.01), (tangent_theta-0.01)*cos(tangent_theta-0.01) - (tangent_theta+0.01)*cos(tangent_theta+0.01));
normal = [-sin(tangnent_angle), cos(tangnent_angle)];
func = @(r) findCircle(r, tangentPoint, normal);
r_min = fminbnd(func, 1.4, 3);
O = [tangentPoint(1,:) - 2*normal*r_min; tangentPoint(2,:) + normal*r_min];

circle1_start = atan2(tangentPoint(1,2)-O(1,2), tangentPoint(1,1)-O(1,1));
circle1_end = atan2(O(2,2)-O(1,2), O(2,1)-O(1,1));
circle2_start = circle1_end - pi;
circle2_edn = atan2(tangentPoint(2,2)-O(2,2), tangentPoint(2,1)-O(2,1));
arcsin = 2 * [
    asin(length_head/4/r_min), asin(length_body/4/r_min);
    0, asin(length_body/2/r_min);
    ];

result = zeros(448, 201);
angles = zeros(224, 201);
result(1:2, 1) = anti_march_on(r*[cos(r/b),sin(r/b)], 100, b);
angles(1,1) = sqrt((result(1,1)^2 + result(2,1)^2))/b;

[~, angles(2,1)] = next_point_2(length_head, 0, angles(1,1), b, r, r_min);
result(3:4, 1) = angle_to_point(angles(2,1), b, r, r_min);

for i = 2:201
    [angles(1,i), result(1:2,i)] = march_on(angles(1,i-1), 1, b, 2, r, r_min);
    [~, angles(2, i)] = next_point_2(length_head, 0, angles(1, i), b, r, r_min);
    result(3:4, i) = angle_to_point(angles(2,i), b, r, r_min); 
end

for i = 3:224
    for j = 1:201
        [~, angles(i, j)] = next_point_2(length_body, 0, angles(i-1, j), b, r, r_min);
        result(2*i-1:2*i, j) = angle_to_point(angles(i,j), b, r, r_min);
    end
end



position_fileTable = array2table(result);
writetable(position_fileTable, "que4_position.xlsx");

figure;
hold on;

frames = cell(1, 100);

for i = 75:175
    clf;
    plot(result(1:2:447,i), result(2:2:448,i), '*k');
    axis equal;
    xlim([-20,20]);
    ylim([-20,20]);
    frames{i-74} = getframe(gcf);
end

grayFrames = cellfun(@(x) rgb2gray(im2uint8(x.cdata)), frames, 'UniformOutput', false);
grayIm = cat(4, grayFrames{:}); 


imwrite(grayIm, 'que2.gif', 'gif', 'LoopCount', inf);

clf; figure; hold on;
plot(result(1,95:120), result(2,95:120), '*k');
plot(result(3,95:120), result(4,95:120), '*r');
axis equal;

% 计算速度

v = ones(224, 201)*2;

for i=2:224
    for j=1:201
        v(i,j) = get_v_4(angles(i-1,j), angles(i,j), v(i-1,j), b, r, r_min);
    end
end

v_fileTable = array2table(v);
writetable(v_fileTable, "que4_v.xlsx");

v(2,110) = get_v_4(angles(1,110), angles(2,110), v(1,110), b, r, r_min);

clf;
figure;
hold on;
t = linspace(tangent_theta,20*pi, 500)';
circle1_angle = linspace(circle1_start, circle1_end, 50)';
circle2_angle = linspace(circle2_start, circle2_edn, 50)';
circle1 = O(1,:) + 2*r_min*[cos(circle1_angle), sin(circle1_angle)];
circle2 = O(2,:) + r_min*[cos(circle2_angle), sin(circle2_angle)];
points = b*[t.*cos(t), t.*sin(t)];
%for i = 1:500
%    points(i,:) = angle_to_point(t(i), b);
%end
plot(points(:,1), points(:,2), '-r');
plot(-points(:,1), -points(:,2), '-b');
plot(circle1(:,1), circle1(:,2), '-r');
plot(circle2(:,1), circle2(:,2), '-b');
plot(tangentPoint(:,1), tangentPoint(:,2), '*k');
plot(O(:,1), O(:,2),'*r')
axis equal;
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
lgd = legend({'盘入','盘出'}, 'Location', 'best');
lgd.FontSize = 14;