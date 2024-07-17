function dydt = CarbonEmission(v, param)
    
    dPeople_num = param(2);
    dSO2 = param(37);
    dNum_big = param(28);
    dNum_medium = param(30);
    dNum_small = param(32);
    dstudent = param(34)*dPeople_num;
    dLib = param(22)*dstudent;
    dpeople_gdp = param(16)* dstudent +param(17)*dLib;
    dG = param(19)*dpeople_gdp + param(19)*dPeople_num*sqrt(v(2))*30;
    dU = param(12)*dG + param(13) *dstudent;
    dI = param(4)*dNum_big + param(5)*dNum_medium + param(6)*dNum_small + param(8)*dSO2 +param(7)*dG;
    dO = param(25)*dG - param(26)*dU +param(24)*dPeople_num;
    dC = param(10)*dI - param(10)*dO

    Tech = v(6)+v(7)
    a = 2*dC
    b =sqrt(v(1)-2015)*Tech/160

    dydt = [1, dpeople_gdp, 0, dG, dSO2, dLib, dstudent, dPeople_num, dU, 0, a-b, dNum_big, dNum_medium, dNum_small, dI, dO]
   
end