function [status, msg] = assert_eq(a,b,varargin)
	tol = 0.001;
	if nargin > 2
		tol = varargin{1};
	end;
	
	if norm(a-b)/norm(a) < tol
		msg = 'PASS';
		status = 0;
	else
		msg = 'FAIL';
		status = 1;
	end;
end
