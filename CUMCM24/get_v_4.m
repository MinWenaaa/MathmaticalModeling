function v2 = get_v_4(angle1, angle2, v1, b, r, r_min)
% 
    if angle1>r/b && angle2>r/b  %螺螺

        v2 = abs(v1 * angle1 * sqrt(1/angle2^2+1) / angle2 / sqrt(1/angle1^2+1));
        return;

    elseif angle2>r/b && angle1 > 0.120424826288216 && angle1 < 3.135328384953279  % 圆螺

        vector_r = [cos(angle1), sin(angle1)];
        point1 = [-1.40920703468538	-0.261189293595071] + 2*r_min*vector_r;
        point2 = b*angle2*[cos(angle2),sin(angle2)];
        cosTheta = dot(vector_r, point1) / norm(vector_r) / norm(point1);

        v2 = abs(v1 * cosTheta * sqrt(point1(1)^2+point1(2)^2) / sqrt(point2(1)^2+point2(2)^2) * sqrt(1+1/angle1^2));
        return;

    elseif angle1 > 0.120424826288216 && angle1 < 3.135328384953279 && angle2 > 0.120424826288216 && angle2 < 3.135328384953279

        v2 = v1;
        return;

    elseif angle2 > 0.120424826288216 && angle2 < 3.135328384953279 && angle1 < -0.006264268636514 && angle1 > -3.021167827301578

        vector_r1 = [cos(angle1), sin(angle1)];
        vector_r2 = [cos(angle2), sin(angle2)];
        point1 = [2.83385200449659	0.252264818056912] + r_min*vector_r1;
        point2 = [-1.40920703468538	-0.261189293595071] + 2*r_min*vector_r2;
        cosTheta1 = dot(vector_r1, point1) / norm(vector_r1) / norm(point1);
        cosTheta2 = dot(vector_r2, point2) / norm(vector_r2) / norm(point2);

        v2 = abs(v1 * cosTheta1 * sqrt(point1(1)^2+point1(2)^2) / cosTheta2 / sqrt(point2(1)^2+point2(2)^2));
        return;

    elseif angle1 < -0.006264268636514 && angle1 > -3.021167827301578 && angle2 < -0.006264268636514 && angle2 > -3.021167827301578

        v2 = v1;
        return;

    elseif angle1 < -r/b && angle2 < -0.006264268636514 && angle2 > -3.021167827301578
        
        point1 = b*angle1*[cos(-angle1), sin(-angle1)];
        vector_r2 = [cos(angle2), sin(angle2)];
        point2 = [2.83385200449659	0.252264818056912] + r_min*vector_r2;
        cosTheta2 = dot(vector_r2, point2) / norm(vector_r2) / norm(point2);

        v2 = abs(v1 * sqrt(point1(1)^2+point1(2)^2) / cosTheta2 / sqrt(point2(1)^2+point2(2)^2) / sqrt(1+1/angle1^2));
        return;

    elseif angle1 < -r/b && angle2 < -r/b

         v2 = abs(v1 * angle1^2 * sqrt(angle2^2+1) / angle2^2 / sqrt(angle1^2+1));

    elseif angle1 < -r/b && angle2 > 0.120424826288216 && angle2 < 3.135328384953279

        point1 = b*angle1*[cos(-angle1), sin(-angle1)];
        vector_r2 = [cos(angle2), sin(angle2)];
        point2 = [2.83385200449659	0.252264818056912] + r_min*vector_r2;
        cosTheta2 = dot(vector_r2, point2) / norm(vector_r2) / norm(point2);
        v2 = abs(v1 * sqrt(point1(1)^2+point1(2)^2) / cosTheta2 / sqrt(point2(1)^2+point2(2)^2) / sqrt(1+1/angle1^2));
        return;

    end


end