% chi_squared(x, var, pdf)
% x - data points
% var - variance of each data point
% pdf - given pdf to do the chi-squared test on
% return the chi squared between given data and a given
% probability distribution function, pdf

function [chi_squared] = chi_squared (x, var, pdf)

	%Calculate chi_squared
	[~, range] = size(x);
	total = 0;
	for i = 1:range
		if var(i) ~= 0 %ignore whnever the variance is zero - probably just a zero column
			total = total + ((x(i)-pdf(i))^2)/pdf(i);
		elseif var(i) == 0
			if x(i) ~= 0
				fprintf('WARNING: Variance equals zero in a non-zero column: %d\n', i); %warning if not a zero column
			end
		end
	end
	chi_squared = total/range;
	
	
	
	
	
	
	
	
