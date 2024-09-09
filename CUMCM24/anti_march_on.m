function point = anti_march_on(start, length, b)
%UNTITLED 此处显示有关此函数的摘要
    theta = sqrt(start(1)^2+start(2)^2)/b + 0.00001;
        point = b*theta*[cos(theta), sin(theta)];
        march_length = sqrt((point(1)-start(1))^2 + (point(2)-start(2))^2);

        while march_length<length

            theta = theta + 0.00001;
            start = point;
            point = b*theta*[cos(theta), sin(theta)];
            march_length = march_length + sqrt((point(1)-start(1))^2 + (point(2)-start(2))^2);

        end
end