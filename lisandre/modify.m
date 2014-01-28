function [data_out]=modify(data_in,group_size)

%takes multiple replica data and adds them together

[rows,cols]=size(data_in);
%if rem(rows,5)~=0  %make sur we have multiple of 5 number of replicas
  %  error('modify: number of replicas is not a multiple of 5');
%end

data_out=zeros(rows/group_size,cols);

for i=1:rows/group_size %add 5 replicas togther
   for j=1:group_size
       data_out(i,:)=data_out(i,:)+data_in(group_size*(i-1)+j,:);
   end
end