function [status, msg] = assert_eq(a,b,varargin)
	tol = 0.001;
	type = 'abs';
	if nargin > 2
		tol = varargin{1};
	end;
	if nargin > 3
		type = varargin{2};
	end;
	
	err = norm(a-b);
	switch (type)
		case 'rel'
		if norm(a) > eps
			err = norm(a-b)/norm(a);
		else
			err = 0;
		end;
		
		if err < tol
			msg = 'PASS';
			status = 0;
		else
			msg = sprintf('FAIL. %s err=%f',type, err);
			status = 1;
		end;
		
		case 'abs'
		err = norm(a-b);
		if err < tol
			msg = 'PASS';
			status = 0;
		else
			msg = sprintf('FAIL. %s err=%f',type, err);
			status = 1;
		end;
		
		case 'pairwise_rel'
		errors = abs(a-b)./abs(a);
		%are any of the errors > tol?
		num_errors = sum(errors > tol);
		if num_errors > 0
			status = 1;
			msg = sprintf('FAIL: %d compraisons failed. Relative residuals were:\n',num_errors);
			msg = strcat(msg, '[', sprintf('%f,\n',errors), ']\n');
		else
			status = 0;
			msg = 'PASS';
		end;
		
		case 'pairwise_abs'
		errors = abs(a-b);
		%are any of the errors > tol?
		num_errors = sum(errors > tol);
		if num_errors > 0
			status = 1;
			msg = sprintf('FAIL: %d compraisons failed. Residuals were:\n',num_errors);
			msg = strcat(msg, '[', sprintf('%f,\n',errors), ']\n');
		else
			status = 0;
			msg = 'PASS';
		end;
		
		otherwise
		disp('WARNING: bad tolerance type, falling back to relative');
	end;
	
	
end
