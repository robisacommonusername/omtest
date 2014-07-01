function [status, msg] = assert_eq(a,b,varargin)
	tol = 0.001;
	type = 'rel';
	if nargin > 2
		tol = varargin{1};
	end;
	if nargin > 3
		type = varargin{2};
	end;
	
	err = norm(a-b)/norm(a);
	switch (type)
		case 'rel'
		err = norm(a-b)/norm(a);
		
		case 'abs'
		err = norm(a-b);
		
		otherwise
		disp('WARNING: bad tolerance type, falling back to relative');
	end;
	
	if err < tol
		msg = 'PASS';
		status = 0;
	else
		msg = 'FAIL';
		status = 1;
	end;
end
