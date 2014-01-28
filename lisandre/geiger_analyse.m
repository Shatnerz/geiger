% geiger_analyse(file_name, group_size,figures) - returns chi_squared for both gauss and poiss for each group
%In chi squared - gauss is the first column and poiss is the second
% file_name - file to load - dont include .data extension
% group_size - break data into smaller groups to analyse
% figures - boolean to save figures or not
% Loads geiger file and breaks it down into groups and analyses
% cuts off bottom rows if number of rows is not divisible by group_size

% needs		read_geiger.m
% 				data_analyse.m

function [mean, mean_var,chi2] = geiger_analyse (file_name, group_size, figures)

	[data, intervals, period] = read_geiger(strcat('data/',strcat(file_name,'.data'))); %load data
	[rows, cols] = size(data);
	
	if nargin < 2
		group_size = 5;
	end
	if nargin < 3
		figures = 0;
	end

	if mod(rows,group_size) %make sure divisible by group_size
		fprintf('Not divisible by %d removing bottom %d rows\n',group_size, mod(rows,group_size))
		data = data((1:(rows-mod(rows,group_size))),:);
		[rows, cols] = size(data);
	end
	 
	chi2 = [];
	mean=[];
	mean_var=[];
	%breaker geiger data into groups
	%for i = 1:group_size:rows
	%	data_group = data( i:(i+group_size-1),: );
	%name = sprintf( 'geiger.%dms.%d.%.2d',period*1000,group_size, ((i-1)/group_size)+1 );
		%chi2 = [chi2; data_analyse(data_group,'b',figures, name)'];
		%[c, avg, avg_var] = data_analyse(data_group,'b',figures, name);
	%	[avg, avg_var,c] = data_analyse(data_group,'b',figures, name);
	%	mean = [mean; avg];
	%	mean_var = [mean_var; avg_var];
	%	chi2 = [chi2; c'];
    %end
    name = sprintf( 'geiger.%dms.%d',period*1000,group_size);
    [avg, avg_var,c] = data_analyse(modify(data,group_size),'b',figures, name);
   mean = [mean; avg];
    mean_var = [mean_var; avg_var];
chi2 = [chi2; c'];