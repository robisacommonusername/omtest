%list the local test functions in a given m file
%exclude the first function
function tests = find_tests(fn)
	if ~strcmp(fn(end-1:end), '.m')
		fn = sprintf('%s.m',fn);
	end;

	test_functions = parse_m_file(fn);
	tests = {};
	for ii = 1:length(test_functions)
		if ii > 1
			tests(ii-1) = test_functions(ii).name;
		end;
	end;
end
