function k_s = calK_s(a, b, d, delta, theta_lat, theta_lon, k_c)
    k_f = 0.0296;
    substance = getSubstance(a, b, d, delta, theta_lat, theta_lon);
    Size = size(substance);

    n = zeros(Size(1), 1);
    m = zeros(Size(1), 1);
    
    for i=1:Size(1)
        n(i) = sum(substance(i,:,:), 'all');
        m(i) = Size(2)*Size(3) -n(i);
    end

    R_c = 2*d/a/b/k_c;
    R_f = 1/delta/k_f;
    f = @(Rs) sum(Rs * R_f ./ (n * Rs + m * R_f)) - R_c;
    
    Rs_solution = fsolve(f, R_f);
    k_s = 1/delta/Rs_solution;
end