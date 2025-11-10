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

%legend("Northeast","Midwest","South","West","Location","northwest")

% Bc it'll be easier, I'm just allowing terms for all other regions and
% hopefully they'll optimize themselves to being appropriately
% positive,negatve, or 0
location_arr=["Northeast","Midwest","South","West"];
plotarch = zeros(1,4);
for j=1:4
    costfixed = @(v) cost(v, popdata, j);
    v = fminsearch(costfixed, [0;0;0;0]);
    xvals=linspace(1930,2020,500);
    p1 = plot(xvals, arrayfun(@(x) model(x, v, 1930, 2020, popdata), xvals),"DisplayName", location_arr(j));
    set(gca,'ColorOrderIndex',j)
    p2 = plot(times,b,'Marker','v');
    set(get(get(p2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
end
legend("Location", "northwest")
legend show
hold off

% v = [northeast;midwest;south;west] coefficients, j represents the column
% we are currently interested in
function y=cost(v, popdata, j)
    col=popdata(:,j);
    sum = 0;
    for i=1:length(col)-1
        sum = sum + (popdata(i,:)*v - col(i + 1))^2;
    end
    y=sum;
end

function y=model(x, v, start, end, popdata)
    base=popdata(1,:);
    exponent = (x-start) / 10;
    y=
end