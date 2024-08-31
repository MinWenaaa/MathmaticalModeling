function  diff = pso(solution)
% 四组音爆时间的误差值
    % 参数设置
    num_partical = 200;     % 粒子数量
    num_ite = 200;      % 迭代次数
    omega = 0.5;    % 惯性因子
    c1 = 2; c2 = 2;     % 学习因子
    diff = zeros(1,4);
    monitor = [110.241000000000	27.2040000000000	824;
        110.780000000000	27.4560000000000	727;
        110.712000000000	27.7850000000000	742;
        % 110.251000000000	27.8250000000000	850;
        % 110.524000000000	27.6170000000000	786;
        % 110.467000000000	27.9210000000000	678;
        110.047000000000	27.1210000000000	575;
    ];

    % for i=1:3
         
        % monitors = [monitor, solution(:,i)];
        monitors = [monitor, solution()];

        % 粒子初始化
        partical_x(:,1) = 110 + rand(num_partical, 1);
        partical_x(:,2) = 27 + rand(num_partical, 1);
        partical_x(:,3) = 800 + 400*rand(num_partical, 1);
        partical_x(:,4) = -10 + 20*rand(num_partical, 1);

        partical_v(:,1) = -0.005 + 0.01*rand(num_partical, 1);
        partical_v(:,2) = -0.005 + 0.01*rand(num_partical, 1);
        partical_v(:,3) = -3 + 6*rand(num_partical, 1);
        partical_v(:,4) = -1 + 2*rand(num_partical, 1);

        % 适应度评价
        fitness = diff_sum(partical_x, monitors);
        pbest = partical_x;
        gbest = [partical_x(1,:), fitness(1)];

        for j=2:num_partical
            if fitness(j)<gbest(5)
                gbest = [partical_x(j,:), fitness(j)];
            end
        end

        % 更新
        partical_v = omega*partical_v + c1*rand()*(pbest-partical_x) + c2*rand()*(repmat(gbest(1:4), num_partical, 1)-partical_x);
        partical_x = partical_x + partical_v;

        % 粒子群主体
        for j=1:num_ite

            % 适应度评价
            pbest_fit = diff_sum(pbest, monitors);
            fitness = diff_sum(partical_x, monitors);
            for k=1:num_partical
                if fitness(k)<pbest_fit(k)
                    pbest(k,:) = partical_x(k,:);
                    if(fitness(k)<gbest(5))
                        gbest = [partical_x(k,:), fitness(k)];
                    end
                end
            end

            % 更新速度与位置
            partical_v = omega*partical_v + c1*rand()*(pbest-partical_x) + c2*rand()*(repmat(gbest(1:4), num_partical, 1)-partical_x);
            partical_x = partical_x + partical_v;

        end

        diff = gbest(1:4);

    % end

end