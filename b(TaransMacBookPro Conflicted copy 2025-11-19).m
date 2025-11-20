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


costfixed = @(v) cost(v, popdata);
rate_guess = 0.01;
[r,final_error]=fminsearch(costfixed, ([1,1,1,1,rate_guess,rate_guess,rate_guess,rate_guess])');
clf
hold on
location_arr=["Northeast","Midwest","South","West"];
popmodel = get_model(r,popdata);
for j=1:4
    p1 = plot(times,popdata(:,j),'Marker','v',"DisplayName", location_arr(j));
    set(gca,'ColorOrderIndex',j)
    p2 = plot(times, popmodel(:,j), 'Marker', 'o');
    set(get(get(p2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off'); 
end
legend("Location", "northwest")
legend show
hold off

function y=cost(v, popdata)
    popmodel=get_model(v, popdata);
    y=norm(popmodel - popdata, 'fro');

end

function y=get_model(v,popdata)
    A = [
        (v(1) + 1 - v(5) - v(7)) 0 0 0
        0 (v(2) + 1 - v(6) - v(8)) 0 0
        v(5) v(6) (v(3) + 1) 0
        v(7) v(8) 0 (v(4) + 1)
        ];

    popmodel = zeros(10,4);
    popmodel(1,:) = popdata(1,:);
    for i=2:length(popdata) 
        popmodel(i,:) = (A * popmodel(i-1,:)')';
    end
    y=popmodel;
end
