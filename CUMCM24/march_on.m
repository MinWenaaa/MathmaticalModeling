function [start, point] = march_on(start, length, b, question, r, r_min)
% 以start为起点，前进长度length，返回终点坐标
    if question==1

        % 输入的参数 start 为起点坐标
        theta = sqrt(start(1)^2+start(2)^2)/b - 0.00001;
        point = b*theta*[cos(theta), sin(theta)];
        march_length = sqrt((point(1)-start(1))^2 + (point(2)-start(2))^2);

        while march_length<length

            theta = theta - 0.00001;
            start = point;
            point = b*theta*[cos(theta), sin(theta)];
            march_length = march_length + sqrt((point(1)-start(1))^2 + (point(2)-start(2))^2);

        end

    else

        % start 为角度

        state = 0;
        if start<=3.135328384953279 && start>=0.120424826288216
            state = 1;
        elseif start<=-0.006264268636514 && start>=-3.021167827301578
            state = 2;
        elseif start<=r/b
            state = 3;
        end

        startPoint = angle_to_point(start, b, r, r_min);

        march_length = 0;
        while march_length<length
            
            switch state

                case 0
                    start = start - 0.00001;
                    point = b*start*[cos(start), sin(start)];
                    march_length = march_length + sqrt((point(1)-startPoint(1))^2 + (point(2)-startPoint(2))^2);
                    startPoint = point;
                    if start< r/b
                        start = 3.135328384953279;
                        state = 1;
                    end

                case 1
                    if length-march_length - (start - 0.120424826288216) * 2 * r_min > 0
                        march_length = march_length + (start - 0.120424826288216) * 2 * r_min;
                        start = -3.021167827301578;
                        state = 2;
                    else
                        start = start - (length-march_length)/2/r_min;
                        point = [-1.40920703468538, -0.261189293595071] + 2 * r_min * [cos(start), sin(start)];
                        return;
                    end

                case 2
                    if length-march_length - (-0.006264268636514-start) * r_min > 0
                        march_length = march_length + (-0.006264268636514-start) * r_min;
                        start = -r/b;
                        startPoint = b*start*[cos(-start), sin(-start)];
                        state = 3;
                        
                    else
                        start = start + (length-march_length)/r_min;
                        point = [2.83385200449659, 0.252264818056912] + r_min * [cos(start), sin(start)];
                        return;
                    end 

                case 3
                    start = start - 0.00001;
                    point = b*start*[cos(-start), sin(-start)];
                    march_length = march_length + sqrt((point(1)-startPoint(1))^2 + (point(2)-startPoint(2))^2);
                    startPoint = point;
                    

            end 
           
        end

    end

end