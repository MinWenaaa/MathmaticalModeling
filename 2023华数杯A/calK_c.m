function k_c = calK_c(a, b, d, delta, theta_lat, theta_lon, k_s)
% 输入模型的长宽高，根据空气与纤维导热率求织物整体导热率
    k_f = 0.0296;
    substance = getSubstance(a, b, d, delta, theta_lat, theta_lon);

    Size = size(substance);
    n = zeros(Size(1), 1);
    m = zeros(Size(1), 1);
    
    for i=1:Size(1)
        n(i) = sum(substance(i,:,:), 'all');
        m(i) = Size(2)*Size(3) -n(i);
    end

    R_s = 1/delta/k_s;
    R_f = 1/delta/k_f;
    R_c = sum(R_s * R_f ./ (n * R_s + m * R_f));
    k_c = 2*d/a/b/R_c;

end