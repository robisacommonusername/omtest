%Lists all the functions and their signatures in an
%m file

%Assumed simple structure is
%$\s*function [?a([ ,]\w)*]?\s*=\s*fn_name\s*\(args\)\n^

function funs = parse_m_file(fn)
	funs = {};
	f = fopen(fn);
	if f == -1
		%file not found
		fprintf('m file %s could not be found\n', fn);
		return;
	end;
	
	line = fgetl(f);
	function_matcher = 'function\s+(\[[^\]]+\]|[^\s=]+)\s*=\s*([\w\d_-]+)\s*(\([^)]*\))?';
	fun_i = 1;
	while ischar(line)
		[tokens] = regexp(line, function_matcher, 'tokens');
		if length(tokens) > 0
			funs(fun_i).name = tokens{1}{2};
			funs(fun_i).ret = parse_rets(tokens{1}{1});
			%might not have captured any function args
			if length(tokens{1}) > 2
				funs(fun_i).args = parse_args(tokens{1}{3});
			else
				funs(fun_i).args = '()';
			end;
			fun_i = fun_i + 1;
		end;
		
		line = fgetl(f);
	end;
	fclose(f);
end;

function arg_arr = parse_args(argstr)
	arg_arr = {};
	len = length(argstr);
	argstr = strtrim(argstr);
	
	if argstr(1) == '(' && argstr(len) == ')'
		argstr = substr(argstr, 2, len-2);
	end;
	if length(argstr) == 0
		return;
	else
		arg_arr = strsplit(argstr, ', ', true);
	end;
end;

function ret_arr = parse_rets(retstr)
	ret_arr = {};
	len = length(retstr);
	retstr = strtrim(retstr);
	
	if retstr(1) == '[' && retstr(len) == ']'
		retstr = substr(retstr, 2, len-2);
	end;
	if length(retstr) == 0
		return;
	else
		ret_arr = strsplit(retstr, ', ;', true);
	end;
end;
