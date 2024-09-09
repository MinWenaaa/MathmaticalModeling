function diff = findCircle(r, tangentPoint, normal)
% 找到符合第四问条件的圆心

    O1 = tangentPoint(1,:) - 2*normal*r;
    O2 = tangentPoint(2,:) + normal*r;

    diff = abs(sqrt((O1(1)-O2(1))^2 + (O1(2)-O2(2))^2) - 3*r);

end