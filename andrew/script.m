% Quick script to generate averages and error for each time 
x = [10, 50, 100, 500, 1000, 1500, 2000]';

y = [];
e = []
for i = 1:size(x,1)
	name = sprintf('geiger%dms',x(i));
	[mean, variance, chi2] = geiger_analyse(name,100,1);
	y = [y; mean];
	err = sqrt(variance);
	e = [e; err];
end

%figure;
%errorbar(x,y,e);
