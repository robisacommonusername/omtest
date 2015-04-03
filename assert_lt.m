function [status, msg] = assert_lt(a,b,varargin)
	type = 'diff'; %allowed types are diff, mod, norm
	if nargin > 2
		type = varargin{1};
	end;
	
	switch (type)
		case 'diff'
		fails = (b - a) < 0
		status = sum(fails);
		
		case 'mod'
		fails = (abs(b) - abs(a)) < 0
		status = sum(fails);
		
		case 'norm'
		if norm(a) < norm(b)
			status = 0;
		else
			status = 1;
		end
		
		otherwise
		error('Bad comparison type, please specify "diff", "mod" or "norm"');
	end;
	
	if status == 0
		msg = 'PASS';
	else
		msg = 'FAIL';
	end
	
end
