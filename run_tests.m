function ret = run_tests(tests, varargin)
	STATUS_PASS = 0;
	
	%Old style - allow handles and test names to be passed separately
	if nargin > 1
		handles = tests
		names = varargin{1};
	end
	
	pass_i = 1;
	fail_i = 1;
	passed = {};
	failed = {};
	messages = {};
	
	for ii = 1:length(handles)
		if nargin > 1
			f = handles{ii};
			test_name = names{ii};
		else
			f = tests(ii).f;
			test_name = tests(ii).name;
		end
		
		tic;
		[status, msg] = f();
		messages(ii).name = test_name;
		messages(ii).text = msg;
		if (status == STATUS_PASS)
			passed(pass_i).name = test_name;
			passed(pass_i).text = msg;
			passed(pass_i).f = f;
			passed(pass_i).time = toc;
			pass_i = pass_i + 1;
		else
			failed(fail_i).name = test_name;
			failed(fail_i).text = msg;
			failed(fail_i).f = f;
			failed(fail_i).time = toc;
			fail_i = fail_i + 1;
		end;
	end;
	
	
	ret.failed = failed;
	ret.passed = passed;
	ret.messages = messages;
end
