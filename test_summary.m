%Display a summary of pass/fail information for some tests that have
%been run
function test_summary(varargin)
	
	STATUS_PASS = 0;
	
	%Draw table header
	fprintf('%20s|%20s|%20s|\n','test','time','status');
	for ii = 1:80
		fprintf('-');
	end
	fprintf('\n');
	
	ii = 1;
	while ii <= nargin
		group = varargin{ii};
		n = length(group);
		for jj = 1:n
			if group(jj).status == STATUS_PASS
				msg = 'PASS'
			else
				msg = 'FAIL'
			end
			
			fprintf('%20s|%20g|%20s|\n', group(jj).name, group(jj).time, msg);
		end
		
		for jj = 1:80
			fprintf('-');
		end
		fprintf('\n');
		
		ii = ii+1;
	end
end
