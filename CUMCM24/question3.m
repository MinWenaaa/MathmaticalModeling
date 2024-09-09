% 常量

length_head = 2.86;
length_body = 1.65;
width = 0.3;
r = 4.5;


% 获得初始解
% 4.5+b - sqrt((4.5+b)^2 - (length_body/2)^2) = b - margin_ex - 0.15

margin = sqrt((sqrt(r^2 - (length_head/2)^2) + width/2)^2 + (length_head/2 + 0.275)^2) - 4.5;

f = @(b) 4.5 + b - sqrt((4.5 + b)^2 - (length_body/2)^2) - (b - margin - 0.15);

b_guess = 0.4; 
b_init = fzero(f, b_guess);

% 迭代计算螺距

b = 0;
pitch_new = b_init/2/pi;

while abs(b-pitch_new) > 0.000001

    b = pitch_new;

    margin_ex_head = zeros(50, 2);
    margin_in_body = zeros(50, 2);

    theta_ex = linspace(r/b-0.8, r/b-0.2, 50);
    theta_in = linspace(r/b+2*pi-0.3, r/b+2*pi+0.3, 50);

    for i=1:50

        [margin_in_body(i,1), margin_in_body(i,2)]...
        = margin_in(length_body, [b*theta_in(i)*cos(theta_in(i)), b*theta_in(i)*sin(theta_in(i))], b);

        [~, ~, margin_ex_head(i,1), margin_ex_head(i,2)]... 
        = margin_ex(length_head, [b*theta_ex(i)*cos(theta_ex(i)), b*theta_ex(i)*sin(theta_ex(i))], b);
    end

    margin_in_body(:,1) = margin_in_body(:,1) -2*pi;
    coefficients_1 = polyfit(margin_ex_head(:,1), margin_ex_head(:,2), 1);
    coefficients_2 = polyfit(margin_in_body(:,1), margin_in_body(:,2), 1);
    coefficients = coefficients_1 +coefficients_2;

    pitch_new = polyval(coefficients, r/b);

end