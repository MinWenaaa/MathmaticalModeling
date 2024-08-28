function tangentPoints = findTangentPoints(O_x, O_y, r, x0, y0)

    R = sqrt((x0-O_x)^2+(y0-O_y)^2)/2;
    o_x = (x0 + O_x)/2;
    o_y = (y0 + O_y)/2;

    d = sqrt((o_x-O_x)^2 + (o_y-O_y)^2);    % 圆心距离
     

    if d > (r + R) || d < abs(r - R)
        tangentPoints = [0,0;0,0];
        return;
    end
    
    a = (r^2 - R^2 + d^2) / (2*d);
    
    x3 = O_x + a * (o_x - O_x) / d;
    y3 = O_y + a * (o_y - O_x) / d;
    
    h = sqrt(r^2 - a^2);
    
    x1 = x3 + h * (o_y - O_y) / d;
    y1 = y3 - h * (o_x - O_x) / d;
    x2 = x3 - h * (o_y - O_y) / d;
    y2 = y3 + h * (o_x - O_x) / d;
    
    tangentPoints = [x1, y1; x2, y2];
end