function [status, msg] = assert_eq(a,b,vargin)
	tol = 0.001;
	if nargin > 2
		tol = vargin{1};
	end;
	
	if norm(a-b) < tol
		msg = 'PASS';
		status = 0;
	else
		msg = 'FAIL';
		status = 1;
	end;
end
