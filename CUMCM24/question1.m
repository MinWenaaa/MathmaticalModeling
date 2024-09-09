% 常量

b = 0.55/pi/2;
length_head = 2.86;
length_body = 1.65;

origin_A = [8.8, 0];

benches_origin = zeros(224, 2);
benches_origin(1,:) = origin_A;
benches_origin(2:224,2) = linspace(length_head, length_head+length_body*223, 223);

position = zeros(448,300);
v = ones(224, 300);

% 龙头每秒的坐标

position(1:2,1) = origin_A;

for i = 2:300
    [~, position(1:2,i,:)] = march_on(position(1:2,i-1,:), 1, b, 1);
end

% 龙身1、51、101、151、201和龙尾的位置

for i = 1:300
    [v(2,i), position(3:4,i)] = next_point(length_head, 1, position(1:2,i), b);
    for j = 3:224
        [v(j,i), position(j*2-1:j*2, i)] = next_point(length_body, v(j-1,i), position(j*2-3:j*2-2,i), b);
    end
end


% 绘制

temp_folder = 'temp_gif_frams';
if ~exist(temp_folder, 'dir')
    mkdir(temp_folder)
end

for i = 1:20
    clf;
    %test(400+i*7-6:400+i*7, :) = position(i,:,:);
    plot(position(1:2:447,i), position(2:2:448,i), '*k');
    axis equal;
    xlim([-15,15]);
    ylim([-15,15]);
    fram_filename = fullfile(temp_folder, ['fram_', num2str(i), '.png']);
    saveas(gcf,fram_filename);
end

% 输出结果

disp(position);
disp(v);

position_fileTable = array2table(position);

v_fileTable = array2table(v);


writetable(position_fileTable, "que1_position.xlsx");
writetable(v_fileTable, "que1_v.xlsx");

figure;
hold on;

frames = cell(1, 100);

for i = 1:100
    clf;
    plot(position(1:2:447,i), position(2:2:448,i), '*k');
    axis equal;
    xlim([-15,15]);
    ylim([-15,15]);
    frames{i} = getframe(gcf);
end
grayFrames = cellfun(@(x) rgb2gray(im2uint8(x.cdata)), frames, 'UniformOutput', false);
grayIm = cat(4, grayFrames{:}); 


imwrite(grayIm, 'spiral.gif', 'gif', 'LoopCount', inf);
