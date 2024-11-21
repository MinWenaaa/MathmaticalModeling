function result = Monte(count, delta, min, max, k_s)

    result = zeros(count, 4);
    for i=1:count
        x = randomInit(min, max);
        thate_lat = tangent(x(2)/4, x(1)/2);
        theta_lon = tangent(x(3)/4, x(1)/2);
        k_c = calK_c(x(2), x(3), x(1), delta, thate_lat, theta_lon, k_s);
        result(i,:) = [x, k_c];
    end

end

function X = randomInit(min, max)
    X = min + rand(1,3).*(max-min);
end

function k = tangent(a, d)
% a,d 是圆心横纵坐标
    coefficients = [3*d^2, 2*a*d, 4*d^2 - a^2];
    k = atan(-1/roots(coefficients));

end