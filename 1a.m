clearvars
% Population in millions by region (NE,MW,S,W) since 1930
popdata = [34.4 38.6 37.9 12.3;
    36.0 40.1 41.7 14.3;
    39.5 44.5 47.2 20.2;
    44.7 51.6 55.0 28.1;
    49.0 56.6 62.8 34.8;
    49.1 58.9 75.4 43.2;
    50.8 59.7 85.4 52.8;
    53.6 64.4 100.2 63.2;
    55.3 66.9 114.6 71.9;
    57.6 69.0 126.3 78.6
    ];
times = 1930:10:2020;
clf
hold on
plot(times,popdata,'Marker','v')
legend("Northeast","Midwest","South","West","Location","northwest")

rarch = zeros(1,4);
for j=1:4
    b=popdata(:,j);
    costfixed = @(r) cost(r, b);
    r = fminsearch(costfixed, 0);
    rarch(j) = r;
end
hold off

function y=cost(r, col)
    f = @(x) r * x + x;
    sum = 0;
    for i=1:length(col)-1
        sum = sum + (f(col(i)) - col(i + 1))^2;
    end
    y=sum;
end