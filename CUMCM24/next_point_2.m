function [v2, nextAngle] = next_point_2(d, v1, last_point_angle, b, r, r_min)
%

    v2 = 0;
    lastPoint = angle_to_point(last_point_angle, b, r, r_min);

    if d==2.86
        angle_big = 1.05151785660888;
    else
        angle_big = 0.587492730977650;
        angle_small = 1.23520025228710;
    end

    if last_point_angle > r/b
        % 头尾均在盘入

        [v2, nextPoint] = next_point(d, v1, lastPoint, b);
        nextAngle = sqrt(nextPoint(1)^2 + nextPoint(2)^2) / b;
        return;

    elseif last_point_angle < 3.135328384953279 && last_point_angle > 3.135328384953279 - angle_big
        % 头在大圆弧，尾在盘入
        nextAngle = r/b;
        nextPoint = b*nextAngle*[cos(nextAngle), sin(nextAngle)];
        distance = sqrt((nextPoint(1)-lastPoint(1))^2 + (nextPoint(2)-lastPoint(2))^2);

        while distance<d

            nextAngle = nextAngle + 0.00001;
            nextPoint = b*nextAngle*[cos(nextAngle), sin(nextAngle)]; 
            distance = sqrt((nextPoint(1)-lastPoint(1))^2 + (nextPoint(2)-lastPoint(2))^2);

        end

        return;


    elseif last_point_angle > 0.120424826288216
        % 头尾均在大圆弧

        nextAngle = last_point_angle + angle_big;
        v2 = v1;
        return;

    elseif (d==2.86 && last_point_angle >= -3.021167827301578 && last_point_angle < -0.006264268636514) || (d == 1.65 && last_point_angle >= -3.021167827301578 && last_point_angle < -3.021167827301578 + angle_small) 
        % 头在小圆弧，尾在大圆弧

        nextAngle = last_point_angle;
        nextPoint = [2.83385200449659	0.252264818056912] + r_min * [cos(nextAngle), sin(nextAngle)];
        distance = sqrt((nextPoint(1)-lastPoint(1))^2 + (nextPoint(2)-lastPoint(2))^2);

        while distance<d
            if nextAngle < -3.021167827301578
                nextAngle = 0.120424826288216;
                break;
            end
            nextAngle = nextAngle - 0.00001;
            nextPoint = [2.83385200449659	0.252264818056912]  + r_min * [cos(nextAngle), sin(nextAngle)];
            distance = sqrt((nextPoint(1)-lastPoint(1))^2 + (nextPoint(2)-lastPoint(2))^2);

        end

        while distance<d
            nextAngle = nextAngle + 0.00001;
            nextPoint =  [-1.40920703468538, -0.261189293595071] + 2 * r_min * [cos(nextAngle), sin(nextAngle)];
            distance = sqrt((nextPoint(1)-lastPoint(1))^2 + (nextPoint(2)-lastPoint(2))^2);

        end

        return;

    elseif last_point_angle > -r/b && d==1.65
        % 头尾均在小圆弧
        nextAngle = last_point_angle - angle_small;
        v2 = v1;
        return

    else
        % 头在盘出，
        nextAngle = last_point_angle+0.00001;
        nextPoint = b*nextAngle*[cos(-nextAngle), sin(-nextAngle)];
        distance = sqrt((nextPoint(1)-lastPoint(1))^2 + (nextPoint(2)-lastPoint(2))^2);

        while distance<d
            % 尾在盘出
            if nextAngle > -r/b
                nextAngle = -0.006264268636514;
                break;
            end

            nextAngle = nextAngle + 0.00001;
            nextPoint = b*nextAngle*[cos(-nextAngle), sin(-nextAngle)];
            distance = sqrt((nextPoint(1)-lastPoint(1))^2 + (nextPoint(2)-lastPoint(2))^2);

        end

        while distance<d
            % 尾在小圆弧
            if nextAngle < -3.021167827301578
                nextAngle = 0.120424826288216;
                break;
            end
            nextAngle = nextAngle - 0.00001;
            nextPoint = [2.83385200449659, 0.252264818056912]  + r_min * [cos(nextAngle), sin(nextAngle)];
            distance = sqrt((nextPoint(1)-lastPoint(1))^2 + (nextPoint(2)-lastPoint(2))^2);

        end

        while distance<d
            % 尾在大圆弧
            nextAngle = nextAngle + 0.00001;
            nextPoint =  [-1.40920703468538, -0.261189293595071] + 2 * r_min * [cos(nextAngle), sin(nextAngle)];
            distance = sqrt((nextPoint(1)-lastPoint(1))^2 + (nextPoint(2)-lastPoint(2))^2);

        end

        return;

    end
end