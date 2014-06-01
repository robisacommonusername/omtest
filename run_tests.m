function ret = run_tests(handles, names, varargin)
	STATUS_PASS = 0;
	
	pass_i = 1;
	fail_i = 1;
	passed = {};
	failed = {};
	
	for ii = 1:length(handles)
		f = handles{ii};
		test_name = names{ii};
		[status, msg] = f();
		messages(ii).name = test_name;
		messages(ii).text = msg;
		if (status == STATUS_PASS)
			passed(pass_i).name = test_name;
			passed(pass_i).text = msg;
			pass_i = pass_i + 1;
		else
			failed(fail_i).name = test_name;
			failed(fail_i).text = msg;
			fail_i = fail_i + 1;
		end;
	end;
	
	
	ret.failed = failed;
	ret.passed = passed;
	ret.messages = messages;
end
