function startPoint = angle_to_point(start, b, r, r_min)
% 用于第45问将角度转化为坐标
        if start<=3.135328384953279 && start>=0.120424826288216
            startPoint = [-1.40920703468538	-0.261189293595071] + 2 * r_min * [cos(start), sin(start)];
        elseif start<=-0.006264268636514 && start>=-3.021167827301578
            startPoint = [2.83385200449659	0.252264818056912] + r_min * [cos(start), sin(start)];
        elseif start<=r/b
            startPoint = b*start*[cos(-start), sin(-start)];
        else
            startPoint = b*start*[cos(start), sin(start)];
        end

end