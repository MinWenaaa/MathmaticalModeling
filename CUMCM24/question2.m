% 常量

b = 0.55/pi/2;
length_head = 2.86;
length_body = 1.65;

origin_A = [8.8, 0];

margin_ex_head = zeros(2000, 2);
margin_in_body = zeros(1000, 2);

thetas = linspace(8*pi,16*pi,1000);

for i=1:1000
    [margin_ex_head(i*2-1,1), margin_ex_head(i*2-1,2), margin_ex_head(i*2,1), margin_ex_head(i*2,2)]...% margin_ex_head(i*2,1), margin_ex_head(i*2,2)
    = margin_ex(length_head, [b*thetas(i)*cos(thetas(i)), b*thetas(i)*sin(thetas(i))], b);

    [margin_in_body(i,1), margin_in_body(i,2)]...
    = margin_in(length_body, [b*thetas(i)*cos(thetas(i)), b*thetas(i)*sin(thetas(i))], b);
end

figure;
hold on;
plot(margin_ex_head(1:2:1999,1), margin_ex_head(1:2:1999,2), '-r');
plot(margin_ex_head(2:2:2000,1), margin_ex_head(2:2:2000,2), '-b');
legend({'前外顶点','后外顶点'}, 'Location', 'best');

legend('Box','off'); 
l = legend('Fontsize', 12);
set(l,'Interpreter','none');


figure;
hold on;
plot(margin_in_body(:,1), margin_in_body(:,2), '-k');


margin_ex_head = margin_ex_head(2:2:2000,:);
margin_in_body(:,1) = margin_in_body(:,1) -2*pi; 

coefficients_1 = polyfit(margin_ex_head(:,1), margin_ex_head(:,2), 2);
coefficients_2 = polyfit(margin_in_body(:,1), margin_in_body(:,2), 2);

combined_coefficients = coefficients_1 + coefficients_2;

f = @(x) polyval(combined_coefficients, x) - 0.55;
theta_guess = (min(margin_ex_head(:,1)) + max(margin_ex_head(:,1))) / 2;
theta_solution = fzero(f, theta_guess);

result = ones(224,3);
result(1,1:2) = [b*theta_solution*cos(theta_solution), b*theta_solution*sin(theta_solution)];
[result(2,3),result(2,1:2)] = next_point(length_head, 1, result(1,1:2), b);

for i = 3:224
    [result(i,3),result(i,1:2)] = next_point(length_body, result(i-1,3), result(i-1,1:2), b);
end

que2_fileTable = array2table(result);
writetable(que2_fileTable, "que2.xlsx");