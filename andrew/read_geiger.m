% READ_GEIGER
% Reads data from histogram data written by
% the geiger program provided in the 339 
% Statistics Lab
% Returns: 
% - histograms, number of intervals, period
% Period is in units of seconds
function [matrix,intervals,period] = read_geiger (filename)
fid = fopen (filename);
rows = fscanf (fid,'%d',1);
intervals = fscanf (fid,'%d',1);
cols = fscanf (fid,'%d',1);
period = fscanf (fid,'%f',1);
for R = 1:rows
  row = fscanf(fid,'%d',cols);
  if R == 1
    matrix = row';
  else
    matrix = cat(1,matrix,row');
  end
end
fclose(fid);